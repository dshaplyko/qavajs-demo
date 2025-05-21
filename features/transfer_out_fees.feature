Feature: Determine and Apply Transfer Out Fees

  # This feature outlines the process of determining and handling transfer-out fees,
  # including decision points and potential outcomes.

  Scenario: Initiating the transfer-out fee determination process
    Given I open "Transfer Fee Page" url
    When I execute "startTransferFeeProcess" function
    Then I expect text of "process_status" to be equal "Started"

  Scenario: Determining the transfer-out fee based on predefined criteria
    Given I open "Transfer Fee Page" url
    When I execute "determineTransferFee" function
    Then I expect text of "fee_status" to be equal "Calculated"

  Scenario Outline: Evaluating no-charge default scenarios
    Given I open "Transfer Fee Page" url
    When I execute "evaluateNoChargeScenario" function on "<Scenario>"
    Then I expect text of "scenario_status" to contain "No Charge Default"

    Examples:
      | Scenario                          |
      | BMO to BMO transfers              |
      | Marriage breakdown                |
      | Estates                           |
      | Pension buybacks                  |
      | Non-resident to non-resident      |
      | Residuals                         |
      | Reversals                         |

  Scenario: Advisor discretion to waive the fee
    Given I open "Transfer Fee Page" url
    When I uncheck the UI box to waive the fee
    Then I expect text of "fee_status" to be equal "Waived"
    And I understand that this action may impact advisor compensation

  Scenario: Decision point - Waive fee or charge fee
    Given I open "Transfer Fee Page" url
    When I execute "decideWaiveOrChargeFee" function
    Then I expect text of "decision_status" to be equal "<Decision>"

    Examples:
      | Decision |
      | Yes      |
      | No       |

  Scenario: Triggering external transfer-out fee process
    Given I open "Transfer Fee Page" url
    When I execute "triggerExternalFeeProcess" function
    Then I expect text of "fee_status" to be equal "Charged"
    And I expect text of "fee_amount" to be equal "$135.00 + tax"

  Scenario: Process ends with fee waived
    Given I open "Transfer Fee Page" url
    When I execute "endProcess" function
    Then I expect text of "process_outcome" to be equal "Fee Waived"

  Scenario: Process ends with transfer-out fee determined and applied
    Given I open "Transfer Fee Page" url
    When I execute "endProcess" function
    Then I expect text of "process_outcome" to be equal "Transfer Out Fee Determined"