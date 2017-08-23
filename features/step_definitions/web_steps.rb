When /^I sign in as a user$/ do
  # must have user in the database!!!
  visit "/sessions/new"
  fill_in 'email', with: User.last.email
  fill_in 'password', with: 'password'
  click_button 'Sign in'
end

Then /^I should see this date: "(.+)"$/ do |date|
  date_object = eval(date)
  expect(page).to have_content(date_object.strftime("%-m/%d/%y"))
end

When /^I fill in "(.+)" with this date: "(.+)"$/ do |selector, date|
  date_object = eval(date)
  find(selector).set(date_object.to_s)
end

When /^I check "(.+)"$/ do |selector|
  check(selector)
end

When /^I fill in the trix editor with id of "(.+)" with "(.+)"$/ do |id, value|
  find(:xpath, "//*[@id='#{id}']", visible: false).set(value)
end

When /^I click link with "(.+)" class$/ do |selector|
  find(".#{selector}").click
end

When /^I click the first "(.+)"$/ do |selector|
  first(selector).click
end

When /^I select "(.+)" from "(.+)"$/ do |value, select_tag|
  select value, from: select_tag
end

Given /^I am on the root path$/ do
  visit root_path
end

When /^I go to the "(.+)" page$/ do |path|
  visit path
end

When /^I follow "(.+)"$/ do |link_name|
  click_link link_name
end

When "I debug" do
  require 'pry'; binding.pry;
end

Given "I am on the home page" do
  visit root_path
end

And /^I am on the "(.+)" page$/ do |path|
  visit path
end

When /^I visit history path with start_date param of yesterday$/ do
  visit money_records_path(filter: "other", start_date: (Date.today - 1.day))
end

When /^I fill in "(.+)" with "(.+)"$/ do |field, value|
  fill_in field, with: value
end

When /^I press "(.+)"$/ do |button_name|
  click_button button_name
end

Then /^I should be on the "(.+)" page$/ do |path|
  expect(page.current_path).to eq(path)
end

Then /^I should see "(.+)"$/ do |content|
  expect(page).to have_content(content)
end
Then /^I should not see "(.+)"$/ do |content|
  expect(page).not_to have_content(content)
end
