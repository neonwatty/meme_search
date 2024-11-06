require "application_system_test_case"

class IndexFilterTest < ApplicationSystemTestCase
  test "visit root and check all results visible" do
    # visit root path
    visit root_path

    # count results
    first_meme_count = all("div[id^='image_core_card_']").count
    assert first_meme_count == 4
  end

  test "visit root, open filters, escape" do
    # visit root
    visit root_path

    # count memes
    first_meme_count = all("div[id^='image_core_card_']").count

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
    assert second_meme_count == first_meme_count
  end

  test "visit root, open filters, click 'Close without filtering' button, return and count" do
    # visit root
    visit root_path

    # count memes
    first_meme_count = all("div[id^='image_core_card_']").count

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
    assert second_meme_count == first_meme_count
  end
end
