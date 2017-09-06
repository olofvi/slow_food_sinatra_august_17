Feature: list dishes on index
  As a potential customer (hungry person)
  In order to be able to make a decision on what to eat
  I would like to see a list of available dishes when I visit the site

Scenario: user sees a message if there are no dishes in system
  Given I visit the site
  Then I should see a message saying "There are no dishes in the system"
