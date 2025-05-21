Feature: Transfer Out Fee Determination
  This feature determines whether a transfer-out fee is applied or waived based on specific criteria.

  Scenario: Start the transfer-out fee determination process
    Given I execute "Start Event.4336" function

  Scenario: Complete the sub-process for transfer-out fee determination
    When I execute "Sub-Process" function
    Then I execute "Determine Transfer Out Fee" function

  Scenario: Determine transfer-out fee
    Given I execute "Calculate Transfer Out Fee" function
    Then I execute "Identify No Charge Scenarios" function
    And I expect the following scenarios to be identified:
      | Scenario                     |
      | BMO to BMO transfers         |
      | Employees                    |
      | Marriage breakdown           |
      | Estates                      |
      | Pension buybacks             |
      | Non-Resident to Non-Resident |
      | Residuals and reversals      |

  Scenario Outline: Decide whether to waive the transfer-out fee
    Given I execute "Waive Fee Decision Gateway" function
    When I execute "{Advisor Decision}" function
    Then I expect the outcome to be "{Outcome}"

    Examples:
      | Advisor Decision | Outcome  |
      | Waive Fee        | Fee Waived |

  Scenario: Trigger external transfer-out fee
    Given I execute "Fee Not Waived" function
    When I execute "Trigger External Transfer Out Fee" function
    Then I expect the customer to be charged "$135.00 + tax"
    And I expect the fee to be applied only after the receiving financial institution accepts the asset list

  Scenario: End the transfer-out fee determination process
    Given I execute "End Process" function
    Then I execute "Transfer Out Fee Determined" function