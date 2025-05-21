Feature: Determine and Handle Transfer Out Fees
  # This feature describes the process of determining and applying transfer-out fees, including decision points and outcomes.

  Scenario: Initiating the transfer-out fee determination process
    Given I start the process to determine the transfer-out fee

  Scenario: Determining the transfer-out fee based on predefined criteria
    When I determine the transfer-out fee
    Then the fee should be calculated based on predefined criteria

  Scenario: Evaluating no-charge default scenarios
    Given I evaluate the scenario for no-charge default
    Then the system should identify if the scenario qualifies for:
      | Scenario                          |
      | BMO to BMO transfers              |
      | Marriage breakdown                |
      | Estates                           |
      | Pension buybacks                  |
      | Non-resident to non-resident      |
      | Residuals                         |
      | Reversals                         |

  Scenario: Default system behavior for charging fees
    Given the system defaults to charging a fee
    When the advisor unchecks the UI box to waive the fee
    Then the fee should be waived
    And the advisor's compensation may be impacted

  Scenario Outline: Decision to waive the transfer-out fee
    Given the system evaluates the decision to waive the fee
    When the decision is "<Decision>"
    Then the outcome should be "<Outcome>"

    Examples:
      | Decision | Outcome                     |
      | Yes      | Fee is waived               |
      | No       | Fee is charged              |

  Scenario: Triggering the external transfer-out fee process
    Given the fee is not waived
    When the receiving financial institution accepts the asset list
    Then the system triggers the external transfer-out fee process
    And the customer is charged $135.00 + tax

  Scenario: Ending the process with fee waived
    Given the fee is waived
    Then the process ends with the fee waived

  Scenario: Ending the process with transfer-out fee determined
    Given the transfer-out fee is determined and applied
    Then the process ends with the fee applied