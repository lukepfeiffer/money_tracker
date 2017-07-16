When /^I sign in as a user$/ do
  # must have user in the database!!!
  visit "/users/new"
  fill_in 'email', with: 'email@example.com'
  fill_in 'password', with: 'password'
  click_button 'Sign in'
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

And /^I am on a show post page$/ do
  visit post_path(Post.last.id)
end

And /^I visit the course show page$/ do
  visit course_path(Course.last.id)
end

And /^I am on the "(.+)" page$/ do |path|
  visit path
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
