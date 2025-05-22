Feature: Transfer-Out Fee Determination Process

  # This feature describes the process flow for determining and handling transfer-out fees.

  Scenario: Start the transfer-out fee determination process
    Given I execute "Transfer-Out Fee Determination" function
    Then I expect text of "process_status_label" to be equal "Start Event ID 4030"

  Scenario: Execute sub-process for fee determination preparation
    Given I execute "Sub-Process Preparation" function on "ID 4000"
    Then I expect text of "sub_process_status_label" to be equal "Preparation Complete"

  Scenario: Calculate transfer-out fee based on predefined criteria
    Given I execute "Determine Transfer Out Fee" function on "ID 4001"
    Then I expect text of "fee_calculation_status_label" to be equal "Fee Calculated"

  Scenario Outline: Identify no-charge default scenarios
    Given I execute "Determine No Charge Default Scenario(s)" function on "ID 4002"
    When the scenario is <scenario_type>
    Then I expect text of "fee_status_label" to be equal "Waived"
    Examples:
      | scenario_type                |
      | BMO to BMO transfers         |
      | Marriage breakdowns          |
      | Estates                      |
      | Pension buybacks             |
      | Non-resident to non-resident |
      | Residuals and reversals      |

  Scenario: Advisor overrides default fee waiver
    Given I execute "Determine No Charge Default Scenario(s)" function on "ID 4002"
    When I click "fee_waiver_checkbox" to uncheck
    Then I expect text of "fee_status_label" to be equal "Not Waived"

  Scenario: Decide whether to waive the fee
    Given I reach the gateway decision point "Waive fee?" with ID 4076
    When the decision is "Yes"
    Then I expect text of "process_status_label" to be equal "Fee Waived Event ID 4115"
    When the decision is "No"
    Then I expect text of "process_status_label" to be equal "Continue to Next Step"

  Scenario: Trigger external transfer-out fee
    Given I execute "Trigger External Transfer Out Fee" function on "ID 4047"
    When the receiving financial institution accepts the asset list
    Then I expect text of "fee_status_label" to be equal "$135.00 + tax Charged"

  Scenario: Finalize the transfer-out fee determination process
    Given I reach the "Transfer Out Fee Determined" end event with ID 4097
    Then I expect text of "process_status_label" to be equal "Fee Finalized"