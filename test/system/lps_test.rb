require "application_system_test_case"

class LpsTest < ApplicationSystemTestCase
  setup do
    @lp = lps(:one)
  end

  test "visiting the index" do
    visit lps_url
    assert_selector "h1", text: "Lps"
  end

  test "should create lp" do
    visit lps_url
    click_on "New lp"

    fill_in "Description", with: @lp.description
    fill_in "Name", with: @lp.name
    click_on "Create Lp"

    assert_text "Lp was successfully created"
    click_on "Back"
  end

  test "should update Lp" do
    visit lp_url(@lp)
    click_on "Edit this lp", match: :first

    fill_in "Description", with: @lp.description
    fill_in "Name", with: @lp.name
    click_on "Update Lp"

    assert_text "Lp was successfully updated"
    click_on "Back"
  end

  test "should destroy Lp" do
    visit lp_url(@lp)
    click_on "Destroy this lp", match: :first

    assert_text "Lp was successfully destroyed"
  end
end
