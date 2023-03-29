class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_error

  def render_not_found_response(exception)
    render json: { message: "your query could not be completed", error: exception.message }, status: :not_found
  end

  def render_not_created_response
    render json: { message: "your query could not be completed", error: "Object creation could not be completed" }, status: 400
  end

  def render_not_updated_response
    render json: { message: "your query could not be completed", error: "Object update could not be completed" }, status: 400
  end

  def bad_params_response
    render json: { message: "your query could not be completed", errors: "Object search could not be completed" }, status: 400
  end

  def render_error(error)
    render json: ErrorSerializer.new(error).serialize, status: 404
  end
end