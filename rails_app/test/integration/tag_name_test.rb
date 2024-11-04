require "test_helper"

class TagNameTest < ActionDispatch::IntegrationTest
  setup do
    @tag_name = tag_names(:one)
  end

  test "test 1: route to settings --> tag_names exists and functions" do
    # start at root
    get root_path
    assert_response :success

    # confirm settings li exists in navbar
    assert_select "ul#navigation" do
      assert_select "li#settings"
    end
  end

end