Feature: Tests for PR: PR-D6D336C1

  @VSF-3500
  Scenario: Display driver logon details in the Dashcam Health Page
    Given the user is on the Dashcam Health Page
    When the system fetches driver logon details
    Then the Driver Logon Card Table displays the driver logon details
      And the DateTimeLogonCell shows the correct logon time
      And the DriverCell displays the driver's name
      And the LocationCell shows the driver's location
      And the StatusCell reflects the driver's current status

  @VSF-3500
  Scenario: Update data retention period in Dashcam settings
    Given the user navigates to the Dashcam Setting Drawer
    When the user opens the Data Retention settings
      And the user updates the data retention period in the DataRetentionPeriodUpdateModal
    Then the system saves the updated data retention period
      And the updated retention period is displayed in the Data Retention settings

  @VSF-3500
  Scenario: Configure offline notifications for dashcams
    Given the user navigates to the Dashcam Setting Drawer
    When the user opens the Offline Notifications settings
      And the user enables or disables the offline notification toggle
    Then the system saves the updated offline notification settings
      And the updated settings are reflected in the Offline Notifications section

  @VSF-3500
  Scenario: API integration for Dashcam domain
    Given the system is configured with the Dashcam API
    When the system makes a request to fetch dashcam data
    Then the API responds with the correct data
      And the data is displayed correctly in the Dashcam Health Page

