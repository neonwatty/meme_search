require "test_helper"

class ImageTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_tag = image_tags(:one)
  end

  test "should get index" do
    get image_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_image_tag_url
    assert_response :success
  end

  test "should create image_tag" do
    assert_difference("ImageTag.count") do
      post image_tags_url, params: { image_tag: {} }
    end

    assert_redirected_to image_tag_url(ImageTag.last)
  end

  test "should show image_tag" do
    get image_tag_url(@image_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_tag_url(@image_tag)
    assert_response :success
  end

  test "should update image_tag" do
    patch image_tag_url(@image_tag), params: { image_tag: {} }
    assert_redirected_to image_tag_url(@image_tag)
  end

  test "should destroy image_tag" do
    assert_difference("ImageTag.count", -1) do
      delete image_tag_url(@image_tag)
    end

    assert_redirected_to image_tags_url
  end
end
