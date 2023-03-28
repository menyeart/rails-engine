class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: { message: "your query could not be completed", error: exception.message }, status: :not_found
  end

  def render_not_created_response
    render json: { message: "your query could not be completed", error: "Object creation could not be completed" }, status: 400
  end

  # def render_not_found_response
  #   render json: {
  #     "id": nil,
  #     "name": nil,
  #     "created_at": nil,
  #     "updated_at": nil
  #   }
  # end
end