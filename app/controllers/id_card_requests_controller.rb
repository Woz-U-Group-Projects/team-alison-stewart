require 'open-uri'
require 'addressable/uri'

class IdCardRequestsController < ApplicationController
  # Before filters
  before_filter :ensure_authenticated,    except: [:index]
  before_filter :check_setting,           only: [:find, :new, :create]
  before_filter :fetch_id_card_templates, only: [:find]
  before_filter :fetch_id_card_template,  only: [:new, :create, :update]
  before_filter :fetch_school,            only: [:new, :create, :update]
  before_filter :fetch_subject_data,      only: [:new]
  before_filter :prepare_params,          only: [:create]
  before_filter :fetch_id_card_request,   only: [:show, :edit, :update, :thank_you]

  # Constants
  JUNIOR_API_PATH = '/api/subjects'
  CONFIG          = Rails.application.secrets

  def index
  end

  def find
  end

  def new
    @id_card_request = IdCardRequest.new

    # Attach extra variables
    @id_card_request.id_card_template = @id_card_template
    @id_card_request.school = @school
    @id_card_request.student_name = "#{@subject['last_name']}, #{@subject['first_name']}" if @subject
    @id_card_request.student_number = params[:id_card_request][:student_number]
    @id_card_request.attention_of_email = current_user.email
    @id_card_request.comments.build(user: current_user)

    # Generate all the nodes
    @id_card_template.nodes.order(:position).each do |node|
      new_node = node.dup

      # Generate all the phrases
      node.phrases.each do |phrase|
        new_phrase = phrase.dup

        new_node.phrases << new_phrase
      end

      populate_node(new_node, node)

      @id_card_request.nodes << new_node
    end
  end

  def create
    @id_card_request = IdCardRequest.new(id_card_request_params)

    # Attach school
    @id_card_request.school = @school

    if @id_card_request.save
      # find name fields and normalize name then attach it to the student name field if there is no subject object
      if @id_card_request.student_name.blank?
        @id_card_request.student_name = generate_student_name(@id_card_request)
        @id_card_request.save
      end

      @id_card_request.request!

      redirect_to thank_you_id_card_request_path(@id_card_request.uuid)
    else
      flash[:error] = 'Unable to complete request. Review the errors below.'
      render action: 'new', status: 422
    end
  end

  def edit
  end

  def update
    if @id_card_request.update_attributes(id_card_request_params)
      @id_card_request.request!

      redirect_to id_card_request_path(@id_card_request.uuid)
    else
      flash[:error] = 'Unable to complete request. Review the errors below.'
      render action: 'edit', status: 422
    end
  end

  def show
  end

  def thank_you
  end

  private

  def check_setting
    # Allow admins to always request an id card
    if Setting.show_replace_id_card != '1' && !current_user&.is?(:admin)
      flash[:notice] = 'Sorry, you can not currently request an ID Card.'
      return redirect_to root_path
    end
  end

  def fetch_id_card_templates
    schools = School.all

    # Teachers only have access to their school
    if current_user.is?('teacher') && current_user.school
      schools = [current_user.school]
    end

    @id_card_templates = IdCardTemplate.joins(:school).where('schools.id IN (?)', schools.map(&:id)).order('schools.name')
  end

  def fetch_id_card_template
    @id_card_template = IdCardTemplate.find(params.dig(:id_card_request, :id_card_template_id))
  rescue ActiveRecord::RecordNotFound
    return render_error(404, 'The requested ID card is unavailable.')
  end

  def fetch_school
    @school = @id_card_template.school

    return render_error(404, 'The requested school could not be found.') unless @school
  end

  def fetch_subject_data
    return @subject = nil if params[:id_card_request][:student_number].blank?

    addressable = Addressable::URI.new

    addressable.query_values = {
      subject_number: params[:id_card_request][:student_number],
      gallery_name: @school.name
    }

    uri = "#{CONFIG.junior_api_host}#{JUNIOR_API_PATH}?#{addressable.query}"

    response = open(uri, http_basic_authentication: [CONFIG.junior_api_user, CONFIG.junior_api_password]).read

    subjects = JSON.parse(response)['subjects']

    # Remove the students who doesn't have a photo from the APE Junior API response

    subjects = subjects.select { |subject| subject['photo_url'] != nil }

    @subject = subjects[0]
  end

  def fetch_id_card_request
    @id_card_request = IdCardRequest.find_by_uuid!(params[:id])
  rescue ActiveRecord::RecordNotFound
    return render_error(404)
  end

  def id_card_request_params
    params.require(:id_card_request).permit(
      :id_card_template_id,
      :school_id,
      :student_name,
      :student_number,
      :attention_of,
      :attention_of_email,
      nodes_attributes: [
        :id,
        :type,
        :name,
        :x,
        :y,
        :width,
        :height,
        :font_family,
        :point_size,
        :alignment,
        :uppercase,
        :node_photo,
        :remote_node_photo_url,
        :crop_x,
        :crop_y,
        :crop_width,
        :crop_height,
        :color,
        :junior_field,
        :remote_mask_url,
        phrases_attributes: [
          :id,
          :name,
          :junior_field,
          :prefix,
          :text,
          :suffix,
        ]
      ],
      comments_attributes: [
        :user_id,
        :custom_text,
        :text
      ]
    )
  end

  def populate_node(node, old_node)
    case node.type
    when 'Nodes::Text'
      node.phrases.each do |phrase|
        if @subject
          phrase.text = @subject[node.junior_field] if node.junior_field
          phrase.text = @subject[phrase.junior_field] if phrase.junior_field
          phrase.text = "#{@subject['first_name']} #{@subject['last_name']}" if phrase.name == 'Name (First and Last)'
          phrase.text = "#{@subject['last_name']}, #{@subject['first_name']}" if phrase.name =='Name (Lastname, Firstname)'
          phrase.text = @school.name if phrase.name == 'School Name'
        end
      end
    when 'Nodes::Photo'
      if @subject
        node.remote_node_photo_url = @subject['photo_url']
      else
        node.remote_node_photo_url = node.node_photo_url
      end

      node.remote_mask_url = old_node.mask_url if old_node&.mask_url
    end
  end

  def prepare_params
    # Take uploaded photos over Junior imported photos
    params.dig(:id_card_request, :nodes_attributes)&.each do |node|
      node[1][:remote_node_photo_url] = nil if node[1][:node_photo]
    end

    # Remove blank comments
    params[:id_card_request][:comments_attributes] = nil if params.dig(:id_card_request, :comments_attributes, 0.to_s.to_sym, :text).blank?
  end

  def generate_student_name(id_card_request)
    name_node = id_card_request.nodes.find_by(name: 'Name')

    if name_node && name_node.phrases.count > 1
      # one single name node split into two phrases
      first_name = name_node.phrases.find_by(name: 'First Name').text
      last_name = name_node.phrases.find_by(name: 'Last Name').text
      "#{last_name}, #{first_name}"
    elsif name_node
      # one single name node with one phrase
      name = name_node.phrases.first.text
      normalize_name(name)
    else
      # separate first and last name nodes
      first_name = id_card_request.nodes.find_by(name: 'First Name').phrases.first.text
      last_name = id_card_request.nodes.find_by(name: 'Last Name').phrases.first.text
      "#{last_name}, #{first_name}"
    end
  end

  def normalize_name(name)
    return name.split(' ').reverse.join(', ') unless name.include?(',')
    name
  end
end
