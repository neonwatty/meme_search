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
    assert_selector "div#edit_image_core_edit_tags"
    find("#edit_image_core_edit_tags").click
    find("#tag_0").click do
      check("image_core_image_tags_attributes_0_name")
    end
    find("#tag_1").click do
      check("image_core_image_tags_attributes_0_name")
    end
    find("#edit_image_core_edit_tags STOP").click

    # save
    click_on "Save"
    assert_selector "div", text: "Meme succesfully updated!"
    click_on "Back to memes"

    # record second tag count
    all_tags = all("div[id^='tag']")
    second_tag_count = all_tags.count
    puts "first_tag_count --> #{first_tag_count}"
    puts "second_tag_count --> #{second_tag_count}"

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
