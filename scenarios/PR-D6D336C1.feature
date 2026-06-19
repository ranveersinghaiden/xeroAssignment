Feature: Tests for PR: PR-D6D336C1

  @api @regression
  Scenario: All previously-TSFixMe types are strictly typed and exported
    Given the Dashcam domain type definitions have been updated
    When downstream consumers import types from the public interface
    Then no type resolves to `any` or `unknown`
      And all exported types are correctly shaped and reachable

  @api @regression
  Scenario: Discriminated unions and enums are exhaustive at runtime
    Given the updated enum and discriminated union definitions are in place
    When every known variant is exercised at runtime
    Then no unmatched branch falls through to an undefined state
      And all branches produce correctly-shaped objects

  @api @regression
  Scenario: Downstream consumers receive correctly-shaped objects after type narrowing
    Given cell components, column definitions, and API layer import from updated types
    When data flows through the type-narrowing pipeline
    Then each consumer receives an object matching its expected interface
      And no runtime shape mismatch occurs

  @api @smoke
  Scenario: API call signatures align with newly-typed request and response shapes
    Given the API layer has been updated to strict types
    When a valid API request is made
    Then the request shape matches the typed interface
      And the parsed response matches the typed response shape without throwing

  @api @regression
  Scenario: API error paths are handled correctly after type refactor
    Given the API layer is using strict types
    When the server returns a 4xx response
      And the server returns a 5xx response
      And a network timeout occurs
    Then the error is handled gracefully without a runtime exception
      And the error is handled gracefully without a runtime exception
      And the timeout error is handled gracefully

  @api @regression
  Scenario: No runtime regressions from previously-suppressed type coercions
    Given the API layer previously coerced null to undefined and string IDs to numbers via TSFixMe
    When the API returns a response with null values or string IDs
    Then the consumer handles null and string IDs correctly under strict types
      And no silent coercion is lost

  @api @regression
  Scenario: No raw user-supplied data is passed unsanitised to API calls
    Given explicit type guards are in place on all API call inputs
    When user-supplied data is submitted to an API call
    Then the data passes through the type guard before reaching the API
      And unsanitised raw input is rejected before the call is made

  @ui @regression
  Scenario: Column definitions array is well-typed and renders the correct number of columns
    Given the DriverLogonCardTableColumnDefinitions are loaded
    When the table is rendered
    Then the column count matches the expected baseline
      And each column definition is correctly typed

  @ui @regression
  Scenario: Column accessor and id keys match updated type definitions
    Given the updated type definitions for the driver logon card
    When the column definitions are evaluated
    Then each column's accessor and id key matches a property on the updated type

  @ui @regression
  Scenario: Cell renderer mappings are correctly wired per column
    Given the DriverLogonCardTableColumnDefinitions are configured
    When each column is rendered
    Then the DateTimeLogonCell is wired to the datetime column
      And the DriverCell is wired to the driver column
      And the LocationCell is wired to the location column
      And the StatusCell is wired to the status column

  @ui @regression
  Scenario: No column is silently dropped or reordered vs pre-PR baseline
    Given the pre-PR column order and count as baseline
    When the updated DriverLogonCardTableColumnDefinitions are rendered
    Then every column present in the baseline is present post-PR
      And the column order matches the baseline

  @ui @regression
  Scenario: DateTimeLogonCell renders a valid Date prop with correct formatted output
    Given a DateTimeLogonCell component
    When it is rendered with a valid ISO datetime string
    Then the formatted date and time are displayed correctly

  @ui @regression
  Scenario: DateTimeLogonCell renders gracefully with null prop
    Given a DateTimeLogonCell component
    When it is rendered with a null datetime prop
    Then an empty state is shown
      And no runtime error or crash occurs

  @ui @regression
  Scenario: DateTimeLogonCell renders gracefully with undefined prop
    Given a DateTimeLogonCell component
    When it is rendered with an undefined datetime prop
    Then an empty state is shown
      And no runtime error or crash occurs

  @ui @regression
  Scenario Outline: DateTimeLogonCell handles boundary datetime values
    Given a DateTimeLogonCell component
    When it is rendered with "<datetime_value>"
    Then the output is displayed without error

  @ui @regression
  Scenario: DateTimeLogonCell locale and timezone formatting is unchanged post-refactor
    Given a DateTimeLogonCell component
    When it is rendered with a known datetime and locale
    Then the formatted output matches the pre-refactor expected output

  @ui @regression
  Scenario: DriverCell renders a fully-populated driver object correctly
    Given a DriverCell component
    When it is rendered with a fully-populated driver object
    Then the driver name and ID are displayed correctly

  @ui @regression
  Scenario: DriverCell renders without error when optional driver fields are missing
    Given a DriverCell component
    When it is rendered with a driver object missing optional fields that are now strictly typed
    Then the component renders without a runtime error
      And a safe fallback is displayed for missing fields

  @ui @regression
  Scenario: DriverCell interaction handlers fire with correct typed payload
    Given a DriverCell component with a click handler
    When the user interacts with the cell
    Then the handler receives a correctly-typed payload
      And no type coercion error occurs

  @ui @regression
  Scenario: LocationCell renders correctly with a valid coordinates and address object
    Given a LocationCell component
    When it is rendered with a valid location object containing coordinates and address
    Then the address text or map link is displayed correctly

  @ui @regression
  Scenario: LocationCell renders a fallback UI when location is null
    Given a LocationCell component
    When it is rendered with a null location value previously masked by TSFixMe
    Then a fallback UI is displayed
      And no runtime error occurs

  @ui @regression
  Scenario: LocationCell address text renders correctly under strict types
    Given a LocationCell component
    When it is rendered with a strictly-typed address object
    Then the address text is rendered identically to the pre-refactor output

  @ui @regression
  Scenario Outline: StatusCell renders correctly for every known status enum value
    Given a StatusCell component
    When it is rendered with status "<status>"
    Then the correct badge label is displayed
      And the correct badge colour is applied

  @ui @regression
  Scenario: StatusCell renders a safe fallback for an unrecognised status
    Given a StatusCell component
    When it is rendered with a status value not present in the enum
    Then a safe fallback label is displayed
      And no runtime error occurs

  @ui @regression
  Scenario: StatusCell has no implicit string-to-enum coercions lost post-TSFixMe removal
    Given the StatusCell previously relied on implicit string coercion via TSFixMe
    When the component is rendered with a valid enum string value
    Then the enum is matched correctly without implicit coercion
      And the correct status badge is displayed

  @ui @smoke
  Scenario: DataRetention renders the current retention period from a correctly-typed API response
    Given the DataRetention component is mounted
    When the API returns the current retention period
    Then the retention period is displayed correctly
      And no type error occurs during rendering

  @ui @regression
  Scenario: DataRetentionPeriodUpdateModal opens, accepts valid input, submits, and closes
    Given the DataRetentionPeriodUpdateModal is rendered
    When the user opens the modal
      And enters a valid retention period value
      And submits the form
    Then the modal closes
      And the new retention period is persisted via the API

  @ui @regression
  Scenario Outline: DataRetentionPeriodUpdateModal validates input boundaries
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters "<input_value>" as the retention period
    Then the form submission "<outcome>"

  @api @smoke
  Scenario: DataRetentionPeriodUpdateModal cannot bypass server-side validation
    Given the DataRetentionPeriodUpdateModal enforces client-side type constraints
    When a user submits an out-of-range retention period by bypassing the modal UI
    Then the server rejects the request with a validation error
      And the retention period is not updated

  @ui @regression
  Scenario: New retention period tiers appear and persist correctly
    Given new retention period tiers have been added as part of this feature
    When the DataRetention component is loaded
    Then the new tier values are displayed in the UI
      And selecting a new tier and saving persists the value correctly

  @ui @regression
  Scenario: Cancelling the DataRetentionPeriodUpdateModal does not mutate state
    Given the DataRetentionPeriodUpdateModal is open with the current retention period
    When the user dismisses the modal without submitting
    Then the retention period state is unchanged

  @ui @regression
  Scenario: Offline notification renders when the device goes offline
    Given the OfflineNotifications component is mounted
    When the device loses connectivity
    Then an offline notification is displayed

  @ui @regression
  Scenario: Offline notification dismisses when connectivity is restored
    Given an offline notification is currently displayed
    When connectivity is restored
    Then the notification is dismissed automatically

  @ui @regression
  Scenario: Offline notification payload types match updated type definitions
    Given the OfflineNotifications component uses strictly-typed notification payloads
    When a notification is received
    Then all expected fields are present and correctly typed
      And no fields are silently dropped due to type mismatch

  @ui @regression
  Scenario: Each new notification category renders with correct icon and message
    Given new notification categories have been added in this change
    When each new category is triggered
    Then the correct icon is displayed for that category
      And the correct message is displayed for that category

  @ui @regression
  Scenario: Multiple simultaneous offline notifications do not collide
    Given the OfflineNotifications component is mounted
    When multiple offline notifications are triggered simultaneously
    Then each notification is displayed independently without overlap or data collision

  @ui @regression
  Scenario: SettingsToggle renders correctly in enabled state
    Given a SettingsToggle component
    When it is rendered with enabled set to true
    Then the toggle displays in the enabled visual state

  @ui @regression
  Scenario: SettingsToggle renders correctly in disabled state
    Given a SettingsToggle component
    When it is rendered with enabled set to false
    Then the toggle displays in the disabled visual state

  @ui @regression
  Scenario: SettingsToggle emits a correctly-typed event payload on interaction
    Given a SettingsToggle component with a change handler
    When the user toggles the setting
    Then the handler receives a correctly-typed event payload

  @ui @regression
  Scenario: SettingsToggle enforces read-only state in UI when applicable
    Given a SettingsToggle component configured as read-only
    When the user attempts to interact with the toggle
    Then no state change occurs
      And the read-only state is visually indicated

  @api @regression
  Scenario: Settings persist after page reload via API integration
    Given the user has toggled a setting and saved
    When the page is reloaded
    Then the setting reflects the saved value from the API

  @ui @smoke
  Scenario: Dashcam section mounts without TypeScript runtime errors
    Given the myeroad application is loaded
    When the user navigates to the Dashcam domain section
    Then the section mounts successfully
      And no TypeScript runtime errors appear in the console

  @ui @smoke
  Scenario: Driver Logon Card table renders end-to-end with real API data shape
    Given the Dashcam domain is loaded with a real API data response
    When the Driver Logon Card table is rendered
    Then all columns and rows display without error
      And the data shape from the API is correctly consumed by the table

  @ui @smoke
  Scenario: Settings page loads and saves without errors
    Given the user navigates to the Dashcam Settings page
    When the DataRetention and SettingsToggle components are rendered
      And the user updates a setting and saves
    Then both components load without error
      And the save completes without a runtime error

  @ui @smoke
  Scenario: Offline notification banner appears and clears as expected end-to-end
    Given the user is on the Dashcam section
    When the device goes offline
      And connectivity is restored
    Then the offline notification banner is displayed
      And the banner clears automatically

  @api @smoke
  Scenario: No previously-suppressed type error hides an injection vector
    Given the TSFixMe suppressions have been replaced with strict types
    When user-controlled content is rendered through previously-suppressed paths
    Then no unescaped string is rendered as raw HTML
      And no injection vector is present in the rendering pipeline

  @api @regression
  Scenario: All newly-strict API response types include validation guards before rendering
    Given the API responses are now strictly typed
    When a response containing user-controlled content is received
    Then the content passes through a validation guard before being rendered
      And no unvalidated user-controlled content reaches the UI

  @api @smoke
  Scenario: DataRetentionPeriodUpdateModal enforces server-side authorisation
    Given a user with insufficient permissions attempts to update the data retention period
    When the user submits the modal form or bypasses the client-side type constraints
    Then the server enforces authorisation and rejects the request
      And the retention period is not modified

