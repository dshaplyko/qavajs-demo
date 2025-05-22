Feature: Transfer Out Fee Determination Process

  # This feature describes the process flow for determining and applying transfer-out fees.
  # It includes decision points and outcomes based on whether the fee is waived or not.

  Scenario: Start the Transfer Out Fee Determination Process
    Given I open "Transfer Fee Page" url
    When I execute "Determine Transfer Out Fee" function
    Then I expect "Transfer Fee Page" to be visible

  Scenario: Decision Point - Waive Fee?
    Given I execute "Determine Transfer Out Fee" function
    When I execute "Waive fee?" function
    Then I expect text of "decision_label" to contain "Waive fee?"

  Scenario Outline: Fee Not Waived
    Given I execute "Waive fee?" function on "decision_label"
    When I execute "Trigger External Transfer Out Fee" function
    Then I expect text of "end_event_label" to be equal "Transfer Out Fee Determined"

  Scenario Outline: Fee Waived
    Given I execute "Waive fee?" function on "decision_label"
    When I execute "Fee Waived" function
    Then I expect text of "end_event_label" to be equal "Fee Waived"

  # Additional Notes:
  # - Default System Behavior: The system defaults to charging the fee unless specific criteria are met (e.g., marriage breakdown, estates, pension buybacks, etc.).
  # - Advisors can override this by unchecking a UI box.
  # - Fee Amount: The transfer-out fee is $135.00 + tax, charged only after the receiving financial institution accepts the asset list.