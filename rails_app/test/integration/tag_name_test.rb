require "test_helper"
require "capybara/minitest"

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
        assert_select "#dropdown_tags" do
          begin
            puts "INFO A"
            assert_select "h1", "Current tags"
            puts "INFO B"
          rescue Minitest::Assertion => e
            puts "Assertion failed: #{e.message}"
            puts page.html  # Print the current HTML of the page
            raise e  # Re-raise the exception to fail the test
          end
        end
      end
    end
  end

end