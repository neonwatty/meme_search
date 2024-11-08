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


  test "vector search, all tags allowed" do
    # visit search path
    visit search_image_cores_path

    # initial count memes
    @first_meme_count = all("div[id^='image_core_card_']").count
    assert @first_meme_count == 0

    # visit root - to update a description
    visit image_cores_url
    @image_core = image_cores(:one)

    # initial image core count
    divs_with_image_core_id = all("div[id^='image_core_']")
    first_core_count = divs_with_image_core_id.count

    # click on first item anywhere
    click_on "generate description 🪄", match: :first
    assert_current_path("/image_cores/#{@image_core.id}")

    # confirm current embeddings for entry do not exist
    first_embeddings_quant = ImageEmbedding.where({ image_core_id: @image_core.id }).length
    assert first_embeddings_quant == 0

    # record initial tag count
    all_tags = all("div[id^='tag_']")
    first_tag_count = all_tags.count
    first_description = find("#description-image-core-id-#{@image_core.id}").value

    # click on update
    click_on "Edit details"

    # update description
    updated_description = "an image saying for now we see through a glass darkly"
    fill_in "image_core_update_description_area", with: updated_description

    # update tags
    assert_selector "div#edit_image_core_edit_tags"
    find("#edit_image_core_edit_tags").click
    find("#tag_1").check

    # click off of tags
    find("#image_core_card_").click

    # save
    click_on "Save"
    assert_selector "div", text: "Meme succesfully updated!"
    assert_current_path("/image_cores/#{@image_core.id}")

    # confirm current embeddings for entry do not exist
    second_embeddings_quant = ImageEmbedding.where({ image_core_id: @image_core.id }).length
    assert second_embeddings_quant > 0

    # return to search path
    visit search_image_cores_path

    # search for single meme by keyword
    query = "darkly"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1

    # flip to vector mode and search
    toggle = find("#search-toggle-div", visible: true)
    toggle.click

    # search for single meme by keyword
    query = "darkly"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1

    # search for single meme by synonym
    query = "black"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1
  end
end
