Feature: Tests for PR: PR-D6D336C1

  @api @smoke
  Scenario: Driver logon card table exposes the required column definitions
    Given the dashcam driver logon card table column definitions are loaded
    Then the column definitions include "dateTime", "driver", "location", and "status"
      And each column definition has a non-empty key and label

  @api @regression
  Scenario: Driver logon card table column definitions are correctly typed and reject unknown columns
    Given the dashcam driver logon card table column definitions are loaded
    When a consumer requests a column definition for an unknown column key "fooBar"
    Then no column definition is returned
      And no runtime type error is thrown

  @api @regression
  Scenario: Driver logon card table renders correct number of columns
    Given a driver logon event list is available
    When the driver logon card table is rendered
    Then exactly 4 columns are displayed
      And the columns are ordered as "dateTime", "driver", "location", "status"

  @ui @smoke
  Scenario: DateTimeLogonCell renders a valid ISO timestamp as a human-readable date-time
    Given a driver logon event with timestamp "2024-06-15T08:30:00Z"
    When the DateTimeLogonCell component is rendered
    Then the cell displays the date as "15 Jun 2024"
      And the cell displays the time as "08:30 AM"

  @ui @regression
  Scenario: DateTimeLogonCell renders a dash when the timestamp is null
    Given a driver logon event with a null timestamp
    When the DateTimeLogonCell component is rendered
    Then the cell displays "–"

  @api @regression
  Scenario: DateTimeLogonCell resolves the correct typed prop shape for a logon event
    Given a driver logon event object with a strongly-typed "logonDateTime" field
    When the DateTimeLogonCell receives the logon event as props
    Then no TypeScript type error is raised at runtime
      And the rendered output matches the expected formatted date-time string

  @api @regression
  Scenario: DateTimeLogonCell does not accept an untyped any object as a logon event prop
    Given an untyped object passed as the logon event prop
    When the DateTimeLogonCell attempts to render
    Then a prop validation error is recorded
      And the component falls back to displaying "–"

  @api @smoke
  Scenario: DriverCell renders the driver's full name for a known driver
    Given a driver logon event with driver name "Jane Smith"
    When the DriverCell component is rendered
    Then the cell displays "Jane Smith"

  @api @regression
  Scenario: DriverCell renders "Unknown Driver" when driver information is absent
    Given a driver logon event with no driver information
    When the DriverCell component is rendered
    Then the cell displays "Unknown Driver"

  @api @regression
  Scenario: DriverCell correctly types the driver prop and does not accept a plain string
    Given a driver object with fields "driverId" and "driverName"
    When the DriverCell receives the typed driver prop
    Then no TypeScript type mismatch error is thrown
      And the driver name is rendered correctly

  @api @smoke
  Scenario: LocationCell renders the location address for a logon event with known location
    Given a driver logon event with location "123 Fleet St, Auckland"
    When the LocationCell component is rendered
    Then the cell displays "123 Fleet St, Auckland"

  @api @regression
  Scenario: LocationCell renders "–" when location data is null
    Given a driver logon event with a null location
    When the LocationCell component is rendered
    Then the cell displays "–"

  @api @regression
  Scenario: LocationCell accepts only the typed Location interface and rejects untyped data
    Given a typed Location object with fields "address" and "coordinates"
    When the LocationCell receives the typed location prop
    Then no type error is raised
      And the address field is displayed in the cell

  @api @smoke
  Scenario: StatusCell renders "Logged On" for a logon status of LOGGED_ON
    Given a driver logon event with status "LOGGED_ON"
    When the StatusCell component is rendered
    Then the cell displays "Logged On"

  @api @smoke
  Scenario: StatusCell renders "Logged Off" for a logon status of LOGGED_OFF
    Given a driver logon event with status "LOGGED_OFF"
    When the StatusCell component is rendered
    Then the cell displays "Logged Off"

  @api @regression
  Scenario: StatusCell renders "Unknown" for an unrecognised status value
    Given a driver logon event with status "INVALID_STATUS"
    When the StatusCell component is rendered
    Then the cell displays "Unknown"

  @api @regression
  Scenario: StatusCell only accepts values from the LogonStatus enum type
    Given the StatusCell component is typed to accept a LogonStatus enum
    When a value outside the LogonStatus enum is passed
    Then a prop validation error is recorded
      And the cell falls back to displaying "Unknown"

  @api @smoke
  Scenario: DataRetention component loads and displays the current retention period
    Given the dashcam data retention settings are available with a retention period of 30 days
    When the DataRetention component is rendered
    Then the current retention period "30 days" is displayed

  @api @regression
  Scenario: DataRetention component displays a loading state while fetching retention settings
    Given the data retention API call is in progress
    When the DataRetention component is rendered
    Then a loading indicator is shown
      And no retention period value is displayed

  @api @regression
  Scenario: DataRetention component displays an error message when retention settings cannot be fetched
    Given the data retention API call fails with a 500 error
    When the DataRetention component is rendered
    Then an error message is displayed
      And the retention period value is not rendered

  @api @regression
  Scenario: DataRetention component passes the correctly typed settings object to child components
    Given a typed DataRetentionSettings object is returned from the API
    When the DataRetention component processes the settings
    Then no TypeScript type error is thrown
      And the settings are passed to child components without casting to any

  @api @smoke
  Scenario: DataRetentionPeriodUpdateModal opens and displays the current retention period for editing
    Given the DataRetentionPeriodUpdateModal is triggered with current period 30 days
    When the modal is rendered
    Then a modal dialog is displayed
      And the current retention period "30" is pre-filled in the input field

  @api @smoke
  Scenario: DataRetentionPeriodUpdateModal submits a valid updated retention period
    Given the DataRetentionPeriodUpdateModal is open with current period 30 days
    When the user enters "60" as the new retention period
      And the user submits the form
    Then the update API is called with the new period value 60
      And the modal closes on success

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal rejects a retention period of zero
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters "0" as the new retention period
      And the user submits the form
    Then a validation error "Retention period must be greater than zero" is displayed
      And the update API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal rejects a non-numeric retention period
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters "abc" as the new retention period
      And the user submits the form
    Then a validation error is displayed
      And the update API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal closes without saving when cancelled
    Given the DataRetentionPeriodUpdateModal is open
    When the user clicks the cancel button
    Then the modal closes
      And the update API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal uses strongly typed props and does not accept untyped period value
    Given the DataRetentionPeriodUpdateModal is typed to accept a number for retentionPeriod
    When a string value is passed as the retentionPeriod prop
    Then a prop validation error is recorded
      And the modal does not render the invalid value

  @api @smoke
  Scenario: OfflineNotifications component displays a notification when the dashcam goes offline
    Given a dashcam device with status "OFFLINE"
    When the OfflineNotifications component processes the device status
    Then an offline notification is displayed for the device

  @api @smoke
  Scenario: OfflineNotifications component does not display a notification when the dashcam is online
    Given a dashcam device with status "ONLINE"
    When the OfflineNotifications component processes the device status
    Then no offline notification is displayed

  @api @regression
  Scenario: OfflineNotifications component handles multiple offline devices correctly
    Given three dashcam devices where two are "OFFLINE" and one is "ONLINE"
    When the OfflineNotifications component processes the device list
    Then exactly two offline notifications are displayed

  @api @regression
  Scenario: OfflineNotifications component uses typed OfflineNotification interface
    Given a typed OfflineNotification object with "deviceId", "deviceName", and "offlineSince" fields
    When the OfflineNotifications component renders the notification
    Then no TypeScript type error is thrown
      And all typed fields are displayed correctly

  @api @regression
  Scenario: OfflineNotifications component handles an empty device list without error
    Given an empty list of dashcam devices
    When the OfflineNotifications component is rendered
    Then no notifications are displayed
      And no runtime error is thrown

  @api @smoke
  Scenario: Dashcam API returns a typed list of driver logon events
    Given the dashcam API endpoint for driver logon events is available
    When a GET request is made to the driver logon events endpoint
    Then the response status is 200
      And the response body conforms to the DriverLogonEvent array type

  @api @smoke
  Scenario: Dashcam API returns typed data retention settings
    Given the dashcam API endpoint for data retention settings is available
    When a GET request is made to the data retention settings endpoint
    Then the response status is 200
      And the response body conforms to the DataRetentionSettings type

  @api @regression
  Scenario: Dashcam API update data retention period returns 200 on valid input
    Given the dashcam API endpoint for updating data retention is available
    When a PUT request is made with a valid retention period of 60 days
    Then the response status is 200
      And the updated retention period is reflected in the response body

  @api @regression
  Scenario: Dashcam API update data retention period returns 400 on invalid input
    Given the dashcam API endpoint for updating data retention is available
    When a PUT request is made with an invalid retention period of -1
    Then the response status is 400
      And the response body contains a validation error message

  @ui @regression
  Scenario: Dashcam API module correctly resolves type imports after $TSFixMe removal
    Given the dashcam API module is imported in the application
    When the application initialises
    Then no type resolution errors occur at module load time
      And all exported API functions are available with their correct typed signatures

  @api @regression
  Scenario: Dashcam API returns 401 when the request is unauthenticated
    Given the dashcam API endpoint for driver logon events is available
    When an unauthenticated GET request is made to the driver logon events endpoint
    Then the response status is 401
      And the response body contains "Unauthorized"

  @api @regression
  Scenario: Dashcam API returns 403 when the user lacks the required permission
    Given the dashcam API endpoint for driver logon events is available
      And the authenticated user does not have dashcam access permission
    When a GET request is made to the driver logon events endpoint
    Then the response status is 403

  @api @smoke
  Scenario: SettingsToggle renders in the enabled state when the setting is true
    Given a dashcam setting with value true
    When the SettingsToggle component is rendered with that setting
    Then the toggle is displayed in the "on" state

  @api @smoke
  Scenario: SettingsToggle renders in the disabled state when the setting is false
    Given a dashcam setting with value false
    When the SettingsToggle component is rendered with that setting
    Then the toggle is displayed in the "off" state

  @api @regression
  Scenario: SettingsToggle calls the onChange handler with the new boolean value when toggled on
    Given the SettingsToggle is rendered with value false
    When the user clicks the toggle
    Then the onChange handler is called with the value true

  @api @regression
  Scenario: SettingsToggle calls the onChange handler with the new boolean value when toggled off
    Given the SettingsToggle is rendered with value true
    When the user clicks the toggle
    Then the onChange handler is called with the value false

  @api @regression
  Scenario: SettingsToggle is disabled and non-interactive when the disabled prop is true
    Given the SettingsToggle is rendered with the disabled prop set to true
    When the user clicks the toggle
    Then the onChange handler is not called
      And the toggle remains in its original state

  @api @regression
  Scenario: SettingsToggle accepts only boolean values for the value prop after $TSFixMe removal
    Given the SettingsToggle component now uses a strictly typed boolean prop for value
    When a non-boolean value is passed as the value prop
    Then a prop validation error is recorded
      And the toggle renders in the "off" state as a safe default

  @api @smoke
  Scenario: DriverLogonEvent type contains all required fields with correct types
    Given the DriverLogonEvent type definition in the dashcam domain
    Then it contains "logonDateTime" of type string or Date
      And it contains "driver" of type Driver
      And it contains "location" of type Location or null
      And it contains "status" of type LogonStatus enum

  @api @smoke
  Scenario: DataRetentionSettings type contains the retention period as a number
    Given the DataRetentionSettings type definition in the dashcam domain
    Then it contains "retentionPeriodDays" of type number
      And it does not allow an any type for any field

  @api @regression
  Scenario: LogonStatus enum contains only the expected status values
    Given the LogonStatus enum definition in the dashcam domain
    Then it contains the value "LOGGED_ON"
      And it contains the value "LOGGED_OFF"
      And it does not contain a catch-all any or unknown type

  @api @regression
  Scenario: OfflineNotification type contains all required fields with correct types
    Given the OfflineNotification type definition in the dashcam domain
    Then it contains "deviceId" of type string
      And it contains "deviceName" of type string
      And it contains "offlineSince" of type string or Date
      And no field is typed as any

  @api @regression
  Scenario: All exported types in the dashcam domain are free of $TSFixMe any casts
    Given the dashcam types module is inspected
    When each exported type is evaluated
    Then no type is an alias or cast of any
      And all types are fully resolved with named interfaces or primitive types

