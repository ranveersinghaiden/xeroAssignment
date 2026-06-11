Feature: Tests for PR: PR-AB44F972

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Successful operation of VehicleAlertsCard.spec
    Given the system is running
      And a valid user session exists
      And the myeroad service is available
    When the client calls VehicleAlertsCard.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Error handling for VehicleAlertsCard.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls VehicleAlertsCard.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Successful operation of ReplayList.spec
    Given the system is running
      And a valid user session exists
      And the myeroad service is available
    When the client calls ReplayList.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Error handling for ReplayList.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls ReplayList.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-AB44F972 @auto-generated
  Scenario: Successful operation of ReplayList
    Given the system is running
      And a valid user session exists
      And the myeroad service is available
    When the client calls ReplayList
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-AB44F972 @auto-generated
  Scenario: Error handling for ReplayList
    Given the system is running
      And an invalid request is prepared
    When the client calls ReplayList
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Successful operation of useGroupedListState.spec
    Given the system is running
      And a valid user session exists
      And the myeroad service is available
    When the client calls useGroupedListState.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-AB44F972 @auto-generated
  Scenario: Error handling for useGroupedListState.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls useGroupedListState.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-AB44F972 @auto-generated
  Scenario: Successful operation of useGroupedListState
    Given the system is running
      And a valid user session exists
      And the myeroad service is available
    When the client calls useGroupedListState
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-AB44F972 @auto-generated
  Scenario: Error handling for useGroupedListState
    Given the system is running
      And an invalid request is prepared
    When the client calls useGroupedListState
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

