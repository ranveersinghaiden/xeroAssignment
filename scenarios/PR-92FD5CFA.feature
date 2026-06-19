Feature: Tests for PR: PR-92FD5CFA

  @api @smoke @regression
  Scenario: Strict-typed props satisfy new signatures at all call sites
    Given the Fleet domain components have had TSFixMe removed
    When DriverLogonCardTableColumnDefinitions, DateTimeLogonCell, DriverCell, LocationCell, and StatusCell are instantiated with their production props
    Then no `any` coercion exists at any call site and all props conform to their strict type signatures

  @api @regression
  Scenario: Shared type exports remain backwards-compatible with external consumers
    Given consumers outside the Fleet domain import shared types from the types module
    When those modules are compiled after the TSFixMe removal
    Then no compilation errors are produced and all existing usages remain valid

  @api @regression
  Scenario: Nullable and non-nullable field distinctions are correctly handled
    Given TSFixMe removal has introduced explicit nullable vs non-nullable field distinctions
    When components receive nullable values such as an optional driver ID or a nullable location
    Then the components handle null and undefined values without throwing and render appropriate fallbacks

  @api @regression
  Scenario: Union and discriminated union types are exhaustively handled
    Given TSFixMe has been replaced with union or discriminated union types
    When all switch statements and conditional branches that consume those types are evaluated
    Then every variant is handled and no unmatched branch causes a runtime error

  @api @regression
  Scenario: API response shapes conform to newly typed interfaces
    Given the api module returns responses shaped to updated TypeScript interfaces
    When those responses are consumed by Fleet domain components
    Then no silent any-to-typed coercion gaps exist and all fields are correctly typed

  @api @smoke @regression
  Scenario: All expected columns are present in the column definition array
    Given a valid driver logon dataset
    When DriverLogonCardTableColumnDefinitions is called
    Then the returned array contains the expected column count with correct keys and header labels

  @api @regression
  Scenario: Cell renderers are correctly wired to their respective columns
    Given the column definitions are generated
    When each column's cell renderer reference is inspected
    Then DateTimeLogonCell is wired to the date-time column, DriverCell to the driver column, LocationCell to the location column, and StatusCell to the status column

  @api @regression
  Scenario: Sort and filter configuration is preserved after refactor
    Given column definitions were previously configured with sort and filter options
    When DriverLogonCardTableColumnDefinitions is called after the refactor
    Then sort and filter configuration on each column is identical to the pre-refactor baseline

  @api @regression
  Scenario: Column definitions return correctly for an empty driver logon array
    Given driver logon data is an empty array
    When DriverLogonCardTableColumnDefinitions is called
    Then the definition array is returned without error and all columns are present

  @api @regression
  Scenario: Column definitions handle missing optional column metadata without throwing
    Given some optional column metadata fields are absent
    When DriverLogonCardTableColumnDefinitions is called
    Then the function returns a valid definition array and does not throw

  @ui @smoke @regression
  Scenario: DateTimeLogonCell renders a formatted date-time string for a valid ISO timestamp
    Given DateTimeLogonCell receives a valid ISO 8601 timestamp as its value prop
    When the component renders
    Then a formatted human-readable date-time string is displayed

  @ui @regression
  Scenario: DateTimeLogonCell renders a fallback when value is null or undefined
    Given DateTimeLogonCell receives null or undefined as its value prop
    When the component renders
    Then an empty state or placeholder is displayed and no error is thrown

  @ui @regression
  Scenario: DateTimeLogonCell handles timezone correctly
    Given DateTimeLogonCell receives a UTC ISO timestamp
    When the component renders with a configured local timezone
    Then the displayed time reflects the correct local offset and not raw UTC

  @ui @smoke @regression
  Scenario: DriverCell displays driver name and ID for an assigned driver
    Given DriverCell receives a fully populated driver object with name and ID
    When the component renders
    Then the driver name and driver ID are both visible in the cell

  @ui @regression
  Scenario: DriverCell handles anonymous or unassigned driver state
    Given DriverCell receives a driver object representing an anonymous or unassigned driver
    When the component renders
    Then an appropriate placeholder or anonymous label is displayed without throwing

  @ui @regression
  Scenario: LocationCell renders location name for a valid location
    Given LocationCell receives a location object with a non-null name
    When the component renders
    Then the location name is displayed in the cell

  @ui @regression
  Scenario: LocationCell handles null location gracefully
    Given LocationCell receives a null location value
    When the component renders
    Then an appropriate placeholder is shown and no crash occurs

  @ui @smoke @regression
  Scenario Outline: StatusCell renders the correct badge for all known status values
    Given StatusCell receives the status value "<status>"
    When the component renders
    Then the correct badge or label "<expected_label>" is displayed

  @ui @regression
  Scenario: StatusCell handles unknown status values without throwing
    Given StatusCell receives an unrecognised status value not in the known enum
    When the component renders
    Then no exception is thrown and a safe fallback is displayed

  @ui @regression
  Scenario: All four cell components re-render correctly when input props change
    Given DateTimeLogonCell, DriverCell, LocationCell, and StatusCell are mounted with initial props
    When the parent component triggers a data refresh and new props are passed
    Then each cell re-renders with the updated values and no stale data is displayed

  @api @smoke @regression
  Scenario: DataRetention API returns the current retention period setting
    Given a configured data retention period exists
    When the DataRetention API is called to retrieve the setting
    Then the correct retention period value is returned with the correct type

  @api @regression
  Scenario: Default retention period is applied when no explicit value is configured
    Given no explicit data retention period has been configured
    When the DataRetention API is called
    Then the default retention period is returned

  @api @regression
  Scenario: Out-of-range retention period values are rejected or clamped
    Given a retention period value outside the permitted range is submitted
    When the DataRetention API processes the value
    Then the value is rejected with a validation error or clamped to the allowed boundary

  @api @regression
  Scenario: Retention period is correctly typed as a number enabling safe arithmetic
    Given the DataRetention API returns a retention period
    When the returned value is used in arithmetic operations
    Then the value is a numeric type and no type coercion errors occur

  @api @regression
  Scenario: DataRetention API does not expose internal config fields
    Given the DataRetention API response is inspected
    When the response payload is examined after type tightening
    Then no previously hidden internal configuration fields are present in the response

  @api @smoke @regression
  Scenario: Modal submission sends a correctly typed payload to the update API
    Given the DataRetentionPeriodUpdateModal is open with a valid new retention value
    When the user submits the modal
    Then the update API receives a payload with the retention period as a correctly typed integer

  @api @regression
  Scenario: Modal validation rejects non-integer or negative retention period values
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a non-integer or negative value and attempts to submit
    Then a validation error is displayed and the API is not called

  @api @regression
  Scenario: Modal validation rejects values exceeding the maximum allowed retention period
    Given the DataRetentionPeriodUpdateModal is open
    When the user enters a value exceeding the maximum allowed retention period and attempts to submit
    Then a validation error is displayed and the API is not called

  @api @smoke @regression
  Scenario: Successful update closes the modal and reflects the new value
    Given the DataRetentionPeriodUpdateModal is open with a valid new retention value
    When the user submits and the API returns a success response
    Then the modal closes and the parent component displays the updated retention period

  @api @regression
  Scenario: API error response surfaces a user-readable error message
    Given the DataRetentionPeriodUpdateModal is open and the update API returns an error
    When the user submits the modal
    Then a user-readable error message is displayed and no raw type or server error is exposed

  @api @regression
  Scenario: Modal cancel action does not persist any changed values
    Given the DataRetentionPeriodUpdateModal is open and the user has modified the retention value
    When the user cancels the modal without submitting
    Then the retention period shown in the parent component remains unchanged

  @api @smoke @regression
  Scenario: Offline notification settings are loaded correctly on component init
    Given the OfflineNotifications component is mounted
    When the component initialises and the API responds
    Then all notification settings are loaded and displayed with correct initial state

  @api @regression
  Scenario: Enabling or disabling a notification type sends a correctly typed toggle payload
    Given the OfflineNotifications component is mounted with existing settings
    When the user toggles a notification type
    Then the API receives a correctly typed payload reflecting the new enabled or disabled state

  @api @regression
  Scenario: Notification settings persist across page refresh
    Given the user has updated an offline notification setting
    When the page is refreshed and the component re-initialises
    Then the updated setting is retrieved from the API and displayed correctly

  @api @regression
  Scenario: OfflineNotifications API module handles 4xx and 5xx responses safely
    Given the OfflineNotifications API returns a 4xx or 5xx error
    When the component processes the error response
    Then no raw error object is exposed to the UI layer and a safe error state is shown

  @api @smoke @regression
  Scenario: All Fleet-domain API functions have return types matching updated type definitions
    Given the Fleet domain api module has been refactored with updated types
    When all exported API functions are inspected for their return type signatures
    Then each return type matches the corresponding updated interface in the types module

  @api @regression
  Scenario: API request payloads are serialised correctly with no unexpected any-typed fields
    Given a Fleet domain API function is called with a typed request object
    When the serialised payload is captured
    Then all fields are serialised to their expected JSON types with no unexpected any coercion

  @api @regression
  Scenario: API functions handle network timeout and abort correctly
    Given a Fleet domain API call is in flight
    When the request times out or is aborted
    Then the API function rejects with a typed error and does not hang or throw an unhandled exception

  @api @security @smoke @regression
  Scenario: Authentication and authorisation headers are present on all Fleet API calls
    Given an authenticated user session exists
    When any Fleet domain API function makes an HTTP request
    Then the request includes the required authentication and authorisation headers

  @api @security @regression
  Scenario: Error responses are typed and do not leak server-side details to the caller
    Given a Fleet API call returns an error response containing server-side detail
    When the error is processed by the API module
    Then only a typed, sanitised error object is returned to the caller and raw server details are not exposed

  @api @regression
  Scenario: All previously passing api.spec UI scenarios continue to pass after type refactor
    Given the api.spec test suite existed before the TSFixMe removal
    When the full api.spec suite is executed after the refactor
    Then all previously passing scenarios still pass with no regressions

  @api @ui @smoke @regression
  Scenario: SettingsToggle renders correctly in enabled and disabled states
    Given SettingsToggle is rendered with enabled set to true
    When the component renders
    Then it displays in the active/on visual state
      And when enabled is set to false it displays in the inactive/off visual state

  @api @ui @regression
  Scenario: SettingsToggle fires the correct callback with the correct typed argument on change
    Given SettingsToggle is rendered with an onChange callback
    When the user clicks the toggle
    Then the onChange callback is invoked with the correctly typed boolean argument reflecting the new state

  @api @ui @regression
  Scenario: SettingsToggle ignores clicks when the disabled prop is true
    Given SettingsToggle is rendered with the disabled prop set to true
    When the user clicks the toggle
    Then the onChange callback is not invoked and the toggle state does not change

  @api @ui @regression
  Scenario: SettingsToggle re-renders with new value from parent without retaining stale local state
    Given SettingsToggle is rendered as a controlled component with an initial value
    When the parent component passes an updated value prop
    Then the toggle re-renders to reflect the new value and does not display stale local state

  @api @security @smoke @regression
  Scenario: Data retention update endpoint enforces authorisation for unauthenticated requests
    Given no valid authentication credentials are provided
    When a request is made to the data retention period update endpoint
    Then the server responds with HTTP 401 or 403 and the update is not applied

  @api @security @regression
  Scenario: DataRetentionPeriodUpdateModal input is validated server-side
    Given a malformed or out-of-range retention period value is submitted directly to the server API
    When the server processes the request bypassing client-side validation
    Then the server rejects the value with an appropriate validation error response

  @api @security @regression
  Scenario: Fleet API responses do not include fields beyond what the caller requires
    Given the Fleet API returns a response after type tightening
    When the response payload is inspected for over-exposure
    Then no extraneous or sensitive fields beyond the caller's typed interface are present

  @api @security @regression
  Scenario: TSFixMe removal has not introduced a code path bypassing input sanitisation
    Given all new code paths introduced by TSFixMe replacement are identified
    When those paths are exercised with unsanitised or malicious input
    Then input sanitisation is applied on every path and no bypass is possible

  @ui @smoke @regression
  Scenario: Driver logon card table renders all columns with real API data
    Given the driver logon page is loaded with data returned from the real API
    When the logon card table is displayed
    Then all expected columns are rendered with correct data in every row

  @ui @regression
  Scenario: Sorting by the date-time column works correctly
    Given the driver logon card table is displaying data
    When the user clicks the date-time column header to sort
    Then rows are reordered in the correct ascending or descending date-time order

  @ui @regression
  Scenario: Sorting by driver, location, and status columns works correctly
    Given the driver logon card table is displaying data
    When the user clicks the driver, location, or status column header to sort
    Then rows are reordered according to the selected column without error

  @ui @regression
  Scenario: Empty state renders without error when there are no logon records
    Given the API returns an empty array of driver logon records
    When the driver logon card table is rendered
    Then the empty state UI is displayed and no JavaScript error is thrown

  @ui @regression
  Scenario: Data refresh and pagination do not cause type errors or blank cells
    Given the driver logon card table is displaying the first page of data
    When the user navigates to the next page or triggers a data refresh
    Then all cells render with correct data and no blank or errored cells appear

  @ui @smoke @regression
  Scenario: Full user flow — load page, view logon table, update data retention, confirm modal, verify new period
    Given an authenticated user navigates to the Fleet driver logon page
    When the user views the logon table
      And the user opens the data retention period update modal
      And the user enters a valid new retention period and confirms
    Then the modal closes successfully
      And the updated retention period is displayed in the parent component
      And no type errors occur at any step of the flow

  @api @regression
  Scenario: All imports of Fleet domain types from other modules compile without errors
    Given modules outside the Fleet domain import types from the Fleet types module
    When those modules are compiled after the type tightening
    Then all imports resolve successfully and no new compilation errors are introduced

  @ui @regression
  Scenario: Components outside Fleet that render DriverCell, LocationCell, or StatusCell still render correctly
    Given a component outside the Fleet domain renders DriverCell, LocationCell, or StatusCell
    When that component is rendered after the type refactor
    Then it renders correctly without type errors or visual regressions

  @api @regression
  Scenario: No new TypeScript compilation errors are introduced in dependent modules
    Given all modules that depend on Fleet domain exports are compiled together
    When the full project TypeScript compilation is run after the TSFixMe removal
    Then the compilation completes with zero new errors in any dependent module

