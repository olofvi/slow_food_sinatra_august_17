Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |input_field, value |
  fill_in input_field, with: value
end

Given(/^I click on "([^"]*)"$/) do |element|
  click_link_or_button element
end

Then(/^I should see message "([^"]*)"$/) do |message|
  expect(page).to have_content message
end

And(/^I fill in all the fields$/) do
  steps %q{
    And I fill in "First name" with "Name"
    And I fill in "Last name" with "Last name"
    And I fill in "Username" with "Thomas"
    And I fill in "Password" with "mypassword"
    And I fill in "Confirm Password" with "mypassword"
    And I fill in "E-mail" with "andreademoja@gmail.com"
    And I fill in "Phone number" with "1234567890"
    And I fill in "Address" with "Holtermansgatan 1d"
  }
end

And(/^I leave all the fields empty$/) do
  steps %q{
    And I fill in "First name" with ""
    And I fill in "Last name" with ""
    And I fill in "Username" with ""
    And I fill in "Password" with ""
    And I fill in "Confirm Password" with ""
    And I fill in "E-mail" with ""
    And I fill in "Phone number" with ""
    And I fill in "Address" with ""
  }
end

And(/^I give wrong password in confirmation$/) do
  steps %q{
    And I fill in "First name" with "Name"
    And I fill in "Last name" with "Last name"
    And I fill in "Username" with "Thomas"
    And I fill in "Password" with "mypassword"
    And I fill in "Confirm Password" with "notmypassword"
    And I fill in "E-mail" with "andreademoja@gmail.com"
    And I fill in "Phone number" with "1234567890"
    And I fill in "Address" with "Holtermansgatan 1d"
  }
end

And(/^The email address user submits is already registered$/) do
  User.create!( username: 'Gianni',
                password: 'passw',
                email: 'somewhere@some.com',
                phone_number: '1234556')
end

Given(/^There is a user called Thomas in our database$/) do
  User.create!(firstname: 'Name',
               lastname: 'last name',
               username: 'Thomas',
               password: 'passw',
               email: 'somewhere@some.com',
               phone_number: '1234556')
end
