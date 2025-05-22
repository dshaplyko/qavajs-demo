Feature: Process Validation and Transfer Flow

  # Scenario 1: Starting the process and performing initial checks
  Scenario: Start Process
    Given I open "Start Event" url
    When I execute "Sub-Process" function
    Then I execute "Good Order Checks" function
    And I expect "Good Order Checks" (to be visible)

  # Scenario 2: Validation of user and account details
  Scenario Outline: Validation Steps
    Given I execute "Validate <ValidationType>" function
    When mismatches occur
    Then I flag for review

    Examples:
    | ValidationType|
| Address       |
    | Name          |
    | Account Type  |
    | SIN           |
    | Spousal Info  |

  # Scenario 3: Determining transfer details
  Scenario: Determine Transfer Details
    Given I execute "Determine Transfer Type" function
    When I execute "Determine Cash/In-Kind/Mixed" function
    Then I expect "Non-transferable securities" (to be flagged)

  # Scenario 4: Business rules validation
  Scenario: Business Rules Validation
    Given I execute "Business Rules Met?" function
    When mismatches are found
    Then I execute "Automatic Rejection" function
    And I expect "Mismatch" (to be flagged)

  # Scenario 5: Ending the process
  Scenario: End Process
    Given I execute "Good Order Check Completed" function
    When validations are successful
    Then I expect "Process Ended" (to be visible)
    And I execute "Automatic Rejection" function if mismatches persist