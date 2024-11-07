require "application_system_test_case"

class ImagePathsTest < ApplicationSystemTestCase
  test "visiting the index, create a new path, edit it, and delete it" do
    # record first meme count
    visit root_path
    first_meme_count = all("div[id^='image_core_card_']").count

    # visit url directly
    visit settings_image_paths_url
    assert_selector "h1", text: "Current directory paths"

    # navigate via settings --> Paths
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
    fill_in "new_image_path_text_area", with: "example_memes_3"
    click_on "Save"
    sleep(0.25)
    assert_selector "div", text: "Directory path successfully created!"

    # return to root_path and count total memes
    visit root_path
    second_meme_count = all("div[id^='image_core_card_']").count

    # confirm that second_meme_count is +2 more than first
    assert second_meme_count == first_meme_count + 2

    # return to directory paths index
    visit settings_image_paths_url

    # return to tags list
    sleep(0.2)
    divs_with_image_path_id = all("div[id^='image_path_']")
    second_path_count = divs_with_image_path_id.count

    # make sure current path count is +1 of starting path count
    assert second_path_count == first_path_count + 1

    # try (and fail) to create a invalid image path
    # click on "Create New"
    click_on "Create new"
    assert_selector "h1", text: "New directory path"

    # enter name for new tag and create
    fill_in "new_image_path_text_area", with: "not_a_valid_path"
    click_on "Save"
    sleep(0.25)
    assert_selector "div", text: "Invalid directory path!"
    click_on "Back to directory paths"

    # edit path
    click_on "Adjust / delete", match: :first
    sleep(0.2)
    click_on "Edit this directory path"
    sleep(0.2)
    fill_in "new_image_path_text_area", with: "example_memes_3"
    click_on "Save"
    sleep(0.2)
    assert_selector "div", text: "Directory path succesfully updated!"
    click_on "Back to directory paths"
    sleep(0.2)

    # count number of paths
    divs_with_image_path_id = all("div[id^='image_path_']")
    third_path_count = divs_with_image_path_id.count
    assert third_path_count == second_path_count

    # delete path
    click_on "Adjust / delete", match: :first
    sleep(0.2)
    accept_alert do
      click_on "Delete this directory path"
    end
    sleep(0.2)
    assert_selector "div", text: "Directory path successfully deleted!"

    # count number of image paths - assert the same as start
    divs_with_image_path_id = all("div[id^='image_path_']")
    fourth_path_count = divs_with_image_path_id.count
    assert fourth_path_count == first_path_count
  end
end
