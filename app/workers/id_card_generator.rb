class IdCardGenerator
  @queue = :high

  def self.perform(params = {})
    id_card_request = IdCardRequest.find(params['id_card_request_id'])

    return unless id_card_request.requested? || id_card_request.errored?

    generate_id_card(id_card_request)
  end

  private

  def self.generate_id_card(id_card_request)
    tmp_images = {}

    # Generate text nodes
    id_card_request.nodes.where(type: 'Nodes::Text').each do |node|
      tmp_images[node.id] = generate_text_node(node)
    end

    # Generate photo nodes
    id_card_request.nodes.where(type: 'Nodes::Photo').each do |node|
      tmp_images[node.id] = generate_photo_node(node) if node.node_photo_url
    end

    result_photo  = combine_nodes(id_card_request, tmp_images)
    result_pdf    = generate_pdf(result_photo)

    id_card_request.result_photo  = File.open(result_photo)
    id_card_request.result_pdf    = File.open(result_pdf)
    id_card_request.save!

    id_card_request.render!
  rescue RuntimeError => message
    id_card_request.error!

    IdCardGeneratorMailer.id_card_generation_failed(id_card_request, message).deliver_now
  ensure
    # Clean up all the tmp images
    tmp_images.each do |key, value|
      File.delete(value)
    end

    result_photo ||= nil
    result_pdf ||= nil

    File.delete(result_photo) if result_photo
    File.delete(result_pdf) if result_pdf
  end

  def self.generate_text_node(node)
    path = tmp_file_for_node(node)

    text = ''

    node.phrases.each do |phrase|
      if phrase.text
        text += phrase.prefix if phrase.prefix
        text += phrase.text
        text += phrase.suffix if phrase.suffix
      end
    end

    return if text.blank?

    # Make it all uppercase if needed
    text = text.upcase if node.uppercase

    # Figure out gravity
    case node.alignment
    when 'left'
      gravity = 'northwest'
    when 'center'
      gravity = 'north'
    when 'right'
      gravity = 'northeast'
    else
      gravity = 'northwest'
    end

    convert = MiniMagick::Tool::Convert.new

    convert.merge! ['-background', 'none']
    convert.merge! ['-size', "#{node.width}x#{node.height}"]
    convert.merge! ['-fill', node.color]
    convert.merge! ['-font', node.font_family]
    convert.merge! ['-gravity', gravity]
    convert.merge! ["label:#{text}"]
    convert << path

    mini_magic_command(convert)

    path
  end

  def self.generate_photo_node(node)
    return unless node.node_photo_url

    path = tmp_file_for_node(node)

    # We must download remote files before cropping / resizing them
    downloaded_photo = MiniMagick::Image::open(node.node_photo_url)
    downloaded_photo.write(path)

    convert = MiniMagick::Tool::Convert.new

    if node.crop_x
      convert.merge! ['-crop', "#{node.crop_width}x#{node.crop_height}+#{node.crop_x}+#{node.crop_y}"]
    else
      convert.merge! ['-crop', '+0+0']
    end

    convert.merge! ['-resize', "#{node.width}x#{node.height}"]

    convert << path
    convert << path

    mini_magic_command(convert)

    # Apply mask if present
    if node.mask_url
      mask_file = "/tmp/mask_#{SecureRandom.uuid}.png"

      # We must download remote mask before using it
      downloaded_mask = MiniMagick::Image::open(node.mask_url)
      downloaded_mask.write(mask_file)

      # Change the mask to be the same size as the image
      path_image = MiniMagick::Image::open(path)

      convert = MiniMagick::Tool::Convert.new

      convert.merge! ['-resize', "#{node.width}x#{node.height}"]
      convert << mask_file
      convert << mask_file

      mini_magic_command(convert)

      # Apply the mask
      convert = MiniMagick::Tool::Convert.new

      convert << path
      convert.merge! ['-matte', mask_file, '-compose', 'DstIn', '-composite']
      convert << path

      mini_magic_command(convert)

      File.delete(mask_file)
    end

    path
  end

  def self.generate_pdf(photo)
    path = "/tmp/node_#{SecureRandom.uuid}.pdf"

    convert = MiniMagick::Tool::Convert.new

    convert << photo
    convert.merge! ['-compress', 'JPEG']
    convert << path

    mini_magic_command(convert)

    path
  end

  def self.tmp_file_for_node(node)
    "/tmp/#{node.type.sub('::', '_')}_#{node.id}.png"
  end

  def self.combine_nodes(id_card_request, tmp_images)
    output = "/tmp/Id_Card_Request_#{id_card_request.id}.jpg"

    # We must download remote files before using them in a composite
    base_photo = MiniMagick::Image::open(id_card_request.id_card_template.base_photo.url)
    base_photo.write(output)

    id_card_request.nodes.each do |node|
      next unless tmp_images[node.id]

      composite = MiniMagick::Tool::Composite.new

      composite.geometry("#{node.width}x#{node.height}+#{node.x}+#{node.y}")

      composite << tmp_images[node.id]
      composite << output
      composite << output

      mini_magic_command(composite)
    end

    output
  end

  def self.mini_magic_command(convert)
    return unless convert

    convert.call do |stdout, stderr, status|
      fail stderr if stderr && stderr.length > 0
    end
  end
end
