module RequestParamsValidator
	PARAMS_TYPE = ['static', 'lite', 'dynamic']
	NUMARIC_REX = /^\d+$/
	
	def validate_params(params)
		errors = {}
		errors.merge!(check_presence('api_id',params[:api_id]))
		errors.merge!(check_presence('type',params[:type]))
		if errors.blank?
			errors.merge!(check_type_include('type', params[:type])) 
			errors.merge!(check_numeric('api_id', params[:api_id]))
		end
    {request_errors: errors, request_params: params} 
	end
	
	def check_presence(value, field)
		value.present? ? {} : {field => "#{field} can't be blank"}
	end

	def check_type_include(field, value)
		PARAMS_TYPE.include?(value) ? {} : {field => "#{field} not present."}
	end

	def check_numeric(field, value)
		(value.present? && value =~ NUMARIC_REX) ? {} : {field => "#{field} not a number."}
	end
end