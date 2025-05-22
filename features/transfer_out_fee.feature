Feature: Determine and Apply Transfer Out Fees

  # This feature outlines the process flow for determining and handling transfer-out fees,
  # including decision points for waiving fees and triggering external fees.

  Scenario: Start the transfer-out fee determination process
    Given I open "Start Event Page" url
    Then I expect page title to be equal "Start Event.4336"

  Scenario: Execute sub-process for transfer-out fee determination
    Given I open "Sub-Process Page" url
    Then I expect page title to be equal "Sub-Process"

  Scenario: Determine transfer-out fee
    Given I open "Transfer Fee Determination Page" url
    Then I expect page title to be equal "Determine Transfer Out Fee"

  Scenario Outline: Determine no charge default scenarios
    Given I open "No Charge Default Scenarios Page" url
    When I type "<criteria>" to "criteria_input"
    Then I expect text of "fee_status_label" to be equal "Waived"

    Examples:
      | criteria                  |
      | BMO to BMO transfers      |
      | Marriage breakdown        |
      | Estates                   |
      | Pension buybacks          |
      | Non-resident transfers    |
      | Residuals                 |
      | Reversals                 |

  Scenario: Waive fee decision
    Given I open "Waive Fee Decision Page" url
    When I click "Waive fee?" text in "decision_options" collection
    Then I expect text of "decision_result_label" to contain "Fee Waived"

  Scenario: Trigger external transfer-out fee
    Given I open "External Transfer Fee Page" url
    When I click "Trigger Fee" text in "action_buttons" collection
    Then I expect text of "fee_status_label" to be equal "$135.00 + tax"

  Scenario Outline: End the transfer-out fee process
    Given I open "<end_event_page>" url
    Then I expect page title to be equal "<end_event_title>"

    Examples:
      | end_event_page                  | end_event_title              |
      | Transfer Out Fee Determined Page | Transfer Out Fee Determined  |
      | Fee Waived Page                  | Fee Waived                   |