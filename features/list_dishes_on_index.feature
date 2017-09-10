Feature: list dishes on index
  As a potential customer (hungry person)
  In order to be able to make a decision on what to eat
  I would like to see a list of available dishes when I visit the site

Scenario: user sees a message if there are no dishes in system
  Given I visit the site
  Then I should see a message saying "There are no dishes in the system"

Scenario: user sees info about a dish if the dishes exist in database
  Given there is a dish named "Carbonara" in our database
  And there is a dish named "Bolognese" in our database
  And I visit the site
  Then I should see a message saying "Carbonara"
  And I should see a message saying "Bolognese"
