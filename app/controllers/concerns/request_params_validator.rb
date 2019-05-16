module RequestParamsValidator
  PARAMS_TYPE = ['static', 'lite', 'dynamic']
  NUMARIC_REX = /^\d+$/

  def rquest_track_params
    # Validate params and return error
    result = validate_params
    # add params present in request
    result.merge!({request_params: params})
    result.merge!({url: request.url})
    result
  end

  # Validate params
  def validate_params
    errors = {}
    # First check api_id and type present in params
    errors.merge!(check_presence('api_id',params[:api_id]))
    errors.merge!(check_presence('type',params[:type]))
    # No error for api_id and type then check other validation
    if errors.blank?
      errors.merge!(check_type_include('type', params[:type])) 
      errors.merge!(check_numeric('api_id', params[:api_id]))
    end
    # Return error if any
    {request_errors: errors}
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

  def redirect_url
    url = URI(REDIRECT_URL)
    url.query = request.url.split("?")[1] || ""
    url.to_s
  end
end