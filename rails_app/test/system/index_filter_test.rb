require "application_system_test_case"

class IndexFilterTest < ApplicationSystemTestCase
  test "visit root and check all results visible" do
    # visit root path
    visit root_path

    # count results
    first_meme_count = all("div[id^='image_core_card_']").count
    assert first_meme_count == 4
  end

  test "visit root, open filters, do not adjust" do
    # visit root
    visit root_path

    # confirm slider is not visible
    assert_selector "div#filters_slideover", visible: false

    # click on "open filters"
    click_on "Open filters"

    # confirm slideover id visible
    assert_selector "div#filters_slideover", visible: true

    # escape out of slideover
    # find("div#filters_slideover").send_keys(:escape)
    page.driver.browser.action.send_keys(:escape).perform

    # confirm slideover is not visible
    assert_selector "div#filters_slideover", visible: false

  end
end