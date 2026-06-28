Feature: Tests for PR: PR-D6D336C1

  @smoke @regression @api
  Scenario: DriverLogonCardTableColumnDefinitions returns all required column keys
    Given the Dashcam Driver Logon Card table column definitions are loaded
    When the column definitions are evaluated
    Then the definition set includes columns for "dateTime", "driver", "location", and "status"
      And each column definition exposes a "key", "label", and "render" property
      And no column definition contains an untyped "any" field

  @regression @api
  Scenario: DriverLogonCardTableColumnDefinitions column definitions are sortable where applicable
    Given the Driver Logon Card column definitions are initialised
    When a column marked as sortable is inspected
    Then the column exposes a typed "sort" comparator function
      And the comparator accepts two rows of the strict DriverLogonRecord type

  @regression @api
  Scenario: DriverLogonCardTableColumnDefinitions gracefully omits optional columns when feature flag is disabled
    Given the optional "location" column is gated by a feature flag
    When the feature flag is set to disabled
    Then the column definitions list does not include the "location" column
      And the remaining column definitions remain valid and fully typed

  @smoke @regression @ui
  Scenario: DateTimeLogonCell renders formatted date and time for a valid logon record
    Given a DriverLogonRecord with a "logonDateTime" value of "2024-03-15T08:30:00Z"
    When the DateTimeLogonCell component is rendered
    Then the cell displays the date as "15 Mar 2024"
      And the cell displays the time as "08:30 AM"

  @regression @ui
  Scenario: DateTimeLogonCell renders a dash when logonDateTime is null
    Given a DriverLogonRecord with a null "logonDateTime"
    When the DateTimeLogonCell component is rendered
    Then the cell displays "—" as a placeholder
      And no runtime type error is thrown

  @regression @api
  Scenario: DateTimeLogonCell accepts only the strict LogonDateTime type as its prop
    Given the DateTimeLogonCell component prop contract
    When a value of type "string | null" is passed as logonDateTime
    Then the component compiles without TypeScript errors
      And passing a value of type "any" triggers a compile-time type error

  @smoke @regression @api
  Scenario: DriverCell renders driver name and ID for a fully populated driver record
    Given a DriverRecord with name "Jane Smith" and driverId "DRV-001"
    When the DriverCell is rendered
    Then the cell displays the driver name "Jane Smith"
      And the cell displays the driver ID "DRV-001"

  @regression @api
  Scenario: DriverCell renders an unassigned label when driver is null
    Given a DriverLogonRecord where the driver field is null
    When the DriverCell is rendered
    Then the cell displays "Unassigned"
      And no runtime TypeError is thrown during render

  @regression @api
  Scenario: DriverCell prop type rejects a plain object that does not conform to DriverRecord
    Given the DriverCell component prop definition
    When an object missing the required "driverId" property is passed
    Then a TypeScript compile-time error is raised
      And the runtime does not receive malformed driver data

  @smoke @regression @api
  Scenario: LocationCell renders a formatted address for a valid location record
    Given a LocationRecord with latitude "-36.8485" and longitude "174.7633"
      And the reverse-geocoded address is "Auckland CBD, Auckland"
    When the LocationCell is rendered
    Then the cell displays "Auckland CBD, Auckland"

  @regression @api
  Scenario: LocationCell renders coordinates when reverse geocoding is unavailable
    Given a LocationRecord with coordinates but no resolved address
    When the LocationCell is rendered
    Then the cell displays "-36.8485, 174.7633"

  @regression @api
  Scenario: LocationCell renders a dash when location data is null
    Given a DriverLogonRecord where the location field is null
    When the LocationCell is rendered
    Then the cell displays "—"
      And no unhandled null dereference occurs

  @smoke @regression @api
  Scenario: StatusCell renders a "Logged In" badge for an active logon status
    Given a DriverLogonRecord with status "LOGGED_IN"
    When the StatusCell is rendered
    Then the cell displays a badge labelled "Logged In"
      And the badge uses the success colour variant

  @regression @api
  Scenario: StatusCell renders a "Logged Out" badge for an inactive logon status
    Given a DriverLogonRecord with status "LOGGED_OUT"
    When the StatusCell is rendered
    Then the cell displays a badge labelled "Logged Out"
      And the badge uses the neutral colour variant

  @regression @api
  Scenario: StatusCell renders "Unknown" for an unrecognised status value
    Given a DriverLogonRecord with an unexpected status value outside the LogonStatus enum
    When the StatusCell is rendered
    Then the cell displays "Unknown"
      And a TypeScript compile-time error is raised if the unrecognised value is passed directly

  @smoke @regression @api
  Scenario: DataRetention component displays the current retention period fetched from the API
    Given the Dashcam Data Retention API returns a period of 30 days for the organisation
    When the DataRetention settings page is loaded
    Then the current retention period is displayed as "30 days"

  @regression @api
  Scenario: DataRetention component shows a loading state while fetching retention settings
    Given the Data Retention API call is in progress
    When the DataRetention component renders
    Then a loading indicator is visible
      And the retention period value is not yet displayed

  @regression @api
  Scenario: DataRetention component shows an error state when the API call fails
    Given the Data Retention API returns a 500 error
    When the DataRetention component renders
    Then an error message is displayed to the user
      And the "Update" button is disabled

  @smoke @regression @api
  Scenario: DataRetentionPeriodUpdateModal successfully updates the retention period via API
    Given the DataRetentionPeriodUpdateModal is open with current period "30 days"
    When the user selects a new period of "60 days" from the dropdown
      And the user confirms the update
    Then the API is called with a typed DataRetentionUpdateRequest payload containing period 60
      And the modal closes on success
      And a success notification is displayed

  @regression @api
  Scenario: DataRetentionPeriodUpdateModal disables the confirm button when no change is made
    Given the DataRetentionPeriodUpdateModal is open with current period "30 days"
    When the user does not change the selected period
    Then the confirm button is disabled

  @regression @api
  Scenario: DataRetentionPeriodUpdateModal rejects a non-integer period value at the type level
    Given the DataRetentionPeriodUpdateModal component prop contract
    When a floating-point value is passed as the retention period
    Then a TypeScript compile-time error is raised
      And the API call is not dispatched

  @regression @api
  Scenario: DataRetentionPeriodUpdateModal shows an inline error when the API update fails
    Given the update Data Retention API returns a 403 Forbidden error
    When the user confirms the retention period update
    Then the modal remains open
      And an error message is displayed inside the modal
      And the selected value is reset to the previous period

  @smoke @regression @api
  Scenario: OfflineNotifications displays enabled state when notifications are active for the organisation
    Given the Offline Notifications API returns enabled status for the current organisation
    When the OfflineNotifications settings section is rendered
    Then the offline notifications toggle is shown as "On"

  @regression @api
  Scenario: OfflineNotifications enables notifications when toggled on via API
    Given offline notifications are currently disabled
    When the user toggles the offline notifications switch to enabled
    Then the API is called with a typed OfflineNotificationsUpdateRequest with enabled set to true
      And a success toast is displayed

  @regression @api
  Scenario: OfflineNotifications disables notifications when toggled off via API
    Given offline notifications are currently enabled
    When the user toggles the offline notifications switch to disabled
    Then the API is called with enabled set to false
      And the toggle reflects the disabled state

  @regression @api
  Scenario: OfflineNotifications reverts toggle state when API call fails
    Given offline notifications are currently disabled
      And the update API call returns a network error
    When the user toggles the offline notifications switch to enabled
    Then the toggle reverts to its previous disabled state
      And an error notification is displayed

  @smoke @regression @ui
  Scenario: Dashcam API module exports fetchDataRetentionPeriod with correct typed return type
    Given the Dashcam API module is imported
    When fetchDataRetentionPeriod is called with a valid organisationId
    Then the resolved value conforms to the DataRetentionResponse type
      And no "any" escape is used in the response mapping

  @regression @ui
  Scenario: Dashcam API module exports updateDataRetentionPeriod with a typed request payload
    Given the Dashcam API module is imported
    When updateDataRetentionPeriod is called with a DataRetentionUpdateRequest object
    Then the HTTP request body is serialised from the strictly typed payload
      And a TypeScript error is raised at compile time if required fields are omitted

  @regression @api
  Scenario: Dashcam API module exports fetchOfflineNotificationSettings with correct typed return
    Given the Dashcam API module is imported
    When fetchOfflineNotificationSettings is called for a valid organisationId
    Then the resolved value conforms to the OfflineNotificationsSettings type

  @regression @api
  Scenario: Dashcam API module handles 401 Unauthorized responses by rejecting with an AuthError
    Given an API call is made without a valid authentication token
    When the Dashcam API returns a 401 status
    Then the promise rejects with a typed AuthError
      And the error message is accessible via the typed error contract

  @smoke @regression @api
  Scenario: SettingsToggle renders in the correct initial state based on its typed value prop
    Given a SettingsToggle component with the "value" prop set to true
    When the component renders
    Then the toggle is visually in the "on" position
      And the aria-checked attribute is "true"

  @regression @api
  Scenario: SettingsToggle emits a typed boolean change event when clicked
    Given a SettingsToggle component with value set to false
    When the user clicks the toggle
    Then the component emits an "update:value" event with payload of type boolean true
      And the event payload is not of type "any"

  @regression @api
  Scenario: SettingsToggle is disabled and non-interactive when the disabled prop is true
    Given a SettingsToggle component with the "disabled" prop set to true
    When the user clicks the toggle
    Then no "update:value" event is emitted
      And the toggle element has the disabled attribute set

  @regression @api
  Scenario: SettingsToggle prop contract rejects a non-boolean value prop at compile time
    Given the SettingsToggle component prop definition
    When a string value is passed as the "value" prop
    Then a TypeScript compile-time error is raised

  @regression @api
  Scenario: DriverLogonRecord type enforces all required fields with correct primitive types
    Given the DriverLogonRecord type definition in the Dashcam types module
    When an object is constructed omitting the required "logonDateTime" field
    Then the TypeScript compiler raises an error
      And the error identifies the missing property by name

  @regression @api
  Scenario: LogonStatus is a string literal union type covering all valid status values
    Given the LogonStatus type in the Dashcam types module
    When a value outside the defined union is assigned to a LogonStatus variable
    Then the TypeScript compiler raises a type mismatch error

  @regression @api
  Scenario: DataRetentionResponse type maps all API response fields to non-any typed properties
    Given the DataRetentionResponse type definition
    When each field is inspected
    Then no field is typed as "any" or "$TSFixMe"
      And numeric fields use "number", string fields use "string", and boolean fields use "boolean"

  @regression @api
  Scenario: OfflineNotificationsSettings type includes an enabled boolean field
    Given the OfflineNotificationsSettings type definition
    When the "enabled" field is inspected
    Then its type is strictly "boolean" and not "any"

  @regression @api
  Scenario: All exported Dashcam domain types are backward-compatible for existing consumers
    Given the updated Dashcam types module is imported by an existing consumer module
    When the consumer module is compiled without changes
    Then compilation succeeds with no type errors
      And no previously valid property access produces a new compile-time error

