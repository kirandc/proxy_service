class RequestTrack < ApplicationRecord
  validates :url, :request_params, :request_errors, presence: true
end
