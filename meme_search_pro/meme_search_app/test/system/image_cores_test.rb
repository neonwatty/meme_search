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
    updated_description = "this is a new description"
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

    # record second tag count
    all_tags = all("div[id^='tag_']")
    second_tag_count = all_tags.count

    # ensure +1 tag has been added
    assert second_tag_count = first_tag_count + 1

    # check updated description
    second_description = find("#description-image-core-id-#{@image_core.id}").value
    assert second_description == updated_description

    # ensure path to index
    click_on "Back to memes"
  end

  test "should destroy image core" do
    # start at root
    visit root_path

    # count current memes
    first_meme_count = all("div[id^='image_core_card_']").count

    # visit first meme page
    visit image_core_url(@image_core)
    click_on "Delete"
    assert_selector "div", text: "Meme succesfully deleted!"

    # second meme count
    second_meme_count = all("div[id^='image_core_card_']").count

    # confirm second_meme_count < first_meme_count
    assert second_meme_count == first_meme_count - 1
  end
end
