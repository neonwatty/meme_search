require "application_system_test_case"

class ImageCoresTest < ApplicationSystemTestCase
  setup do
    @image_core = image_cores(:one)
  end

  test "visiting the index" do
    visit image_cores_url

    # initial image core count
    divs_with_image_core_id = all("div[id^='image_core_']")
    first_core_count = divs_with_image_core_id.count

    # click on first
    click_on "generate description 🪄", match: :first

    # record initial tag count
    all_tags = all("div[id^='tag']")
    first_tag_count = all_tags.count

    # click on update
    click_on "Edit details"

    # update description
    fill_in "image_core_update_description_area", with: "this is a description"

    # update tags
    click_on "edit_image_core_edit_tags"
    click_on "tag_0"

    # save
    click_on "Save"

    assert_selector "div", text: "Invalid directory path!"
    click_on "Back to directory paths"


  end

  test "should create image core" do
    visit image_cores_url
    click_on "New image core"

    click_on "Create Image core"

    assert_text "Image core was successfully created"
    click_on "Back"
  end

  test "should update Image core" do
    visit image_core_url(@image_core)
    click_on "Edit this image core", match: :first

    click_on "Update Image core"

    assert_text "Image core was successfully updated"
    click_on "Back"
  end

  test "should destroy Image core" do
    visit image_core_url(@image_core)
    click_on "Destroy this image core", match: :first

    assert_text "Image core was successfully destroyed"
  end
end
