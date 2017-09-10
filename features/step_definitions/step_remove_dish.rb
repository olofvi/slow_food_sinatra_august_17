Given(/^There are "([^"]*)" "([^"]*)" in our order$/) do |item_count, dish_name|

  dish = Dish.first(name: dish_name)
  order = Order.create!(user: @user)
  order.add_item(dish, dish.price, item_count)
end

Given(/^I click "([^"]*)" "([^"]*)"$/) do |button, dish_name|
  dish = Dish.first(name: dish_name)
  within("#dish_#{dish.id}") do
    click_link_or_button button
  end
end
