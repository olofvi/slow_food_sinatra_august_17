Feature: Add dishes to order
  As a customer
  In order to get some food
  I would like to press "add to order" to be able to add a dish to my order

Background:
  Given There is a user called Thomas in our database
  And I am logged in as Thomas
  And there is a dish named "Carbonara" in our database
  And its dish price is "120" in our database
  And I visit the site

Scenario: User clicks add for a dish
  Given I click "Add" for "Carbonara"
  Then I should see a message saying "Carbonara was added to your order"
  And my order should contain "1" item
  Given I click "Add" for "Carbonara"
  Then I should see a message saying "Carbonara was added to your order"
  And my order should contain "2" item
  And the total price should be "240"
