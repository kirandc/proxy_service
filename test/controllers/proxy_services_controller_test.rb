require 'test_helper'

class ProxyServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should be redirect to third party url if no valid params present" do
    get traffic_proxy_services_url
    assert_response :found
  end

  test "should not be track request if proxy false" do
    get traffic_proxy_services_url, params: { proxy: false }
    assert_response :found
  end

  test "should be track request if proxy true" do
    get traffic_proxy_services_url, params: { proxy: true }
    assert_response :success
  end
end
