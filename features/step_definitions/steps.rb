Given(/^I visit the site$/) do
  visit '/'
end

Then(/^I should see a message saying "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

Given(/^there is a dish named "([^"]*)" in our database$/) do |dish_name|
  Dish.create(name: dish_name)
end

Given(/^I visit the page$/) do
  visit '/auth/login'
end

Then(/^I should be logged in as an admin$/) do
  fill_in('user[username]', with: 'admin')
  fill_in('user[password]', with: 'admin')
end

Given(/^I visit the protected page$/) do
  visit '/protected'
end

Then(/^I can click the button 'Create'$/) do
  click_link_or_button('Create')
end


Then(/^show me the page$/) do
  save_and_open_page
end

#Then(/^I should see buttons 'Create'$/) do
  #click_link_or_button('Create')
#end
