require "application_system_test_case"

class MemesTest < ApplicationSystemTestCase
  setup do
    @meme = memes(:one)
  end

  test "visiting the index" do
    visit memes_url
    assert_selector "h1", text: "Memes"
  end

  test "should create meme" do
    visit memes_url
    click_on "New meme"

    fill_in "Description", with: @meme.description
    fill_in "Filename", with: @meme.filename
    click_on "Create Meme"

    assert_text "Meme was successfully created"
    click_on "Back"
  end

  test "should update Meme" do
    visit meme_url(@meme)
    click_on "Edit this meme", match: :first

    fill_in "Description", with: @meme.description
    fill_in "Filename", with: @meme.filename
    click_on "Update Meme"

    assert_text "Meme was successfully updated"
    click_on "Back"
  end

  test "should destroy Meme" do
    visit meme_url(@meme)
    click_on "Destroy this meme", match: :first

    assert_text "Meme was successfully destroyed"
  end
end
