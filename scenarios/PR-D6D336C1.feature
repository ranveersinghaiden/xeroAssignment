Feature: Tests for PR: PR-D6D336C1

  @api @smoke @regression
  Scenario: Driver logon card table columns are defined with correct typed identifiers
    Given the Dashcam driver logon card table column definitions are loaded
    When the column configuration is evaluated
    Then each column has a non-null strongly-typed identifier
      And each column has a defined label
      And no column definition contains an unresolved any-typed placeholder

  @api @regression
  Scenario: Driver logon card table renders all required columns
    Given a dashcam device with recorded driver logon events
    When the driver logon card table is rendered
    Then the table contains columns for DateTime, Driver, Location, and Status
      And all column definitions resolve to their correct component renderers

  @api @regression
  Scenario: Driver logon card table handles empty logon event list
    Given a dashcam device with no driver logon events
    When the driver logon card table is rendered
    Then the table displays zero rows
      And no runtime type error is thrown

  @ui @smoke @regression
  Scenario: DateTimeLogonCell displays a formatted logon timestamp
    Given a driver logon event with timestamp "2024-03-15T08:30:00Z"
    When the DateTimeLogonCell component is rendered
    Then the cell displays the date as "15 Mar 2024"
      And the cell displays the time as "08:30"

  @ui @regression
  Scenario: DateTimeLogonCell handles a null timestamp gracefully
    Given a driver logon event with a null timestamp
    When the DateTimeLogonCell component is rendered
    Then the cell displays an empty or placeholder value
      And no runtime type coercion error is thrown

  @api @regression
  Scenario: DateTimeLogonCell receives correctly typed datetime prop
    Given the DateTimeLogonCell component accepts a typed datetime prop
    When a valid ISO-8601 string is passed
    Then the component renders without TypeScript type errors
      And the displayed value matches the expected formatted output

  @api @regression
  Scenario: DateTimeLogonCell rejects non-date typed input at type boundary
    Given the DateTimeLogonCell prop interface is enforced with strict types
    When an invalid type is passed to the datetime prop
    Then a compile-time type error is raised
      And no fallback any-cast is present in the component definition

  @api @smoke @regression
  Scenario: DriverCell displays driver name from a typed driver object
    Given a driver logon event with driver name "John Smith" and driver ID "D-001"
    When the DriverCell component receives the typed driver prop
    Then the cell displays "John Smith"
      And the driver ID is accessible as a typed string field

  @api @regression
  Scenario: DriverCell handles unassigned driver gracefully
    Given a driver logon event where the driver field is null
    When the DriverCell component is rendered
    Then the cell displays a default unassigned indicator
      And no null dereference or any-cast error occurs

  @api @regression
  Scenario: DriverCell driver prop conforms to the defined Driver type interface
    Given the DriverCell prop interface is defined without any-typed fields
    When the component receives a fully typed driver payload
    Then all driver fields are accessible with their declared types
      And no $TSFixMe annotations remain in the DriverCell type definition

  @api @smoke @regression
  Scenario: LocationCell displays address from a typed location object
    Given a driver logon event with location address "123 Main St, Auckland"
    When the LocationCell component receives the typed location prop
    Then the cell displays "123 Main St, Auckland"

  @api @regression
  Scenario: LocationCell handles missing location data gracefully
    Given a driver logon event where location is undefined
    When the LocationCell component is rendered
    Then the cell displays a dash or empty placeholder
      And no runtime error is thrown due to undefined property access

  @api @regression
  Scenario: LocationCell coordinates are typed as numeric latitude and longitude
    Given a location object with latitude 36.8485 and longitude 174.7633
    When the LocationCell component processes the location prop
    Then latitude and longitude are typed as number
      And no any-type cast is applied to the coordinate values

  @api @smoke @regression
  Scenario: StatusCell displays correct label for a LOGGED_IN driver status
    Given a driver logon event with status "LOGGED_IN"
    When the StatusCell component is rendered
    Then the cell displays the label for logged-in state
      And the status value is typed as a union of known status literals

  @api @regression
  Scenario: StatusCell displays correct label for a LOGGED_OUT driver status
    Given a driver logon event with status "LOGGED_OUT"
    When the StatusCell component is rendered
    Then the cell displays the label for logged-out state

  @api @regression
  Scenario: StatusCell rejects an unknown status value at compile time
    Given the StatusCell prop type is a strict union type
    When an unrecognised status string is passed
    Then a TypeScript compile error is raised
      And no wildcard any-typed fallback is present in the status type definition

  @api @smoke @regression
  Scenario: DataRetention component loads current retention period for a device
    Given an authenticated user with Dashcam data retention configuration
    When the DataRetention component is initialised for a device
    Then the current retention period is displayed
      And the retention period value is typed as a number in days

  @api @regression
  Scenario: DataRetention component exposes a typed retention settings object
    Given the DataRetention settings interface is defined without any-typed fields
    When the component reads the retention configuration
    Then all retention fields are accessible with their declared types
      And no $TSFixMe placeholders remain in the DataRetention type definitions

  @api @regression
  Scenario: DataRetention displays an error state when retention config is unavailable
    Given the retention configuration API returns a 500 error
    When the DataRetention component attempts to load configuration
    Then an appropriate error message is displayed to the user
      And the component does not crash due to an untyped error payload

  @api @smoke @regression
  Scenario: DataRetentionPeriodUpdateModal opens with the current retention period pre-filled
    Given a device with a current retention period of 30 days
    When the user opens the DataRetentionPeriodUpdateModal
    Then the modal input field shows 30
      And the retention period prop is typed as a number

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal submits an updated retention period
    Given the DataRetentionPeriodUpdateModal is open with retention period 30 days
    When the user enters 60 and confirms the update
    Then the API is called with the typed payload containing period 60
      And the modal closes on successful submission

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal validates that retention period is a positive integer
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a negative number "-10"
    Then the modal displays a validation error
      And the update API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal emits a typed close event on cancellation
    Given the DataRetentionPeriodUpdateModal is open
    When the user clicks Cancel
    Then the modal emits a typed close event
      And no untyped event payload is dispatched

  @api @smoke @regression
  Scenario: OfflineNotifications component loads notification settings for a device
    Given an authenticated user with Dashcam offline notification configuration
    When the OfflineNotifications component is initialised
    Then the current offline notification settings are displayed
      And all settings fields are typed according to the OfflineNotifications interface

  @api @regression
  Scenario: OfflineNotifications displays an enabled state when notifications are active
    Given offline notifications are enabled for the device
    When the OfflineNotifications component is rendered
    Then the notification toggle reflects enabled state
      And the enabled field is typed as boolean

  @api @regression
  Scenario: OfflineNotifications displays a disabled state when notifications are inactive
    Given offline notifications are disabled for the device
    When the OfflineNotifications component is rendered
    Then the notification toggle reflects disabled state

  @api @regression
  Scenario: OfflineNotifications typed payload matches the API response contract
    Given the OfflineNotifications API returns a response with threshold and recipients fields
    When the component maps the API response to its settings model
    Then threshold is typed as number and recipients as an array of strings
      And no any-cast is applied to the response fields

  @api @smoke @regression
  Scenario: Dashcam API module exports typed request and response interfaces
    Given the Dashcam API module is imported
    When the exported types are inspected
    Then all request parameter types are defined as concrete interfaces
      And all response types are defined as concrete interfaces without any-typed fields

  @ui @smoke @regression
  Scenario: Dashcam API fetchDriverLogonEvents returns a typed array of logon events
    Given an authenticated session with a valid device ID
    When the API call fetchDriverLogonEvents is made
    Then the response is a typed array where each element conforms to DriverLogonEvent interface
      And the response contains datetime, driver, location, and status fields with correct types

  @api @regression
  Scenario: Dashcam API fetchDataRetentionSettings returns a typed retention settings object
    Given an authenticated session with a valid device ID
    When the API call fetchDataRetentionSettings is made
    Then the response conforms to the DataRetentionSettings interface
      And the retentionPeriodDays field is typed as number

  @api @regression
  Scenario: Dashcam API updateDataRetentionPeriod accepts a typed update payload
    Given a typed UpdateDataRetentionRequest with deviceId and periodDays fields
    When the API call updateDataRetentionPeriod is made
    Then the request is sent with the correct content type
      And the response is typed as an updated DataRetentionSettings object

  @api @regression
  Scenario: Dashcam API fetchOfflineNotificationSettings returns typed notification config
    Given an authenticated session with a valid device ID
    When the API call fetchOfflineNotificationSettings is made
    Then the response conforms to the OfflineNotificationSettings interface
      And no any-typed fields are present in the mapped response object

  @ui @regression
  Scenario: Dashcam API handles a 401 Unauthorised response with a typed error
    Given an expired authentication token
    When any Dashcam API method is called
    Then a typed ApiError is thrown with status 401
      And the error payload does not rely on any-typed casting

  @api @regression
  Scenario: Dashcam API handles a 404 Not Found response with a typed error
    Given a device ID that does not exist
    When fetchDriverLogonEvents is called with that device ID
    Then a typed ApiError is thrown with status 404
      And the error message field is typed as string

  @api @smoke @regression
  Scenario: SettingsToggle renders in enabled state with typed boolean prop
    Given the SettingsToggle component receives enabled prop as boolean true
    When the component is rendered
    Then the toggle is displayed in the on position
      And the enabled prop is declared as boolean in the component props interface

  @api @regression
  Scenario: SettingsToggle renders in disabled state with typed boolean prop
    Given the SettingsToggle component receives enabled prop as boolean false
    When the component is rendered
    Then the toggle is displayed in the off position

  @api @regression
  Scenario: SettingsToggle emits a typed change event when toggled
    Given the SettingsToggle is in enabled state
    When the user clicks the toggle
    Then the component emits a change event with a boolean payload
      And the emitted value is typed as boolean not any

  @api @regression
  Scenario: SettingsToggle is disabled when a typed loading prop is true
    Given the SettingsToggle component receives loading prop as boolean true
      And the user is authenticated in myeroad
      And the Dashcam feature is enabled for the organisation
    When the component is rendered
    Then the toggle interaction is disabled
      And the loading prop is typed as boolean in the component props interface

  @api @smoke @regression
  Scenario: DriverLogonCardTableColumnDefinitions returns all required typed column definitions
    When the DriverLogonCardTableColumnDefinitions are retrieved
    Then the column list contains exactly the columns "dateTime", "driver", "location", "status"
      And each column definition has a non-null "header" property
      And each column definition has a non-null "cell" component reference

  @api @regression
  Scenario: DriverLogonCardTableColumnDefinitions column order is stable
    When the DriverLogonCardTableColumnDefinitions are retrieved multiple times
    Then the column order is always "dateTime", "driver", "location", "status"

  @api @regression
  Scenario: DriverLogonCardTableColumnDefinitions rejects unknown column types at compile boundary
    When a consumer requests a column definition with an unsupported key
    Then no column definition is returned for that key

  @ui @smoke @regression
  Scenario: DateTimeLogonCell renders a valid ISO timestamp as human-readable local date and time
    Given a logon event with timestamp "2024-03-15T08:30:00Z"
    When the DateTimeLogonCell is rendered for that event
    Then the cell displays the date portion "15 Mar 2024"
      And the cell displays the time portion "08:30 AM" adjusted for the user's timezone

  @ui @regression
  Scenario: DateTimeLogonCell renders a dash when the logon timestamp is null
    Given a logon event with a null timestamp
    When the DateTimeLogonCell is rendered for that event
    Then the cell displays "—"

  @api @regression
  Scenario: DateTimeLogonCell prop type accepts only a valid Date or null
    When DateTimeLogonCell receives a properly typed Date prop
    Then no TypeScript compile error is raised
      And the component renders without runtime errors

  @api @regression
  Scenario: DateTimeLogonCell prop type rejects an untyped $TSFixMe value at compile boundary
    When DateTimeLogonCell receives a value that was previously typed as $TSFixMe
    Then the strongly-typed prop interface enforces the correct Date or null type

  @api @smoke @regression
  Scenario: DriverCell renders the driver's full name when driver data is present
    Given a logon event with driver name "Jane Smith"
    When the DriverCell is rendered
    Then the cell displays "Jane Smith"

  @api @regression
  Scenario: DriverCell renders an unidentified placeholder when no driver is associated
    Given a logon event with no associated driver
    When the DriverCell is rendered
    Then the cell displays "Unidentified Driver"

  @api @regression
  Scenario: DriverCell accepts a strictly typed driver object and rejects $TSFixMe
    When DriverCell receives a driver prop conforming to the typed Driver interface
    Then no TypeScript compile error is raised

  @api @smoke @regression
  Scenario: LocationCell renders a formatted address when location data is available
    Given a logon event with location address "123 Main St, Auckland"
    When the LocationCell is rendered
    Then the cell displays "123 Main St, Auckland"

  @api @regression
  Scenario: LocationCell renders a dash when location data is null
    Given a logon event with null location
    When the LocationCell is rendered
    Then the cell displays "—"

  @api @regression
  Scenario: LocationCell renders coordinates when address is unavailable but coordinates exist
    Given a logon event with coordinates latitude "-36.8485" and longitude "174.7633"
      And no address string is available
    When the LocationCell is rendered
    Then the cell displays the formatted coordinate string

  @api @regression
  Scenario: LocationCell prop type enforces the typed Location interface
    When LocationCell receives a prop conforming to the typed Location interface
    Then no TypeScript compile error is raised

  @api @smoke @regression
  Scenario: StatusCell renders "Online" with correct indicator for an online dashcam
    Given a logon event with status "ONLINE"
    When the StatusCell is rendered
    Then the cell displays the text "Online"
      And the status indicator colour is green

  @api @smoke @regression
  Scenario: StatusCell renders "Offline" with correct indicator for an offline dashcam
    Given a logon event with status "OFFLINE"
    When the StatusCell is rendered
    Then the cell displays the text "Offline"
      And the status indicator colour is red

  @api @regression
  Scenario: StatusCell renders "Unknown" when status value is not recognised
    Given a logon event with an unrecognised status value
    When the StatusCell is rendered
    Then the cell displays "Unknown"

  @api @regression
  Scenario: StatusCell prop type is a strict union type and rejects $TSFixMe assignments
    When StatusCell receives a status prop of type DashcamStatus union
    Then no TypeScript compile error is raised

  @api @smoke @regression
  Scenario: DataRetention component displays the current data retention period on load
    Given the organisation has a data retention period of 30 days
    When the DataRetention component is rendered
    Then the displayed retention period is "30 days"

  @api @regression
  Scenario: DataRetention component displays the minimum retention period
    Given the organisation has a data retention period set to the minimum allowed value
    When the DataRetention component is rendered
    Then the displayed retention period matches the minimum allowed value

  @api @regression
  Scenario: DataRetention component displays the maximum retention period
    Given the organisation has a data retention period set to the maximum allowed value
    When the DataRetention component is rendered
    Then the displayed retention period matches the maximum allowed value

  @api @regression
  Scenario: DataRetention component shows an edit trigger for authorised users
    Given the current user has the "DASHCAM_SETTINGS_EDIT" permission
    When the DataRetention component is rendered
    Then an edit button or link is visible

  @api @regression
  Scenario: DataRetention component hides the edit trigger for unauthorised users
    Given the current user does not have the "DASHCAM_SETTINGS_EDIT" permission
    When the DataRetention component is rendered
    Then no edit button or link is visible

  @api @regression
  Scenario: DataRetention component is typed with the DataRetentionConfig interface
    When the DataRetention component receives props conforming to DataRetentionConfig
    Then no TypeScript compile error is raised

  @api @smoke @regression
  Scenario: DataRetentionPeriodUpdateModal opens with the current retention period pre-populated
    Given the organisation has a data retention period of 60 days
      And the edit action is triggered
    When the DataRetentionPeriodUpdateModal is opened
    Then the input field displays "60"

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal successfully saves a valid new retention period
    Given the DataRetentionPeriodUpdateModal is open with current period 30 days
    When the user enters "90" in the retention period input
      And the user confirms the update
    Then the API is called with the new period value 90
      And a success notification is displayed
      And the modal closes

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal displays a validation error for a period below the minimum
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a value below the minimum allowed retention period
      And the user attempts to confirm
    Then a validation error message is displayed
      And the API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal displays a validation error for a period above the maximum
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a value above the maximum allowed retention period
      And the user attempts to confirm
    Then a validation error message is displayed
      And the API is not called

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal handles an API error gracefully
    Given the DataRetentionPeriodUpdateModal is open with current period 30 days
      And the retention period update API will return an error
    When the user enters "45" and confirms
    Then an error notification is displayed
      And the modal remains open

  @api @regression
  Scenario: DataRetentionPeriodUpdateModal closes without saving when the user cancels
    Given the DataRetentionPeriodUpdateModal is open with current period 30 days
    When the user cancels the modal
    Then the API is not called
      And the displayed retention period remains "30 days"

  @api @smoke @regression
  Scenario: OfflineNotifications component renders the offline notification toggle
    When the OfflineNotifications component is rendered
    Then the offline notifications toggle is visible

  @api @regression
  Scenario: OfflineNotifications displays enabled state when notifications are turned on
    Given offline notifications are enabled for the organisation
    When the OfflineNotifications component is rendered
    Then the toggle is in the ON position

  @api @regression
  Scenario: OfflineNotifications displays disabled state when notifications are turned off
    Given offline notifications are disabled for the organisation
    When the OfflineNotifications component is rendered
    Then the toggle is in the OFF position

  @api @regression
  Scenario: OfflineNotifications component prop types are strictly typed without $TSFixMe
    When OfflineNotifications receives props conforming to the OfflineNotificationsConfig interface
    Then no TypeScript compile error is raised

  @api @smoke @regression
  Scenario: Dashcam API fetchDriverLogonEvents returns a typed DriverLogonEvent array
    Given the API endpoint for driver logon events is available
    When fetchDriverLogonEvents is called with valid query parameters
    Then the response is typed as DriverLogonEvent[]
      And each event contains fields: id, timestamp, driver, location, status

  @api @regression
  Scenario: Dashcam API fetchDriverLogonEvents handles an empty result set
    Given no driver logon events exist for the given query range
    When fetchDriverLogonEvents is called
    Then the response is an empty typed array

  @api @regression
  Scenario: Dashcam API fetchDriverLogonEvents propagates HTTP errors as typed ApiError
    Given the driver logon events endpoint returns a 500 error
    When fetchDriverLogonEvents is called
    Then a typed ApiError is thrown with the status code 500

  @api @regression
  Scenario: Dashcam API updateDataRetentionPeriod calls the correct endpoint with the typed payload
    When updateDataRetentionPeriod is called with period 45
    Then the PATCH request is sent to the data retention endpoint
      And the request body contains "{ \"retentionDays\": 45 }"

  @api @regression
  Scenario: Dashcam API updateDataRetentionPeriod handles a 403 Forbidden response
    Given the current user is not authorised to update data retention
    When updateDataRetentionPeriod is called
    Then a typed ApiError with status 403 is returned

  @api @regression
  Scenario: Dashcam API updateOfflineNotificationSettings calls the correct endpoint
    When updateOfflineNotificationSettings is called with enabled true
    Then the PATCH request is sent to the offline notifications endpoint
      And the request body contains "{ \"enabled\": true }"

  @ui @smoke @regression
  Scenario: Dashcam settings page loads and displays data retention section
    Given the user navigates to the Dashcam Settings page
    When the page finishes loading
    Then the "Data Retention" section is visible on the page

  @ui @regression
  Scenario: Dashcam settings page loads and displays offline notifications section
    Given the user navigates to the Dashcam Settings page
    When the page finishes loading
    Then the "Offline Notifications" section is visible on the page

  @ui @regression
  Scenario: Dashcam settings page displays an error banner when the settings API fails
    Given the Dashcam settings API returns an error
    When the user navigates to the Dashcam Settings page
    Then an error banner is displayed
      And the user is not shown stale or partial data

  @api @smoke @regression
  Scenario: SettingsToggle renders in the ON state when value prop is true
    Given a SettingsToggle with value prop true
    When the SettingsToggle is rendered
    Then the toggle input is checked

  @api @smoke @regression
  Scenario: SettingsToggle renders in the OFF state when value prop is false
    Given a SettingsToggle with value prop false
    When the SettingsToggle is rendered
    Then the toggle input is unchecked

  @api @regression
  Scenario: SettingsToggle emits a change event with the new boolean value when clicked
    Given a SettingsToggle in the OFF state
    When the user clicks the toggle
    Then a change event is emitted with value true

  @api @regression
  Scenario: SettingsToggle is non-interactive when disabled prop is true
    Given a SettingsToggle with disabled prop true
    When the user attempts to click the toggle
    Then no change event is emitted
      And the toggle visual state does not change

  @api @regression
  Scenario: SettingsToggle label text is rendered when a label prop is provided
    Given a SettingsToggle with label "Enable Offline Notifications"
    When the SettingsToggle is rendered
    Then the text "Enable Offline Notifications" is visible

  @api @regression
  Scenario: SettingsToggle prop types are strictly typed without $TSFixMe
    When SettingsToggle receives props conforming to the SettingsToggleProps interface
    Then no TypeScript compile error is raised

  @api @regression
  Scenario: DashcamStatus type is a closed union of known status strings
    When a variable is assigned a value from the DashcamStatus union
    Then only "ONLINE", "OFFLINE", and "UNKNOWN" are valid assignments

  @api @regression
  Scenario: DriverLogonEvent type includes all required fields with correct value types
    When a DriverLogonEvent object is constructed
    Then the fields id, timestamp, driver, location, and status are all required
      And timestamp is typed as Date or string
      And driver is typed as Driver or null
      And location is typed as Location or null
      And status is typed as DashcamStatus

  @api @regression
  Scenario: DataRetentionConfig type enforces retentionDays as a positive integer
    When a DataRetentionConfig object is constructed with retentionDays as a number
    Then no TypeScript compile error is raised

  @api @regression
  Scenario: OfflineNotificationsConfig type enforces enabled as a boolean
    When an OfflineNotificationsConfig object is constructed with enabled as a boolean
    Then no TypeScript compile error is raised

  @api @regression
  Scenario: Removal of $TSFixMe does not introduce runtime regressions in type-narrowed branches
    Given a DriverLogonEvent where driver is null
    When the DriverCell processes the event
    Then the null branch is handled without a runtime TypeError

  @api @regression
  Scenario: Removal of $TSFixMe does not introduce runtime regressions when location is undefined
    Given a DriverLogonEvent where location is undefined
    When the LocationCell processes the event
    Then the undefined branch is handled without a runtime TypeError

