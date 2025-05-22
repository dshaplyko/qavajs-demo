Feature: Determining Transfer Out Fee

  # This feature describes the process of determining whether a transfer-out fee should be applied or waived.

  Scenario: Start the process to determine transfer out fee
    Given I execute "Start Event.4336" function

  Scenario: Evaluate no charge default scenarios
    Given I open "Determine Transfer Out Fee" sub-process
    When I execute "evaluate predefined scenarios for fee waiver" function
      | Scenario                     |
      | BMO to BMO transfers         |
      | Employees                    |
      | Marriage breakdown           |
      | Estates                      |
      | Pension buybacks             |
      | Non-Resident to Non-Resident |
      | Residuals                    |
      | Reversals                    |
    Then I execute "determine fee waiver eligibility" function

  Scenario Outline: Decision to waive the fee
    Given I execute "reach decision gateway Waive fee?" function
    When the decision is "<Decision>"
    Then the process proceeds to "<Outcome>"

    Examples:
      | Decision | Outcome                     |
      | Yes      | Fee Waived                  |
      | No       | Trigger External Transfer   |

  Scenario: Trigger external transfer out fee
    Given I execute "proceed to Trigger External Transfer Out Fee task" function
    When the system charges the customer a transfer-out fee of $135.00 + tax
    Then the fee is charged only after the receiving financial institution accepts the asset list

  Scenario: End the process
    Given I execute "conclude process with Transfer Out Fee Determined" function
