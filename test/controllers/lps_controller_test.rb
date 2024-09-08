require "test_helper"

class LpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lp = lps(:one)
  end

  test "should get index" do
    get lps_url
    assert_response :success
  end

  test "should get new" do
    get new_lp_url
    assert_response :success
  end

  test "should create lp" do
    assert_difference("Lp.count") do
      post lps_url, params: { lp: { description: @lp.description, name: @lp.name } }
    end

    assert_redirected_to lp_url(Lp.last)
  end

  test "should show lp" do
    get lp_url(@lp)
    assert_response :success
  end

  test "should get edit" do
    get edit_lp_url(@lp)
    assert_response :success
  end

  test "should update lp" do
    patch lp_url(@lp), params: { lp: { description: @lp.description, name: @lp.name } }
    assert_redirected_to lp_url(@lp)
  end

  test "should destroy lp" do
    assert_difference("Lp.count", -1) do
      delete lp_url(@lp)
    end

    assert_redirected_to lps_url
  end
end
