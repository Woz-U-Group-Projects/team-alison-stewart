module ActiveAdmin::ViewsHelper
  include BooleanHelper

  def who_do_i_belong_to?
    case request.path
    when /demo_videos/
      :demo_video
    when /id_card_requests/
      :id_card_request
    when /id_card_templates/
      :id_card_template
    when /look_books/
      :look_book
    when /products/
      :product
    when /school/
      :school
    when /services/
      :service
    when /sittings/
      :sitting
    else
      :school
    end
  end

  def file_tag(file_name, file_path, name = nil)
    if RegexHelper::IMAGE_FILE.match(file_name)
      image_tag file_path
    else
      link_name = name || file_name

      link_to link_name, file_name, target: '_blank', class: 'link link--dark link--underlined'
    end
  end
end
