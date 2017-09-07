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
    User.create(user)
  end
end

Given(/^I visit the login page$/) do
  visit '/auth/login'
end

Given(/^I log in as an admin$/) do
  fill_in('user[username]', with: 'admin')
  fill_in('user[password]', with: 'admin')
  click_button('Log In')
end

Given(/^I visit the protected page$/) do
  visit '/protected'
end

And(/^I click the button 'Edit info'$/) do
  click_link_or_button('Edit info')
end

Then(/^show me the page$/) do
  save_and_open_page
end


When(/^I fill the description field$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I submit$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see the message "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end
