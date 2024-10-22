require "test_helper"

class ImageCoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_core = image_cores(:one)
  end

  test "should get index" do
    get image_cores_url
    assert_response :success
  end

  test "should get new" do
    get new_image_core_url
    assert_response :success
  end

  test "should create image_core" do
    assert_difference("ImageCore.count") do
      post image_cores_url, params: { image_core: {} }
    end

    assert_redirected_to image_core_url(ImageCore.last)
  end

  test "should show image_core" do
    get image_core_url(@image_core)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_core_url(@image_core)
    assert_response :success
  end

  test "should update image_core" do
    patch image_core_url(@image_core), params: { image_core: {} }
    assert_redirected_to image_core_url(@image_core)
  end

  test "should destroy image_core" do
    assert_difference("ImageCore.count", -1) do
      delete image_core_url(@image_core)
    end

    assert_redirected_to image_cores_url
  end
end
