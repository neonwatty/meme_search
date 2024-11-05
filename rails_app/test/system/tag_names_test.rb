require "application_system_test_case"

class TagNamesTest < ApplicationSystemTestCase
  setup do
    @tag_name = tag_names(:one)
  end

  test "visiting the index, create a new tag, edit it, and delete it" do
    # visit url directly
    visit settings_tag_names_url
    assert_selector "h1", text: "Current tags"

    # navigate via settings --> tag_names
    assert_selector "ul#navigation" do
      assert_selector "li#settings" do
        click_on "Settings"
        assert_selector "div", text: "Tags"
        click_on "Tags"
        sleep(0.5)
        assert_selector "h1", text: "Current tags"
      end
    end

    # count total number of original current tags
    divs_with_tag_name_id = all("div[id^='tag_name_']")
    first_tag_count = divs_with_tag_name_id.count

    # click on "Create New" 
    click_on "Create new tag"
    assert_selector "h1", text: "New tag"

    # enter name for new tag and create
    fill_in "new_tag_name_text_area", with: "test_tag"
    click_on "Save"
    sleep(0.25)
    assert_selector "div", text: "Tag successfully created!"

    # return to tags list
    click_on "Back to tags"
    sleep(0.2)
    divs_with_tag_name_id = all("div[id^='tag_name_']")
    second_tag_count = divs_with_tag_name_id.count

    # make sure current tag count is +1 of starting tag count
    assert second_tag_count == first_tag_count + 1

    # edit tag
    click_on "Adjust / delete", match: :first
    sleep(0.2)
    click_on "Edit this tag"
    sleep(0.2)
    fill_in "new_tag_name_text_area", with: "another_test_tag"
    click_on "Save"
    sleep(0.2)
    assert_selector "div", text: "Tag successfully updated!"
    click_on "Back to tags"
    sleep(0.2)

    # count number of tags
    divs_with_tag_name_id = all("div[id^='tag_name_']")
    third_tag_count = divs_with_tag_name_id.count
    assert third_tag_count == second_tag_count

  end

  test "should create tag name" do
    visit tag_names_url
    click_on "New tag name"

    click_on "Create tag"

    assert_text "Tag name was successfully created"
    click_on "Back"
  end

  test "should update Tag name" do
    visit tag_name_url(@tag_name)
    click_on "Edit this tag name", match: :first

    click_on "Update Tag name"

    assert_text "Tag name was successfully updated"
    click_on "Back"
  end

  test "should destroy Tag name" do
    visit tag_name_url(@tag_name)
    click_on "Destroy this tag name", match: :first

    assert_text "Tag name was successfully destroyed"
  end
end
