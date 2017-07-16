Feature: User
  Scenario: User Signs up
    Given I am on the home page
    And I follow "Sign Up"
    When I fill in "user_email" with "new@email.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I press "Sign Up"
    Then I should be on the "/" page

#   Scenario: User edits self
#     Given 1 user
#     And I sign in as a user
#     When I follow "View"
#     And I follow "Edit"
#     And I fill in "user_username" with "FooBarBaz"
#     And I press "Edit User"
#     Then I should see "FooBarBaz"

#   Scenario: User views user show page
#     Given 1 user
#     And I sign in as a user
#     When I follow "View"
#     Then I should see "username"
#     And I should see "email@example.com"

  Scenario: User Signs In
    Given 1 user
    And I am on the home page
    And I follow "Sign Up"
    When I fill in "email" with "email@example.com"
    And I fill in "password" with "password"
    And I press "Sign in"
    Then I should be on the "/categories" page

  Scenario: User Signs out
    Given 1 user
    And I sign in as a user
    When I follow "Sign Out"
    Then I should see "Sign Up"
