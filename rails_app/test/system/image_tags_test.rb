require "application_system_test_case"

class ImageTagsTest < ApplicationSystemTestCase
  setup do
    @image_tag = image_tags(:one)
  end

  test "visiting the index" do
    visit image_tags_url
    assert_selector "h1", text: "Image tags"
  end

  test "should create image tag" do
    visit image_tags_url
    click_on "New image tag"

    click_on "Create Image tag"

    assert_text "Image tag was successfully created"
    click_on "Back"
  end

  test "should update Image tag" do
    visit image_tag_url(@image_tag)
    click_on "Edit this image tag", match: :first

    click_on "Update Image tag"

    assert_text "Image tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Image tag" do
    visit image_tag_url(@image_tag)
    click_on "Destroy this image tag", match: :first

    assert_text "Image tag was successfully destroyed"
  end
end
