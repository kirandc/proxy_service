class ApplicationController < ActionController::Base
  def render_success(data: {}, status: 200)
    render json: data, status: status
  end

  def render_error(message: nil, status: 422)
    render json: { message: message }, status: status
  end
end
