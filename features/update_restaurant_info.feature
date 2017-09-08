Feature: update the restaurant info
As an owner
In order to update the restaurant's info
I would like to add or change restaurant's description

Background:
  Given I the following restaurant:
    | name      | description               |
    | FoodTrack | We sell awesome food here |

Scenario: admin loggs in
  Given the following users exist:
    | username | password |
    | admin    | admin    |
  Given I visit the login page
  And I log in as an admin
  Then I visit the protected page
  When I click the button 'Edit info'
  And I fill the description field 'Opening hours'
  And I submit
  Then I should see the message "You have successfully updated the restaurant's description"
