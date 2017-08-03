Feature: User
  Scenario: User Signs up
    Given I am on the home page
    And I go to the "/users/new" page
    When I fill in "user_email" with "new@email.com"
    And I fill in "user_password" with "password"
    And I fill in "user_password_confirmation" with "password"
    And I press "Sign Up"
    Then I should be on the "/sessions/new" page
    And I should see "Created succesfully, we sent you an email to confirm your account."

  Scenario: User signs in before confirming 
    Given 1 unconfirmed_user
    And I sign in as a user
    Then I should see "User has not been confirmed yet!"

  Scenario: User edits self
    Given 1 user
    And I sign in as a user
    When I follow "Edit"
    And I fill in "user_email" with "new@email.com"
    And I fill in "current_password" with "password"
    And I press "Save"
    Then I should see "User successfully updated!"
    And I should see "Edit user"

  Scenario: User edits self with wrong password
    Given 1 user
    And I sign in as a user
    When I follow "Edit"
    And I fill in "user_email" with "new@email.com"
    And I fill in "current_password" with "wrongpassword"
    And I press "Save"
    Then I should see "Password did not match current user!"
    And I should see "Edit user"

  Scenario: User Signs In
    Given 1 user
    And I am on the home page
    When I fill in "email" with "email@example.com"
    And I fill in "password" with "password"
    And I press "Sign in"
    Then I should be on the "/categories" page
    And I should see "Sign in successful!"


  Scenario: User Signs out
    Given 1 user
    And I sign in as a user
    When I follow "Sign Out"
    Then I should be on the "/sessions/new" page
