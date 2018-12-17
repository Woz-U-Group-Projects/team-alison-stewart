module Api
  module V1
    class IdCardRequestsController < Api::V1::BaseController
      # Before filters
      before_filter :fetch_id_card_request, only: [:update]

      # Scopes
      has_scope :state

      def index
        @id_card_requests = paginate(apply_scopes(IdCardRequest), per_page: PAGE_SIZE)

        render json: @id_card_requests, include: params[:include], status: 200
      end

      def update
        @id_card_request.assign_attributes(id_card_request_params)

        if @id_card_request.save
          render json: @id_card_request, include: params[:include], status: 200
        else
          error_422(nil, @id_card_request.errors)
        end
      end

      def fetch_id_card_request
        @id_card_request = IdCardRequest.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        return error_404
      end

      private

      def id_card_request_params
        params.require(:id_card_request).permit(
          :state
        )
      end
    end
  end
end
