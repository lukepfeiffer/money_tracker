Feature: Category

  Need to rewrite to match new functionality
  @js
  Scenario: User Creates category
    Given 1 user
    And I sign in as a user
    When I click link with "modal-trigger" class
    And I fill in "category_name" with "FooBarBaz"
    And I fill in "category_amount" with "20"
    And I press "Create"
    Then I should see "FooBarBaz"
    And I should see "20"

  Scenario: User views category index page
    Given 1 user
    And 1 category
    And that category belongs to that user
    And I sign in as a user
    Then I should see "Foo Bar Baz"
    And I should see "20"

  Scenario: User views archived categories
    Given 1 user
    And 1 category
    And that category belongs to that user
    And I sign in as a user
    When I follow "Archive"
    Then I should not see "FooBarBaz"
    And I should not see "20"

  Scenario: User views archived 
    Given 1 user
    And that user has 1 category
    And that user has 1 archived_category
    When I sign in as a user
    And I follow "Archived"
    Then I should see "Archived Name"
    And I should see "40"
    And I should not see "Some description"
    And I should not see "20"
    And I should not see "Foo Bar Baz"

  # Paycheck default amount is $500
  Scenario: User creates category using paycheck amount
    Given 1 paycheck_user
    And that user has 1 paycheck
    And I sign in as a user
    When I click link with "modal-trigger" class
    And I fill in "category_name" with "FooBarBaz"
    And I fill in "category_description" with "This is a description"
    And I fill in "category_paycheck_percentage" with "30"
    And I press "Create"
    Then I should see "Foo Bar Baz"
    And I should see "This is a description"
    And I should see "150"
