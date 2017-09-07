Feature: update the restaurant info
As an owner
In order to update the restaurant's info
I would like to add or change restaurant's description

Scenario: admin loggs in
  Given the following users exist:
    | username | password |
    | admin    | admin    |
  Given I visit the login page
  And I log in as an admin
  Then I visit the protected page
  Then show me the page
  When I click the button 'Edit info'
  And I fill the description field
  And I submit
  Then I should see the message "You have successfully updated the description"
