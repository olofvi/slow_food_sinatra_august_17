Given(/^I am logged in as Thomas$/) do
  @user = User.first(username: 'Thomas')
  login_as @user
end

Given(/^I click "([^"]*)" for "([^"]*)"$/) do |button, dish_name|
  dish = Dish.first(name: dish_name)
  within("#dish_#{dish.id}") do
    click_link_or_button button
  end
end

Then(/^my order should contain "([^"]*)" item$/) do |count|
  order = Order.last
  expect(order.order_items.count).to eq count.to_i
end

Then(/^the total price should be "([^"]*)"$/) do |dish_price|
  order = Order.last
  order_item = OrderItem.last
  expect(order.order_items.count * order_item.price).to eq order.total
end
