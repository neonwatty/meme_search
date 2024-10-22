require "application_system_test_case"

class ImagePathsTest < ApplicationSystemTestCase
  setup do
    @image_path = image_paths(:one)
  end

  test "visiting the index" do
    visit image_paths_url
    assert_selector "h1", text: "Image paths"
  end

  test "should create image path" do
    visit image_paths_url
    click_on "New image path"

    fill_in "Image path", with: @image_path.image_path
    click_on "Create Image path"

    assert_text "Image path was successfully created"
    click_on "Back"
  end

  test "should update Image path" do
    visit image_path_url(@image_path)
    click_on "Edit this image path", match: :first

    fill_in "Image path", with: @image_path.image_path
    click_on "Update Image path"

    assert_text "Image path was successfully updated"
    click_on "Back"
  end

  test "should destroy Image path" do
    visit image_path_url(@image_path)
    click_on "Destroy this image path", match: :first

    assert_text "Image path was successfully destroyed"
  end
end
