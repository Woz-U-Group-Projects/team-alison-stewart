module Api
  module V1
    class BaseController < ActionController::Base
      before_action :authenticate

      PAGE_SIZE = 36

      private

      def authenticate
        return true unless Rails.env.staging? || Rails.env.production?

        authenticate_or_request_with_http_basic do |username, password|
          username == Setting.api_user && password == Setting.api_password
        end
      end

      def error_404
        render json: { message: 'Object could not be found.' }, include: params[:include], status: 404
      end

      def error_422(message = nil, errors = {})
        message ||= 'Unable to process request.'

        render json: { message: message, errors: errors }, include: params[:include], status: 422
      end
    end
  end
end
