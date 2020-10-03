require 'test_helper'

class AdminRatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_rates_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_rates_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_rates_update_url
    assert_response :success
  end

end
