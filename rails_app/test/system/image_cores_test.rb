require "application_system_test_case"

class ImageCoresTest < ApplicationSystemTestCase
  setup do
    @image_core = image_cores(:one)
  end

  test "visiting the index" do
    visit image_cores_url
    assert_selector "h1", text: "Image cores"
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
