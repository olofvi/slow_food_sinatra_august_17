Feature: update the restaurant info
As an owner
In order to update the restaurant's info
I would like to create/change/remove the dishes

Scenario: admin loggs in
  Given I visit the page
  Then I should be logged in as an admin

Scenario: admin accesses the protected page
  Given I visit the protected page
  Then I can click the button 'Create'
  Then show me the page
