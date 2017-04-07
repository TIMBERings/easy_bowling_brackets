class ApplicationController < ActionController::API
  before_action :ensure_json_request
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :unprocessable_entity

  def ensure_json_request
    return if request.format == :json
    head :not_acceptable
  end

  def record_not_found
    render json: '404 Not Found', status: :not_found
  end

  def unprocessable_entity(exception)
    render json: {error: exception.message}.to_json, status: :unprocessable_entity
  end
end
