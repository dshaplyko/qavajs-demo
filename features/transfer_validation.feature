Feature: Process Flow for Transfer Validation and Outcomes

  # Scenario 1: Start to Good Order Check Completion
  Scenario: Completing Good Order Check with Business Rules Met
    Given I open "Start Event" url
    When I execute "Validate Name" function
    And I execute "Validate Address" function
    And I execute "Validate Account Type" function
    And I execute "Validate SIN" function
    And I execute "Validate Spousal Information" function
    And I execute "Determine Transfer Type" function
    And I execute "Determine Cash/InKind/Mixed" function
    Then I execute "Business Rules Met?" function
    And I expect text of "Outcome" to be equal "Good Order Check Completed"

  Scenario: Completing Good Order Check with Mismatches
    Given I open "Start Event" url
    When I execute "Validate Name" function
    And I execute "Validate Address" function
    And I execute "Validate Account Type" function
    And I execute "Validate SIN" function
    And I execute "Validate Spousal Information" function
    And I execute "Determine Transfer Type" function
    And I execute "Determine Cash/InKind/Mixed" function
    Then I execute "Business Rules Met?" function
    And I execute "Mismatch?" function
    And I expect text of "Outcome" to be equal "Good Order Check Completed"

  # Scenario 2: Automatic Rejection
  Scenario: Automatic Rejection due to Business Rules Not Met
    Given I open "Start Event" url
    When I execute "Validate Name" function
    And I execute "Validate Address" function
    And I execute "Validate Account Type" function
    And I execute "Validate SIN" function
    And I execute "Validate Spousal Information" function
    And I execute "Determine Transfer Type" function
    And I execute "Determine Cash/InKind/Mixed" function
    Then I execute "Business Rules Met?" function
    And I expect text of "Outcome" to be equal "Automatic Rejection"

  # Scenario 3: Handling Mismatches
  Scenario: Handling Mismatches in Validation
    Given I open "Start Event" url
    When I execute "Validate Name" function
    And I execute "Validate Address" function
    And I execute "Validate Account Type" function
    And I execute "Validate SIN" function
    And I execute "Validate Spousal Information" function
    And I execute "Determine Transfer Type" function
    And I execute "Determine Cash/InKind/Mixed" function
    Then I execute "Business Rules Met?" function
    And I execute "Mismatch?" function
    And I expect text of "Outcome" to be equal "Automatic Rejection"

  # Scenario 4: Notes and Annotations
  Scenario: Validating Notes and Annotations
    Given I open "Start Event" url
    When I execute "Validate Name" function
    And I execute "Validate Address" function
    And I execute "Validate Account Type" function
    And I execute "Validate SIN" function
    And I execute "Validate Spousal Information" function
    And I execute "Determine Transfer Type" function
    And I execute "Determine Cash/InKind/Mixed" function
    Then I execute "Business Rules Met?" function
    And I expect text of "Outcome" to contain "Annotations"