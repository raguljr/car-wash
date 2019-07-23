require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get save" do
    get comment_save_url
    assert_response :success
  end

end
