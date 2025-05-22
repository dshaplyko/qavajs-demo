Feature: Process Flow Validations

  Scenario: Start the Process
    Given I open "Start Event" url
    When I execute "Sub-Process" function
    Then I expect current url to contain "Sub-Process"

  Scenario Outline: Good Order Checks
    Given I execute "Good Order Checks" function
    When I execute "Validate Transfer Request" function
    Then I expect text of <validation_field> to contain <validation_result>

    Examples:
      | validation_field       | validation_result |
      | "address_validation"   | "Mismatch Allowed" |
      | "name_validation"      | "Preferred Name"   |
      | "account_type_validation" | "Legislation Met" |
      | "SIN_validation"       | "Flipped SINs"     |
      | "spousal_info_validation" | "Advisor Approved" |

  Scenario: Address Validation
    Given I execute "Validate Address" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "address_validation" to contain "Mismatch Allowed"

  Scenario: Name Validation
    Given I execute "Validate Name" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "name_validation" to contain "Preferred Name"

  Scenario: Account Type Validation
    Given I execute "Validate Account Type" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "account_type_validation" to contain "Legislation Met"

  Scenario: SIN Validation
    Given I execute "Validate SIN" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "SIN_validation" to contain "Flipped SINs"

  Scenario: Spousal Information Validation
    Given I execute "Validate Spousal Information" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "spousal_info_validation" to contain "Advisor Approved"

  Scenario: Determine Transfer Type
    Given I execute "Determine Transfer Type" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "transfer_type_validation" to contain "Valid Transfer Type"

  Scenario: Determine Cash/In-Kind/Mixed
    Given I execute "Determine Cash/In-Kind/Mixed" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "transfer_mode_validation" to contain "Valid Transfer Mode"

  Scenario: Business Rules Validation
    Given I execute "Validate Business Rules" function
    When I execute "Validate Transfer Request" function
    Then I expect text of "business_rules_validation" to contain "Rules Met"

  Scenario: End Events
    Given I execute "Good Order Check Completed" function
    When I execute "Automatic Rejection" function
    Then I expect current url to contain "End Event"