require "test_helper"

class MemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meme = memes(:one)
  end

  test "should get index" do
    get memes_url
    assert_response :success
  end

  test "should get new" do
    get new_meme_url
    assert_response :success
  end

  test "should create meme" do
    assert_difference("Meme.count") do
      post memes_url, params: { meme: { description: @meme.description, filename: @meme.filename } }
    end

    assert_redirected_to meme_url(Meme.last)
  end

  test "should show meme" do
    get meme_url(@meme)
    assert_response :success
  end

  test "should get edit" do
    get edit_meme_url(@meme)
    assert_response :success
  end

  test "should update meme" do
    patch meme_url(@meme), params: { meme: { description: @meme.description, filename: @meme.filename } }
    assert_redirected_to meme_url(@meme)
  end

  test "should destroy meme" do
    assert_difference("Meme.count", -1) do
      delete meme_url(@meme)
    end

    assert_redirected_to memes_url
  end
end
