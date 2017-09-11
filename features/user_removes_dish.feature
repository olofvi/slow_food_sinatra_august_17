Feature: Remove dishes from order
As a customer
Because I clicked on wrong dish
I would like to be able to "Remove" dish from order

Background:
  Given There is a user called Thomas in our database
  And I am logged in as Thomas
  And there is a dish named "Carbonara" in our database
  And its dish price is "120" in our database
  And I visit the site
  #Then show me the page
  And There are "2" "Carbonara" in our order


Scenario: User clicks remove a dish
  Given I click "Remove" "Carbonara"
  Then I should see a message saying "Carbonara was removed from your order"
  And my order should contain "0" item
