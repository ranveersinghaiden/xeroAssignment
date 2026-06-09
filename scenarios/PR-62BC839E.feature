Feature: Tests for PR: PR-62BC839E

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of FaultsCell.spec
    Given the system is running
      And a valid user session exists
    When the client calls FaultsCell.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for FaultsCell.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls FaultsCell.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of FaultsCell.styles
    Given the system is running
      And a valid user session exists
    When the client calls FaultsCell.styles
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for FaultsCell.styles
    Given the system is running
      And an invalid request is prepared
    When the client calls FaultsCell.styles
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of FaultsCell
    Given the system is running
      And a valid user session exists
    When the client calls FaultsCell
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for FaultsCell
    Given the system is running
      And an invalid request is prepared
    When the client calls FaultsCell
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of enums
    Given the system is running
      And a valid user session exists
    When the client calls enums
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for enums
    Given the system is running
      And an invalid request is prepared
    When the client calls enums
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of faults
    Given the system is running
      And a valid user session exists
    When the client calls faults
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for faults
    Given the system is running
      And an invalid request is prepared
    When the client calls faults
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of faults.spec
    Given the system is running
      And a valid user session exists
    When the client calls faults.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for faults.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls faults.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Successful operation of types
    Given the system is running
      And a valid user session exists
    When the client calls types
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-62BC839E @auto-generated
  Scenario: Error handling for types
    Given the system is running
      And an invalid request is prepared
    When the client calls types
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

