Feature: Category

  # Need to rewrite to match new functionality
  # @js
  # Scenario: User Creates category
  #   Given 1 user
  #   And I sign in as a user
  #   When I press "Add Category"
  #   And I fill in "category_name" with "FooBarBaz"
  #   And I fill in "category_amount" with "20"
  #   And I press "Create"
  #   Then I should see "FooBarBaz"
  #   And I should see "20"

  Scenario: User views category index page
    Given 1 user
    And 1 category
    And that category belongs to that user
    And I sign in as a user
    Then I should see "FooBarBaz"
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
    Then I should see "ArchivedName"
    And I should see "Archived Description"
    And I should see "40"
    And I should not see "Some description"
    And I should not see "20"
    And I should not see "FooBarBaz"
