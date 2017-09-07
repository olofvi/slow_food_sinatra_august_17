Given(/^I visit the site$/) do
  visit '/'
end

Then(/^I should see a message saying "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

Given(/^there is a dish named "([^"]*)" in our database$/) do |dish_name|
  Dish.create(name: dish_name)
end

Given(/^its dish price is "([^"]*)" in our database$/) do |dish_price|
  Dish.create(name: dish_price)
end

Then(/^I should se a message saying "([^"]*)"$/) do |message|
  expect(page).to have_content message
end
