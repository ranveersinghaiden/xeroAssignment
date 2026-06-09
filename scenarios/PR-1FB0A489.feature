Feature: Tests for PR: PR-1FB0A489

  @api @pr-PR-1FB0A489 @auto-generated
  Scenario: Successful operation of Foo
    Given the system is running
      And a valid user session exists
    When the client calls Foo
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-1FB0A489 @auto-generated
  Scenario: Error handling for Foo
    Given the system is running
      And an invalid request is prepared
    When the client calls Foo
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

