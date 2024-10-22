require "application_system_test_case"

class TagNamesTest < ApplicationSystemTestCase
  setup do
    @tag_name = tag_names(:one)
  end

  test "visiting the index" do
    visit tag_names_url
    assert_selector "h1", text: "Tag names"
  end

  test "should create tag name" do
    visit tag_names_url
    click_on "New tag name"

    click_on "Create Tag name"

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
