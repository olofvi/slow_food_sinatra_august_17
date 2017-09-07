Given(/^I visit the site$/) do
  visit '/'
end

Then(/^I should see a message saying "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

Given(/^there is a dish named "([^"]*)" in our database$/) do |dish_name|
  Dish.create(name: dish_name)
end

Given(/^I visit the protected page$/) do
  visit '/protected'
  expect(page).to have_content Dish.all
end

Then(/^I should see the update button$/) do
  click_button('update')
end
