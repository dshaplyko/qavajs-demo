Feature: Process Flow Validation

  # Scenario 1: Start Event
  Scenario: Initiate the process
    Given I open "Start Event Page" url
    When I click "Start Process"
    Then I expect current url to contain "First Task"

  # Scenario 2: Validate Address
  Scenario: Validate Address
    Given I open "Validate Address Page" url
    When I type "SPBR.3.1.2" to "task_input"
    And I click "Validate Address"
    Then I expect text of "validation_status" to be equal "Success"

  # Scenario 3: Validate Name
  Scenario: Validate Name
    Given I open "Validate Name Page" url
    When I type "SPBR.3.1.1" to "task_input"
    And I click "Validate Name"
    Then I expect text of "validation_status" to be equal "Success"

  # Scenario 4: Validate Account Type
  Scenario: Validate Account Type
    Given I open "Validate Account Type Page" url
    When I type "SPBR.3.1.3" to "task_input"
    And I click "Validate Account Type"
    Then I expect text of "validation_status" to be equal "Success"

  # Scenario 5: Validate SIN
  Scenario: Validate SIN
    Given I open "Validate SIN Page" url
    When I type "SPBR.3.1.4" to "task_input"
    And I click "Validate SIN"
    Then I expect text of "validation_status" to be equal "Success"

  # Scenario 6: Validate Spousal Information
  Scenario: Validate Spousal Information
    Given I open "Validate Spousal Information Page" url
    When I type "SPBR.3.1.6" to "task_input"
    And I click "Validate Spousal Information"
    Then I expect text of "validation_status" to be equal "Success"

  # Scenario 7: Determine Transfer Type
  Scenario: Determine Transfer Type
    Given I open "Determine Transfer Type Page" url
    When I type "SPBR.3.1.7" to "task_input"
    And I click "Determine Transfer Type"
    Then I expect text of "transfer_type_status" to be equal "Determined"

  # Scenario 8: Determine Cash/InKind/Mixed
  Scenario: Determine Cash/InKind/Mixed
    Given I open "Determine Cash/InKind/Mixed Page" url
    When I type "SPBR.3.1.8" to "task_input"
    And I click "Determine Cash/InKind/Mixed"
    Then I expect text of "transfer_mode_status" to be equal "Determined"

  # Scenario 9: Business Rules Met?
  Scenario Outline: Check if business rules are met
    Given I open "Business Rules Validation Page" url
    When I click "Validate Business Rules"
    Then I expect text of "business_rules_status" to be equal "<status>"

    Examples:
      | status    |
      | Success   |
      | Failure   |

  # Scenario 10: Mismatch?
  Scenario Outline: Check for mismatches
    Given I open "Mismatch Validation Page" url
    When I click "Check Mismatch"
    Then I expect text of "mismatch_status" to be equal "<status>"

    Examples:
      | status              |
      | Automatic Rejection |
      | Good Order Check    |

  # Scenario 11: End Events
  Scenario: End the process
    Given I open "End Event Page" url
    When I click "Complete Process"
    Then I expect text of "process_status" to be equal "Completed"