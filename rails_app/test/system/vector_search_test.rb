require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  setup do
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
    first_embeddings_quant = ImageEmbedding.where({image_core_id: @image_core.id}).length
    assert first_embeddings_quant == 0

    # record initial tag count
    all_tags = all("div[id^='tag_']")
    first_tag_count = all_tags.count
    first_description = find("#description-image-core-id-#{@image_core.id}").value

    # click on update
    click_on "Edit details"

    # update description
    updated_description = "for now we see through a glass darkly"
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
    second_embeddings_quant = ImageEmbedding.where({image_core_id: @image_core.id}).length
    assert second_embeddings_quant > 0

    # return to search path
    visit search_image_cores_path
  end


  test "keyword search to verify updated description, all tags allowed" do
    # search for single meme by keyword
    query = "darkly"
    fill_in "search-box", with: query
    sleep(0.5)  # search debounce is set to 300 miliseconds - so wait longer
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 1
  end

  test "vector search, all tags allowed" do
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