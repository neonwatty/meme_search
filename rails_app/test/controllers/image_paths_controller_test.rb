require "test_helper"

class ImagePathsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_path = image_paths(:one)
  end

  test "should get index" do
    get image_paths_url
    assert_response :success
  end

  test "should get new" do
    get new_image_path_url
    assert_response :success
  end

  test "should create image_path" do
    assert_difference("ImagePath.count") do
      post image_paths_url, params: { image_path: { image_path: @image_path.image_path } }
    end

    assert_redirected_to image_path_url(ImagePath.last)
  end

  test "should show image_path" do
    get image_path_url(@image_path)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_path_url(@image_path)
    assert_response :success
  end

  test "should update image_path" do
    patch image_path_url(@image_path), params: { image_path: { image_path: @image_path.image_path } }
    assert_redirected_to image_path_url(@image_path)
  end

  test "should destroy image_path" do
    assert_difference("ImagePath.count", -1) do
      delete image_path_url(@image_path)
    end

    assert_redirected_to image_paths_url
  end
end
