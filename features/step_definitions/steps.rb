require 'pry-byebug'

Given(/^I visit the site$/) do
  visit '/'
end

Then(/^I should see a message saying "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

Given(/^there is a dish named "([^"]*)" in our database$/) do |dish_name|
  Dish.create(name: dish_name)
end

Given(/^the following users exist:$/) do |table|
  table.hashes.each do |user|
    User.create!(user)
  end
end

Given(/^I log in as an admin$/) do
  user = User.first(username: 'admin')
  login_as(user)
end

Given(/^I visit the protected page$/) do
  visit '/protected'
end

Then(/^I should see the message "([^"]*)"$/) do |content|
  expect(page).to have_content content
end

Given(/^I have the following restaurant:$/) do |table|
  table.hashes.each do |restaurant|
    Restaurant.create(restaurant)
  end
end

Then(/^I see the updated description on the main page$/) do
  expect(page).to have_content "updated info"
end

Then(/^show me the page$/) do
  save_and_open_page
end
