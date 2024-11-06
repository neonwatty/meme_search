require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  setup do
    # visit search path
    visit search_image_cores_path

    # initial count memes
    @first_meme_count = all("div[id^='image_core_card_']").count
    assert @first_meme_count == 0
  end

  test "keyword search, all tags allowed" do
    # search for single meme by keyword
    query = "fucks"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1

    # search for single meme by keyword
    query = "pills"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1

    # search for single meme by keyword
    query = "weird"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1

    # search for multiple memes by keyword
    query = "image"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 4
  end

  test "keyword search, tag filter allowed" do
    # select tag one
    assert_selector "div#tag_toggle", visible: true
    find("#tag_toggle").click
    find("#tag_1").check
    find("#tag_toggle").click

    # search for single meme by keyword - should not show up as it is tagged with un-selected tag
    query = "fucks"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 0


    # select tag one
    assert_selector "div#tag_toggle", visible: true
    find("#tag_toggle").click
    find("#tag_0").check
    find("#tag_1").uncheck
    find("#tag_toggle").click

    # search for single meme by keyword - should not show up as it is tagged with un-selected tag
    query = "weird"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 0
  end

end