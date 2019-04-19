require 'test_helper'

class WasherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get washer_index_url
    assert_response :success
  end

end
