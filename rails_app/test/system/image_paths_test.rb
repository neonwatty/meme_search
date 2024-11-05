require "application_system_test_case"

class ImagePathsTest < ApplicationSystemTestCase

  test "visiting the index, create a new path, edit it, and delete it" do
    # visit url directly
    visit settings_image_paths_url
    assert_selector "h1", text: "Current directory paths"

    # navigate via settings --> tag_names
    assert_selector "ul#navigation" do
      assert_selector "li#settings" do
        click_on "Settings"
        assert_selector "div", text: "Paths"
        click_on "Paths"
        sleep(0.5)
        assert_selector "h1", text: "Current directory paths"
      end
    end

    # count total number of original current paths
    divs_with_path_name_id = all("div[id^='image_path_']")
    first_path_count = divs_with_path_name_id.count

    # click on "Create New" 
    click_on "Create new"
    assert_selector "h1", text: "New directory path"

    # enter name for new tag and create
    fill_in "new_image_path_text_area", with: "test_path"
    click_on "Save"
    sleep(0.25)
    assert_selector "div", text: "Directory path successfully created!"

    # # return to tags list
    # click_on "Back to tags"
    # sleep(0.2)
    # divs_with_tag_name_id = all("div[id^='tag_name_']")
    # second_tag_count = divs_with_tag_name_id.count

    # # make sure current tag count is +1 of starting tag count
    # assert second_tag_count == first_tag_count + 1

    # # edit tag
    # click_on "Adjust / delete", match: :first
    # sleep(0.2)
    # click_on "Edit this tag"
    # sleep(0.2)
    # fill_in "new_tag_name_text_area", with: "another_test_tag"
    # click_on "Save"
    # sleep(0.2)
    # assert_selector "div", text: "Tag successfully updated!"
    # click_on "Back to tags"
    # sleep(0.2)

    # # count number of tags
    # divs_with_tag_name_id = all("div[id^='tag_name_']")
    # third_tag_count = divs_with_tag_name_id.count
    # assert third_tag_count == second_tag_count

    # # delete tag
    # click_on "Adjust / delete", match: :first
    # sleep(0.2)
    # accept_alert do
    #   click_on "Delete this tag"
    # end
    # sleep(0.2)
    # assert_selector "div", text: "Tag successfully deleted!"

    # # count number of tags - assert the same as start
    # divs_with_tag_name_id = all("div[id^='tag_name_']")
    # fourth_tag_count = divs_with_tag_name_id.count
    # assert fourth_tag_count == first_tag_count

  end
end
