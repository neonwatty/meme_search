require "test_helper"

class TagNameTest < ActionDispatch::IntegrationTest
  setup do
    @tag_name = tag_names(:one)
  end

  test "test 1: route to settings --> tag_names exists and functions" do
    # start at root
    get root_path
    assert_response :success

    # confirm settings li exists in navbar and that Tags exist underneath it
    assert_select "ul#navigation" do
      assert_select "li#settings" do 
        assert_select "#dropdown_tags"
        
        # redirect to tag_names settings page
        assert_current_path [:settings, :tag_names]
      end
    end
  end

end