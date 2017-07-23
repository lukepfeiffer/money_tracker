Feature: Money record
  ## 50.44 is the amount for the default money_record
  ## 30.88 is the amount for the archived_money_record
  ## 10.42 is the amount for the old_money_record
  ## 40.22 is the amount for the other_money_record
  Scenario: User views money records
    Given 1 user
    And that user has 1 category
    And that category has 1 money_record
    And I sign in as a user
    When I follow "History"
    Then I should see "50.44"

  Scenario: User views active money_records
    Given 1 user
    And that user has 1 category
    And that category has 1 money_record
    And that user has 1 archived_category
    And that archived_category has 1 archived_money_record
    When I sign in as a user
    And I follow "History"
    And I follow "Active Records"
    Then I should see "50.44"
    And I should not see "30.88"

  @js
  Scenario: User views active money_records in date range
    Given 1 user
    And that user has 1 category
    And that category has 1 money_record
    And that category has 1 old_money_record
    When I sign in as a user
    And I visit history path with start_date param of yesterday
    Then I should see "50.44"
    And I should not see "10.42"
