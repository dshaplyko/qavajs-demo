Feature: Transfer Out Fee Process
  This feature describes the scenarios for determining and applying transfer-out fees based on various conditions.

  Scenario: Start Process
    Given I open "Transfer Fee Page" url
    When I execute "Determine Transfer Out Fee" function
    And I execute "Determine No Charge Default Scenario(s)" function
    Then I execute "Trigger External Transfer Out Fee" function
    And I expect text of "process_status_label" to be equal "Transfer Out Fee Determined"

  Scenario: Waive Fee
    Given I open "Transfer Fee Page" url
    When I execute "Determine Transfer Out Fee" function
    And I execute "Determine No Charge Default Scenario(s)" function
    Then I execute "Waive Fee Decision" function
    And I expect text of "process_status_label" to (be equal|contain) "Fee Waived"

  Scenario: Advisor Discretion
    Given I open "Transfer Fee Page" url
    When I execute "Determine Transfer Out Fee" function
    And I type "specific criteria" to "advisor_discretion_input"
    Then I execute "Waive Fee Decision" function
    And I expect text of "process_status_label" to (be equal|contain) "Fee Waived"

  Scenario: System Defaults
    Given I open "Transfer Fee Page" url
    When I execute "System Default Action" function
    Then I execute "Waive Fee Decision" function
    And I expect text of "process_status_label" to (be equal|contain) "Fee Waived"

  Scenario: External Transfer Fee
    Given I open "Transfer Fee Page" url
    When I execute "Determine Transfer Out Fee" function
    Then I execute "Trigger External Transfer Out Fee" function
    And I expect text of "process_status_label" to be equal "Transfer Out Fee Determined"