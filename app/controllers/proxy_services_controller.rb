class ProxyServicesController < ApplicationController
  include RequestParamsValidator
  before_action :check_proxy, only: :traffic

  # root api for app
  def index
    render_success(data: {message: "success"})
  end

  #this action used to track request
  def traffic
    request_track = RequestTrack.new(rquest_track_params)
    if request_track.save
      render_success(data: {message: "Request track saved successfully."})
    else
      render_error(message: "Error to save request track.")
    end
  end

  private

  def check_proxy
    unless ['true', true].include?(params[:proxy])
      redirect_to redirect_url
    end
  end
end
