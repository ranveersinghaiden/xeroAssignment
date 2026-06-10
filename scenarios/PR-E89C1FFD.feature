Feature: Tests for PR: PR-E89C1FFD

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of selectorHelpers.spec
    Given the system is running
      And a valid user session exists
    When the client calls selectorHelpers.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for selectorHelpers.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls selectorHelpers.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of replayVideoEventReducer.spec
    Given the system is running
      And a valid user session exists
    When the client calls replayVideoEventReducer.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for replayVideoEventReducer.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls replayVideoEventReducer.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of replayVideoEventReducer
    Given the system is running
      And a valid user session exists
    When the client calls replayVideoEventReducer
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for replayVideoEventReducer
    Given the system is running
      And an invalid request is prepared
    When the client calls replayVideoEventReducer
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of types
    Given the system is running
      And a valid user session exists
    When the client calls types
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for types
    Given the system is running
      And an invalid request is prepared
    When the client calls types
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of actions
    Given the system is running
      And a valid user session exists
    When the client calls actions
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for actions
    Given the system is running
      And an invalid request is prepared
    When the client calls actions
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of api.spec
    Given the system is running
      And a valid user session exists
    When the client calls api.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for api.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls api.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of api
    Given the system is running
      And a valid user session exists
    When the client calls api
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for api
    Given the system is running
      And an invalid request is prepared
    When the client calls api
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of dismissEventReducer.spec
    Given the system is running
      And a valid user session exists
    When the client calls dismissEventReducer.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for dismissEventReducer.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls dismissEventReducer.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of dismissEventReducer
    Given the system is running
      And a valid user session exists
    When the client calls dismissEventReducer
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for dismissEventReducer
    Given the system is running
      And an invalid request is prepared
    When the client calls dismissEventReducer
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of replayEventRecordReducer.spec
    Given the system is running
      And a valid user session exists
    When the client calls replayEventRecordReducer.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for replayEventRecordReducer.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls replayEventRecordReducer.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of replayEventRecordReducer
    Given the system is running
      And a valid user session exists
    When the client calls replayEventRecordReducer
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for replayEventRecordReducer
    Given the system is running
      And an invalid request is prepared
    When the client calls replayEventRecordReducer
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of undoEventActionSaga.spec
    Given the system is running
      And a valid user session exists
    When the client calls undoEventActionSaga.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for undoEventActionSaga.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls undoEventActionSaga.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of undoEventActionSaga
    Given the system is running
      And a valid user session exists
    When the client calls undoEventActionSaga
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for undoEventActionSaga
    Given the system is running
      And an invalid request is prepared
    When the client calls undoEventActionSaga
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of watcher
    Given the system is running
      And a valid user session exists
    When the client calls watcher
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for watcher
    Given the system is running
      And an invalid request is prepared
    When the client calls watcher
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of selectors.spec
    Given the system is running
      And a valid user session exists
    When the client calls selectors.spec
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @ui @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for selectors.spec
    Given the system is running
      And an invalid request is prepared
    When the client calls selectors.spec
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of selectors
    Given the system is running
      And a valid user session exists
    When the client calls selectors
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for selectors
    Given the system is running
      And an invalid request is prepared
    When the client calls selectors
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Successful operation of types
    Given the system is running
      And a valid user session exists
    When the client calls types
    Then response status is 200
      And response body contains expected data
      And operation completes within 2000ms

  @api @pr-PR-E89C1FFD @auto-generated
  Scenario: Error handling for types
    Given the system is running
      And an invalid request is prepared
    When the client calls types
    Then response status is 4xx or 5xx
      And error message is descriptive
    And And the error is logged

