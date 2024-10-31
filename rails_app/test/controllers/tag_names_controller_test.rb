require "test_helper"

class TagNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_name = tag_names(:one)
  end

  test "should get index" do
    get tag_names_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_name_url
    assert_response :success
  end

  test "should create tag_name" do
    assert_difference("TagName.count") do
      post tag_names_url, params: { tag_name: {} }
    end

    assert_redirected_to tag_name_url(TagName.last)
  end

  test "should show tag_name" do
    get tag_name_url(@tag_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_name_url(@tag_name)
    assert_response :success
  end

  test "should update tag_name" do
    patch tag_name_url(@tag_name), params: { tag_name: {} }
    assert_redirected_to tag_name_url(@tag_name)
  end

  test "should destroy tag_name" do
    assert_difference("TagName.count", -1) do
      delete tag_name_url(@tag_name)
    end

    assert_redirected_to tag_names_url
  end
end
