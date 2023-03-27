class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: { message: "your query could not be completed", error: exception.message }, status: :not_found
  end
end
