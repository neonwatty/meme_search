require "application_system_test_case"

class IndexFilterTest < ApplicationSystemTestCase
  setup do
    # visit root
    visit root_path

    # initial count memes
    @first_meme_count = all("div[id^='image_core_card_']").count
    assert @first_meme_count == 4
  end

  test "visit root, open filters, escape" do
    # confirm slider is not visible
    assert_selector "div#filters_slideover", visible: false

    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # escape out of slideover
    page.driver.browser.action.send_keys(:escape).perform

    # confirm slideover is not visible
    assert_selector "div#filters_slideover", visible: false

    # re-count memes and confirm count
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == @first_meme_count
  end

  test "visit root, open filters, click 'Close without filtering' button, return and count" do
    # confirm slider is not visible
    assert_selector "div#filters_slideover", visible: false

    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # click on close button
    click_on "Close without filtering"

    # confirm slideover is not visible
    assert_selector "div#filters_slideover", visible: false

    # confirm meme count unchanged
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == @first_meme_count
  end

  test "visit root, open filters, check all tags, return and verify changes" do
    # confirm slider is not visible
    assert_selector "div#filters_slideover", visible: false

    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # select tag one
    assert_selector "div#tag_toggle", visible: true
    find("#tag_toggle").click
    find("#tag_0").check
    find("#tag_1").check
    find("#has_embeddings_checkbox").uncheck
    # assert_selector "farts"

    # apply filters
    click_on "Apply filters"

    # count memes - should have minus 1 from start
    sleep(0.2)
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == @first_meme_count - 1
  end

  test "visit root, open filters, check one tag, return and verify changes" do
    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # select tag one
    assert_selector "div#tag_toggle", visible: true
    find("#tag_toggle").click
    find("#tag_0").check
    find("#tag_toggle").click
    find("#has_embeddings_checkbox").uncheck

    # apply filters
    click_on "Apply filters"

    # count memes - should have minus 2 from start
    sleep(0.2)
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == @first_meme_count - 2
  end

  test "visit root, open filters, (keep) embeddings checked, return and verify changes" do
    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # apply filters
    click_on "Apply filters"

    # count memes - no memes have embeddings on init
    sleep(0.2)
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == 0
  end

  test "visit root, open filters, check one directory path, return and verify changes" do
    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # select path one
    assert_selector "div#path_toggle", visible: true
    find("#path_toggle").click
    find("#path_1").uncheck
    find("#path_toggle").click
    find("#has_embeddings_checkbox").uncheck

    # apply filters
    click_on "Apply filters"

    # count memes - no memes have embeddings on init
    sleep(0.2)
    second_meme_count = all("div[id^='image_core_card_']").count
    assert second_meme_count == @first_meme_count - 2
  end
end
