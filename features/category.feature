Feature: Category

  Need to rewrite to match new functionality
  @js
  Scenario: User Creates category
    Given 1 user
    And I sign in as a user
    When I click link with "create_category" class
    And I fill in "category_name" with "FooBarBaz"
    And I fill in "category_amount" with "20"
    And I click link with "create-category" class
    Then I should see "FooBarBaz"
    And I should see "20"

  Scenario: User views category index page
    Given 1 user
    And that user has 1 category
    And that category belongs to that user
    And I sign in as a user
    Then I should see "Foo Bar Baz"
    And I should see "20"

  Scenario: User views archived categories
    Given 1 user
    And that user has 1 category
    And that category has 1 money_record
    And that user has 1 archived_category
    And that archived_category has 1 archived_money_record
    And that category belongs to that user
    And I sign in as a user
    When I follow "Archive"
    And I should see "Archived Name"
    Then I should see "40"
    And I should see "30.88"
    And I should not see "Foo Bar Baz"
    And I should not see "20"
    And I should not see "50.44"

  # Paycheck default amount is $500
  Scenario: User creates category using paycheck amount
    Given 1 paycheck_user
    And that user has 1 paycheck
    And I sign in as a user
    When I click link with "create_category" class
    And I fill in "category_name" with "FooBarBaz"
    And I fill in "category_description" with "This is a description"
    And I fill in "category_paycheck_percentage" with "30"
    And I click link with "create-category" class
    Then I should see "Foo Bar Baz"
    And I should see "This is a description"
    And I should see "150"

  # Default category percentage is 20
  Scenario: User autopopulates amounts of categories
    Given 1 paycheck_user
    And that user has 1 paycheck_category
    And I sign in as a user
    When I click link with "add_paycheck" class
    And I fill in "paycheck_amount" with "400"
    And I click link with "create-paycheck" class
    Then I should see "80"

  @javascript
  Scenario: Filter money records by categories
    Given 1 user
    And that user has 1 category
    And that category has 1 money_record
    And that user has 1 other_category
    And that other_category has 1 other_money_record
    And I sign in as a user
    When I click the first ".item"
    Then I should see "50.44"
    And I should not see "40.22"
