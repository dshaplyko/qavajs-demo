Feature: Determine and Apply Transfer Out Fees

  # Scenario 1: Start Process
  Scenario: Start the process and determine transfer-out fee
    Given I execute "Start Event.4336" function
    When I execute "Determine Transfer Out Fee" function
    And I execute "Determine No Charge Default Scenario(s)" function
    Then I execute "Waive Fee Decision" function
    And I expect text of "Fee Status" to be equal "Fee Waived"

  Scenario: Fee is not waived and external transfer-out fee is triggered
    Given I execute "Waive Fee Decision" function
    When I execute "Trigger External Transfer Out Fee" function
    Then I expect text of "Process Status" to be equal "Transfer Out Fee Determined"

  # Scenario 2: Trigger External Transfer Out Fee
  Scenario: Trigger external transfer-out fee
    Given I execute "Trigger External Transfer Out Fee" function
    Then I expect text of "Process Status" to be equal "Transfer Out Fee Determined"

  # Scenario 3: Waive Fee
  Scenario: Waive fee based on decision
    Given I execute "Waive Fee Decision" function
    Then I expect text of "Fee Status" to be equal "Fee Waived"

  # Scenario 4: System Defaults
  Scenario Outline: System defaults to charge fee unless criteria are met
    Given I execute "System Defaults" function
    When the criteria include <Criteria>
    Then I expect text of "Fee Status" to be equal "Fee Waived"

    Examples:
      | Criteria                  |
      | Marriage breakdown        |
      | Estates                   |
      | Pension buybacks          |

  # Scenario 5: Advisor Action
  Scenario: Advisor decides to waive the fee
    Given I execute "Advisor Decision" function
    When the advisor chooses to waive the fee
    Then I expect text of "Fee Status" to be equal "Fee Waived"

  Scenario: Advisor keeps the default UI box checked
    Given I execute "Advisor Decision" function
    When the advisor does not waive the fee
    Then I expect text of "Fee Status" to be equal "Fee Charged"
    And I expect text of "Process Status" to be equal "Asset List Accepted"