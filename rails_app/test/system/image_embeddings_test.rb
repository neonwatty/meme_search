require "application_system_test_case"

class ImageEmbeddingsTest < ApplicationSystemTestCase
  setup do
    @image_embedding = image_embeddings(:one)
  end

  test "visiting the index" do
    visit image_embeddings_url
    assert_selector "h1", text: "Image embeddings"
  end

  test "should create image embedding" do
    visit image_embeddings_url
    click_on "New image embedding"

    click_on "Create Image embedding"

    assert_text "Image embedding was successfully created"
    click_on "Back"
  end

  test "should update Image embedding" do
    visit image_embedding_url(@image_embedding)
    click_on "Edit this image embedding", match: :first

    click_on "Update Image embedding"

    assert_text "Image embedding was successfully updated"
    click_on "Back"
  end

  test "should destroy Image embedding" do
    visit image_embedding_url(@image_embedding)
    click_on "Destroy this image embedding", match: :first

    assert_text "Image embedding was successfully destroyed"
  end
end
