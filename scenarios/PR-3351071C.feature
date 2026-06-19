Feature: Tests for PR: PR-3351071C

  @api @smoke @regression
  Scenario: Existing callers passing valid data are unaffected by stricter types
    Given a consumer that already passes a superset of the new strict type shape
    When the API method is invoked with that payload
    Then the response is successful and no type errors are raised

  @api @regression
  Scenario: Required fields absent at runtime produce an explicit error
    Given a field that changed from optional to required in the new type definitions
    When a caller submits a payload that omits that field
    Then a well-formed error is returned and the value is not silently coerced to undefined

  @api @regression
  Scenario: Union type boundaries behave as specified
    Given a field typed as "string | null" in the new definitions
    When the field is set to null at the API boundary
    Then the value is treated as null, not undefined, and no silent propagation occurs

  @api @regression
  Scenario: Consumers passing null where the type forbids it receive a well-formed error
    Given the new strict type forbids null for a specific field
    When a consumer passes null for that field
    Then a well-formed error is returned rather than a silent undefined-propagation crash

  @api @smoke @regression
  Scenario: All API methods return types that satisfy the new strict interfaces
    Given the updated API layer with strict TypeScript interfaces
    When each API method is called with valid input
    Then every return value satisfies the strict interface with no implicit any escaping

  @api @regression
  Scenario: Missing required fields in request payload produce an explicit error response
    Given an API endpoint that requires specific fields
    When a request is submitted with one or more required fields absent
    Then the API returns an explicit error response, not a silent omission

  @api @regression
  Scenario: Unexpected fields in server response are safely ignored
    Given an API response that includes extra fields not in the strict type definition
    When the response is deserialised
    Then the extra fields are ignored without causing a type-assertion crash

  @api @regression
  Scenario: HTTP error codes are mapped to typed error objects
    Given an API call that results in an HTTP error (4xx or 5xx)
    When the error is received
    Then it is mapped to a typed error object, not left as raw unknown

  @api @smoke @regression
  Scenario: Malformed or oversized payloads are rejected at the API layer
    Given a previously unvalidated input path that is now guarded
    When a malformed or oversized payload is submitted
    Then the API layer rejects it with a well-formed error response

  @api @regression
  Scenario: Callers using deprecated or removed field names receive a clear failure
    Given a caller that references a field name removed or renamed by the PR
    When the caller invokes the API method
    Then a clear compile-time or runtime failure is produced (BREAKING_CHANGE verification)

  @api @regression
  Scenario: API retry and timeout paths function correctly after type narrowing
    Given the API layer has been updated with strict types
    When a request triggers a retry or timeout code path
    Then the retry and timeout behaviour is unchanged and returns correctly typed responses

  @api @regression
  Scenario: Column definition array conforms to the strict column type interface
    Given the DriverLogonCardTableColumnDefinitions array
    When the column definitions are evaluated against the new strict column type
    Then every entry is valid with no extra any casts on field, headerName, or cellRenderer

  @api @regression
  Scenario: Custom cell renderer references resolve to typed components
    Given the column definitions referencing DateTimeLogonCell, DriverCell, LocationCell, and StatusCell
    When the column definitions are loaded
    Then each renderer reference resolves to a typed component, not a bare string

  @api @regression
  Scenario: Column order, visibility flags, and sort/filter configs are unchanged
    Given the column definitions before and after the PR
    When comparing column order, visibility flags, and sort and filter configurations
    Then all values are identical to pre-PR behaviour

  @api @regression
  Scenario: Removed or renamed column keys no longer appear in the definitions
    Given column keys that were removed or renamed by the PR
    When the column definition array is inspected
    Then the old key names are absent and downstream code using them fails at compile time

  @ui @smoke @regression
  Scenario: Valid ISO 8601 date-time string is formatted correctly for the user locale
    Given a DateTimeLogonCell receiving a valid ISO 8601 date-time string
    When the cell renders
    Then the formatted date-time is displayed according to the user's locale

  @ui @regression
  Scenario Outline: Graceful handling of absent or empty date-time input
    Given a DateTimeLogonCell receiving <input_value> as its value
    When the cell renders
    Then a placeholder is displayed and no crash occurs

  @ui @regression
  Scenario: Invalid date string renders fallback and logs a warning
    Given a DateTimeLogonCell receiving a non-ISO or garbled date string
    When the cell renders
    Then a fallback value is displayed and a warning is logged

  @ui @regression
  Scenario: Component prop type rejects numeric epoch values where only string is accepted
    Given a DateTimeLogonCell prop type that now only accepts string
    When a numeric epoch value is passed at a usage site
    Then a type error is surfaced at that usage site

  @ui @regression
  Scenario Outline: Timezone edge cases render without error
    Given a DateTimeLogonCell receiving a date-time at <edge_case>
    When the cell renders
    Then the correct formatted value is displayed with no crash

  @ui @smoke @regression
  Scenario: Driver name and ID both render when both are provided
    Given a DriverCell receiving a Driver object with both name and ID populated
    When the cell renders
    Then both the driver name and ID are displayed

  @ui @regression
  Scenario: Only driver ID renders when name is absent
    Given a DriverCell receiving a Driver object with only driverId and no name
    When the cell renders
    Then the driver ID is displayed without a crash

  @ui @regression
  Scenario: Null driver object renders an empty placeholder state
    Given a DriverCell receiving a null driver object
    When the cell renders
    Then an empty placeholder is shown and no crash occurs

  @ui @regression
  Scenario: Long driver names are truncated correctly
    Given a DriverCell receiving a Driver object with an excessively long name
    When the cell renders
    Then the name is truncated with overflow handling identical to pre-PR behaviour

  @ui @regression
  Scenario: Plain string is rejected where a Driver object is required
    Given a DriverCell prop that now requires a typed Driver object
    When a plain string is passed at a usage site
    Then a type error is surfaced

  @ui @smoke @regression
  Scenario: Formatted location string renders from a typed Location object
    Given a LocationCell receiving a valid typed Location object with lat and lng
    When the cell renders
    Then the formatted location string is displayed

  @ui @regression
  Scenario: Null coordinates display the unknown placeholder
    Given a LocationCell receiving a Location object with null lat and lng
    When the cell renders
    Then "Unknown" or the configured placeholder is shown without a crash

  @ui @regression
  Scenario: Zero coordinates are treated as a valid location, not as null
    Given a LocationCell receiving a Location object with lat 0 and lng 0
    When the cell renders
    Then the zero coordinates are rendered as a valid location, distinct from the null case

  @ui @regression
  Scenario: Raw string location input is rejected in favour of the typed Location object
    Given a LocationCell prop that previously accepted a raw string location
    When a raw string is passed at a usage site
    Then a type error is surfaced (BREAKING_CHANGE verification)

  @ui @smoke @regression
  Scenario Outline: Known Status enum values render the correct label and visual indicator
    Given a StatusCell receiving the Status enum value <status>
    When the cell renders
    Then the correct label and visual indicator for <status> are displayed

  @ui @regression
  Scenario: Unknown status value shows fallback label without crashing
    Given a StatusCell receiving a status value not present in the current enum
    When the cell renders
    Then a fallback label is shown and no crash occurs

  @ui @regression
  Scenario: Plain string is rejected where a Status enum is required
    Given a StatusCell prop that now requires a typed Status enum
    When an arbitrary string is passed at a usage site
    Then a type error is surfaced (BREAKING_CHANGE verification)

  @ui @regression
  Scenario: Status cell renders correctly when the cell value transitions
    Given a StatusCell that has rendered an initial Status enum value
    When the cell value is updated to a different Status enum value
    Then the cell re-renders with the new label and visual indicator

  @api @smoke @regression
  Scenario: Current retention settings are retrieved and mapped to the strict type shape
    Given the DataRetention component connected to the API
    When the component loads
    Then the retention settings are fetched and every field maps correctly to the new strict type

  @api @regression
  Scenario: New retention period fields added in this PR are populated from the API response
    Given the API returns a response that includes new retention period fields
    When the DataRetention component processes the response
    Then the new fields are correctly populated in the component state

  @api @regression
  Scenario: Previously broken behaviour identified by the bug fix no longer occurs
    Given the specific bug fixed by this PR
    When the previously broken scenario is reproduced
    Then the old broken behaviour is absent and the correct behaviour is observed

  @api @regression
  Scenario: Null or undefined retention period from API shows a default or disabled state
    Given the API returns a null or undefined retention period
    When the DataRetention component processes the response
    Then a default or disabled state is shown without a crash

  @api @regression
  Scenario: retentionPeriodDays is treated as a number and not silently coerced from string
    Given the API returns retentionPeriodDays as a string value
    When the DataRetention component processes the value
    Then the strict type enforces number and the string value is not silently coerced

  @api @ui @smoke @regression
  Scenario: Submitting a valid retention period calls the API with a correctly typed payload
    Given the DataRetentionPeriodUpdateModal is open with a valid period entered
    When the user submits the form
    Then the API is called once with a correctly typed numeric payload

  @api @ui @regression
  Scenario Outline: Out-of-range retention period input shows an inline error and blocks submission
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a period of <period> days
    Then an inline validation error is shown and no API call is made

  @api @ui @regression
  Scenario Outline: Non-numeric or empty input prevents form submission
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters "<input>" in the retention period field
    Then the form is prevented from submitting

  @api @ui @regression
  Scenario: Successful API response closes the modal and refreshes the DataRetention view
    Given the DataRetentionPeriodUpdateModal has submitted a valid payload
    When the API returns a success response
    Then the modal closes and the parent DataRetention view refreshes its data

  @api @ui @regression
  Scenario: API error response keeps the modal open and shows a user-facing error message
    Given the DataRetentionPeriodUpdateModal has submitted a valid payload
    When the API returns an error response
    Then the modal remains open and a user-facing error message is displayed without rendering the raw error object

  @api @ui @smoke @regression
  Scenario: XSS payloads in the retention period field are rejected or escaped
    Given the DataRetentionPeriodUpdateModal is open with input sanitisation applied
    When the user enters a script injection payload in the retention period field
    Then the payload is rejected or escaped and is not executed or rendered as code

  @api @smoke @regression
  Scenario: Notification preferences load and map to the new strict type correctly
    Given the OfflineNotifications component connected to the API
    When the component loads
    Then notification preferences are fetched and all fields map to the strict type without error

  @api @regression
  Scenario: Toggling a notification preference persists via API with a correctly typed boolean payload
    Given the OfflineNotifications component has loaded preferences
    When the user toggles a notification preference
    Then the API is called with a correctly typed boolean payload reflecting the new state

  @api @regression
  Scenario: Offline state is handled gracefully with no crash
    Given the OfflineNotifications component in an environment with no network connectivity
    When the component attempts to load preferences
    Then cached state or a disabled UI is shown and no crash occurs

  @api @regression
  Scenario: New notification types or channels added by the PR render and can be toggled
    Given the API returns notification preferences that include newly added types or channels
    When the OfflineNotifications component renders
    Then the new types or channels are displayed and can be toggled successfully

  @ui @smoke @regression
  Scenario Outline: Toggle renders in the correct initial state from a typed boolean prop
    Given a SettingsToggle receiving the boolean prop value <value>
    When the component renders
    Then the toggle displays in the <expected_state> state

  @ui @regression
  Scenario: Toggle interaction emits a typed event rather than a raw DOM event string
    Given a SettingsToggle in the on state
    When the user interacts with the toggle
    Then a typed change event is emitted, not a raw DOM event string

  @ui @regression
  Scenario: Disabled toggle is not interactive and emits no event
    Given a SettingsToggle rendered in the disabled state
    When the user attempts to interact with the toggle
    Then no event is emitted and the state remains unchanged

  @ui @regression
  Scenario Outline: Absent or null prop value defaults to false without crashing
    Given a SettingsToggle receiving <prop_value> for its boolean prop
    When the component renders
    Then the toggle defaults to the off state and no crash occurs

  @ui @regression
  Scenario: All callers have been updated from string prop to boolean prop
    Given a SettingsToggle prop that changed from string to boolean in this PR
    When every usage site is inspected
    Then no caller passes a string value and all callers pass a typed boolean

  @api @ui @smoke @regression
  Scenario: All 13 changed files compile without errors under strict TypeScript settings
    Given the full set of 13 files changed by PR-3351071C
    When the TypeScript compiler runs in strict mode across all changed files
    Then there are zero compilation errors

  @api @ui @regression
  Scenario: No @ts-ignore suppressions were introduced by the PR
    Given the diff for PR-3351071C
    When the changed files are scanned for @ts-ignore comments
    Then no new @ts-ignore suppressions are present

  @api @ui @regression
  Scenario: Pre-existing passing tests continue to pass after the PR
    Given the test suite that was green before PR-3351071C
    When the full test suite is executed against the PR branch
    Then all previously passing tests still pass

  @api @ui @smoke @regression
  Scenario: End-to-end data flow from API layer through all cell components is correct
    Given real API responses flowing through DriverLogonCardTableColumnDefinitions into DateTimeLogonCell, DriverCell, LocationCell, and StatusCell, and then into DataRetention and OfflineNotifications
    When the full rendering flow is exercised
    Then data is correctly typed and rendered at every stage with no type errors or crashes

  @api @smoke @regression
  Scenario: The specific security-vulnerable code path identified in the PR is removed or guarded
    Given the code path that was vulnerable prior to PR-3351071C
    When the PR diff is reviewed and the guarded path is exercised
    Then the vulnerable path is no longer reachable or is properly guarded

  @api @regression
  Scenario: User-controlled data flowing into the API layer is typed and validated before use
    Given user-controlled inputs such as search strings, setting values, and entity IDs
    When those inputs are submitted to the API layer
    Then each input is validated against its strict type before being used, rejecting invalid values

  @api @ui @regression
  Scenario: Unexpected or malicious field values in API responses do not execute or render as code
    Given an API response containing a field value crafted to execute as script
    When the response is deserialised and rendered
    Then the value is treated as data, not executed, and no XSS occurs

  @api @regression
  Scenario: No new any casts were introduced that bypass strict typing
    Given the diff for PR-3351071C
    When all changed files are scanned for any type casts and type assertions
    Then no new any casts are present that would reopen type-unsafe paths

  @api @ui @smoke
  Scenario: Driver logon card table renders all column definitions and all four cell types with real data
    Given the application is loaded with a valid authenticated session for myeroad
    When the driver logon card table view is opened
    Then the table renders with all column definitions visible and DateTimeLogonCell, DriverCell, LocationCell, and StatusCell each display real data without errors

  @api @ui @smoke
  Scenario: Data retention settings page loads, displays the current period, and the modal completes successfully
    Given the application is loaded with a valid authenticated session for myeroad
    When the data retention settings page is opened
    Then the current retention period is displayed
      And when the user opens the update modal, enters a valid period, and submits
      And the modal closes and the updated retention period is reflected on the page

  @api @ui @smoke
  Scenario: Settings toggles for Offline Notifications and SettingsToggle persist state across page reload
    Given the application is loaded with a valid authenticated session for myeroad
    When the user toggles the Offline Notifications preference and reloads the page
    Then the toggled state is preserved after reload

  @api @ui @smoke
  Scenario: No console type errors or unhandled promise rejections occur during full smoke flow
    Given the application is loaded with a valid authenticated session for myeroad
    When the driver logon table, data retention page, and settings toggles are exercised in sequence
    Then the browser console contains no type errors and no unhandled promise rejections

