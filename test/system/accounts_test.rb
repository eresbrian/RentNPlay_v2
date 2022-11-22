require "application_system_test_case"

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
  end

  test "visiting the index" do
    visit accounts_url
    assert_selector "h1", text: "Accounts"
  end

  test "should create account" do
    visit accounts_url
    click_on "New account"

    fill_in "Email", with: @account.email
    fill_in "Full name", with: @account.full_name
    fill_in "Mobile number", with: @account.mobile_number
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    fill_in "User type", with: @account.user_type
    fill_in "Username", with: @account.username
    click_on "Create Account"

    assert_text "Account was successfully created"
    click_on "Back"
  end

  test "should update Account" do
    visit account_url(@account)
    click_on "Edit this account", match: :first

    fill_in "Email", with: @account.email
    fill_in "Full name", with: @account.full_name
    fill_in "Mobile number", with: @account.mobile_number
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    fill_in "User type", with: @account.user_type
    fill_in "Username", with: @account.username
    click_on "Update Account"

    assert_text "Account was successfully updated"
    click_on "Back"
  end

  test "should destroy Account" do
    visit account_url(@account)
    click_on "Destroy this account", match: :first

    assert_text "Account was successfully destroyed"
  end
end
