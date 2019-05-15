class ProxyServicesController < ApplicationController
	include RequestParamsValidator
	before_action :check_proxy, only: :traffic

	def index
		render plain: "OK"
	end

	def traffic
		result = validate_params(params)
		result.merge!({url: request.url})
		RequestTrack.create!(result)
		render plain: "Request track successfully."
	end

	private

	def check_proxy
		if ['false', false, nil].include?(params[:proxy])
			redirect_url = "https://www.mocky.io/v2/5185415ba171ea3a00704eed/?"
			req_params = request.fullpath.split("?")[1] || ""
			url = redirect_url + req_params
			redirect_to url 
		end
	end
end
