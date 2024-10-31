require "test_helper"

class ImageEmbeddingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_embedding = image_embeddings(:one)
  end

  test "should get index" do
    get image_embeddings_url
    assert_response :success
  end

  test "should get new" do
    get new_image_embedding_url
    assert_response :success
  end

  test "should create image_embedding" do
    assert_difference("ImageEmbedding.count") do
      post image_embeddings_url, params: { image_embedding: {} }
    end

    assert_redirected_to image_embedding_url(ImageEmbedding.last)
  end

  test "should show image_embedding" do
    get image_embedding_url(@image_embedding)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_embedding_url(@image_embedding)
    assert_response :success
  end

  test "should update image_embedding" do
    patch image_embedding_url(@image_embedding), params: { image_embedding: {} }
    assert_redirected_to image_embedding_url(@image_embedding)
  end

  test "should destroy image_embedding" do
    assert_difference("ImageEmbedding.count", -1) do
      delete image_embedding_url(@image_embedding)
    end

    assert_redirected_to image_embeddings_url
  end
end
