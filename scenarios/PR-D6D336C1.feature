Feature: Tests for PR: PR-D6D336C1

  @api @regression
  Scenario: Validate DriverLogonCardTableColumnDefinitions API functionality
    Given the DriverLogonCardTableColumnDefinitions API is available
    When a request is made to retrieve column definitions
    Then the response should include valid column definitions
      And the response status code should be 200

  @ui @regression
  Scenario: Verify DateTimeLogonCell UI rendering
    Given the DateTimeLogonCell component is displayed on the dashboard
    When the component is loaded with valid data
    Then the date and time should be displayed correctly
      And the format should match the expected pattern

  @api @regression
  Scenario: Validate DateTimeLogonCell API functionality
    Given the DateTimeLogonCell API is available
    When a request is made to retrieve date and time data
    Then the response should include valid date and time information
      And the response status code should be 200

  @api @regression
  Scenario: Validate DriverCell API functionality
    Given the DriverCell API is available
    When a request is made to retrieve driver information
    Then the response should include valid driver details
      And the response status code should be 200

  @api @regression
  Scenario: Validate LocationCell API functionality
    Given the LocationCell API is available
    When a request is made to retrieve location data
    Then the response should include valid location details
      And the response status code should be 200

  @api @regression
  Scenario: Validate StatusCell API functionality
    Given the StatusCell API is available
    When a request is made to retrieve status information
    Then the response should include valid status details
      And the response status code should be 200

  @api @regression
  Scenario: Validate DataRetention API functionality
    Given the DataRetention API is available
    When a request is made to retrieve data retention policies
    Then the response should include valid retention policy details
      And the response status code should be 200

  @api @regression
  Scenario: Validate DataRetentionPeriodUpdateModal API functionality
    Given the DataRetentionPeriodUpdateModal API is available
    When a request is made to update the data retention period
    Then the response should confirm the update was successful
      And the response status code should be 200

  @api @regression
  Scenario: Validate OfflineNotifications API functionality
    Given the OfflineNotifications API is available
    When a request is made to retrieve offline notification settings
    Then the response should include valid notification settings
      And the response status code should be 200

  @ui @regression
  Scenario: Verify API UI rendering
    Given the API UI component is displayed on the dashboard
    When the component is loaded with valid data
    Then the API details should be displayed correctly
      And the format should match the expected pattern

  @api @regression
  Scenario: Validate API functionality
    Given the API is available
    When a request is made to retrieve API details
    Then the response should include valid API information
      And the response status code should be 200

  @api @regression
  Scenario: Validate SettingsToggle API functionality
    Given the SettingsToggle API is available
    When a request is made to toggle a setting
    Then the response should confirm the setting was toggled successfully
      And the response status code should be 200

  @api @regression
  Scenario: Validate types API functionality
    Given the types API is available
    When a request is made to retrieve type definitions
    Then the response should include valid type definitions
      And the response status code should be 200

