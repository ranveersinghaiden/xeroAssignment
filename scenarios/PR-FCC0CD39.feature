Feature: Tests for PR: PR-FCC0CD39

  @regression @smoke
  Scenario: Exported interfaces compile without any escape hatches
    Given the refactored types module is compiled under TypeScript strict mode
    When the compiler analyses all exported interfaces
    Then no interface contains an `any` type in any field position
      And zero TypeScript errors or suppressions are reported

  @regression
  Scenario: Interface fields match actual API response payload shape
    Given the API returns a settings response payload
    When the payload is assigned to the corresponding TypeScript interface
    Then every field name, type, nullability, and optionality matches the runtime shape

  @regression
  Scenario: Discriminated union exhaustiveness for status and type enums
    Given all variant values of each status and type enum are known
    When a switch or conditional is written over the discriminated union
    Then every variant has a corresponding interface branch and the compiler reports no missing cases

  @regression
  Scenario: Consumers that previously used any still compile with the new concrete type
    Given an existing consumer was typed as receiving `any` from the settings module
    When the module is updated to export the new concrete interfaces
    Then the consumer compiles without modification and without casting

  @regression
  Scenario: No implicit unknown to unsafe cast paths remain after refactor
    Given the refactored module is fully compiled
    When static analysis scans for `unknown` → unsafe cast patterns
    Then no such patterns exist in the settings module

  @regression
  Scenario: Optional versus required fields correctly reflect API nullability
    Given the API contract specifies which fields are nullable and which are always present
    When the TypeScript interfaces are inspected
    Then nullable fields are marked optional with `?` and always-present fields are required

  @api @smoke @regression
  Scenario: GET settings endpoint response satisfies the new typed interface
    Given the settings GET endpoint is called
    When the response is received and typed against the new response interface
    Then no required fields are missing and no unexpected fields violate the interface

  @api @regression
  Scenario: PUT and PATCH settings endpoints accept the new request interfaces
    Given a valid settings update payload conforming to the new request interface
    When the payload is serialised and sent via PUT or PATCH
    Then the round-tripped payload is identical to the input and the server accepts it

  @api @regression
  Scenario: Typed error responses do not cause a runtime crash
    Given the API returns an error response with an unexpected shape
    When the response handler processes the typed error interface
    Then the error is caught and handled gracefully without a runtime exception

  @api @regression
  Scenario: Null and empty collection responses do not produce type-cast failures
    Given the API returns null or an empty collection for a settings field
    When the typed interface processes the response
    Then no type-cast failure or runtime error occurs

  @api @regression
  Scenario: Fetch or Axios interceptors pass typed payloads through unchanged
    Given a typed payload is dispatched through the HTTP interceptor chain
    When the interceptors process the payload
    Then the payload emerges unchanged and still satisfies its typed interface

  @api @smoke
  Scenario: Malformed request payloads are rejected at the type boundary before dispatch
    Given a request payload that does not conform to the new typed interface
    When the payload is validated before being dispatched to the API
    Then it is rejected at the type boundary and never sent as a raw `any` value

  @api @regression
  Scenario: Deprecated any-typed API callers fail loudly with a TypeScript error
    Given an existing caller that relied on the deprecated `any`-typed API function
    When the module is compiled with the new typed signatures
    Then the compiler reports a clear TypeScript error rather than a silent runtime failure

  @api @regression
  Scenario: Column accessor IDs resolve against the new row data interface
    Given a DriverLogonCard table is rendered with typed row data
    When each ColumnDefinition accessor is evaluated against a row
    Then no cell produces an `undefined` value due to a missing or mismatched field

  @ui @regression
  Scenario: Column header labels render correctly after type renaming
    Given the column definitions reference renamed interface fields
    When the table header row is rendered
    Then each header label displays the correct human-readable text

  @ui @regression
  Scenario: Sort and filter functions behave correctly with typed values
    Given column sort and filter functions previously operated on `any` values
    When they are invoked with the new typed cell values
    Then sorting and filtering produce the same correct results as before the refactor

  @ui @regression
  Scenario: A row with all optional fields as null renders placeholder text
    Given a table row where every optional field is null or undefined
    When the row is rendered
    Then each cell displays a placeholder text and no crash occurs

  @ui @smoke @regression
  Scenario: DateTimeLogonCell renders a formatted date-time string from a typed timestamp
    Given a typed timestamp prop is passed to DateTimeLogonCell
    When the component renders
    Then a correctly formatted date-time string is displayed with the correct timezone offset

  @ui @regression
  Scenario: DateTimeLogonCell handles null or undefined timestamp gracefully
    Given a null or undefined timestamp prop is passed to DateTimeLogonCell
    When the component renders
    Then a fallback placeholder is shown and no crash occurs

  @ui @regression
  Scenario: DriverCell renders driver name and ID from the typed Driver interface
    Given a typed Driver prop with a name and ID is passed to DriverCell
    When the component renders
    Then both the driver name and ID are displayed correctly

  @ui @regression
  Scenario: DriverCell handles a missing driver name gracefully
    Given a typed Driver prop where the name field is absent
    When the component renders
    Then a fallback is shown without a crash

  @ui @regression
  Scenario: LocationCell renders a location string from the typed Location interface
    Given a typed Location prop with valid coordinates is passed to LocationCell
    When the component renders
    Then a human-readable location string is displayed

  @ui @regression
  Scenario: LocationCell handles null coordinates without crashing
    Given a typed Location prop where coordinates are null
    When the component renders
    Then a fallback placeholder is shown and no crash occurs

  @ui @smoke @regression
  Scenario: StatusCell renders the correct label and indicator for every valid Status enum value
    Given each valid value of the Status enum
    When StatusCell is rendered with that value as its typed prop
    Then the correct status label and visual indicator are displayed

  @ui @regression
  Scenario: StatusCell renders a fallback for unknown status values
    Given an unrecognised status value is passed to StatusCell
    When the component renders
    Then a fallback label is displayed and no crash occurs

  @ui @regression
  Scenario: Passing an incorrect prop shape to a cell component renders a fallback rather than crashing
    Given stale API data that does not match the current typed prop interface
    When the data is passed to any of the four cell components
    Then the component either renders a fallback or throws a caught error and never crashes the page silently

  @api @smoke @regression
  Scenario: Current retention period is fetched and displayed using the new typed response
    Given the data retention settings API returns a typed retention period
    When the DataRetention settings page loads
    Then the current retention period is displayed correctly

  @ui @regression
  Scenario: Retention period options list renders all valid entries from the typed enum
    Given the typed retention period options list is available
    When the DataRetention settings page renders the options
    Then every valid retention period option is listed and none are missing

  @api @regression
  Scenario: Selecting and saving a new retention period dispatches a correctly typed payload
    Given a new retention period is selected by the user
    When the user saves the setting
    Then the dispatched payload conforms to the new typed request interface

  @api @smoke
  Scenario: Minimum retention period enforcement prevents submitting a below-minimum value
    Given the typed interface defines a minimum allowable retention period
    When a payload specifying a retention period below the minimum is constructed
    Then the typed interface boundary rejects the value before it reaches the API

  @api @regression
  Scenario: API save failure on data retention is handled and the typed error response is parsed
    Given the data retention settings save API call fails
    When the error response is received
    Then the typed error response is parsed correctly and an error message is shown to the user

  @ui @smoke @regression
  Scenario: Modal opens pre-populated with the current retention period from typed props
    Given the DataRetentionPeriodUpdateModal receives the current period via typed props
    When the modal is opened
    Then the current retention period value is pre-populated in the modal

  @ui @regression
  Scenario: Confirm action dispatches a correctly typed update payload
    Given the user selects a new retention period in the modal
    When the user confirms the change
    Then a correctly typed update payload is dispatched to the parent or API

  @ui @regression
  Scenario: Cancel action leaves state unchanged
    Given the modal is open with a pre-populated retention period
    When the user cancels or dismisses the modal
    Then the retention period state remains unchanged

  @ui @regression
  Scenario: Loading state during async save is reflected in the modal
    Given the confirm action has been triggered and the API call is in progress
    When the modal is in the async loading state
    Then the loading indicator is visible and the confirm button is disabled

  @ui @regression
  Scenario: Confirm button is disabled while the typed period value is invalid or unchanged
    Given the modal is open and the selected period equals the current period or is invalid
    When the modal renders
    Then the confirm button is disabled

  @regression
  Scenario: Passing extra fields to a narrowed modal props interface produces a TypeScript error
    Given the modal's props interface was narrowed to remove previously accepted extra fields
    When a parent component passes those extra fields to the modal
    Then the TypeScript compiler reports an error rather than a silent runtime no-op

  @api @smoke @regression
  Scenario: Offline notification toggle is correctly initialised from the typed settings response
    Given the settings API returns a typed offline notification preference
    When the OfflineNotifications component loads
    Then the toggle reflects the value from the typed response

  @api @regression
  Scenario: Enabling offline notifications dispatches a correctly typed true payload
    Given the offline notifications toggle is currently off
    When the user enables notifications
    Then a payload with a typed boolean value of true is dispatched

  @api @smoke @regression
  Scenario: Disabling offline notifications dispatches a correctly typed false payload and not an any truthy value
    Given the offline notifications toggle is currently on
    When the user disables notifications
    Then a payload with a typed boolean value of false is dispatched and no `any` truthy value is used

  @api @regression
  Scenario: Notification preference persists across page navigation
    Given the user has saved a notification preference
    When the user navigates away and returns to the settings page
    Then the toggle reflects the previously saved preference

  @ui @regression
  Scenario: Toggle reverts to its previous state when the update API call fails
    Given the offline notifications toggle is in a known state
    When the user changes the toggle and the API update call fails
    Then the toggle reverts to its previous state

  @ui @smoke @regression
  Scenario: SettingsToggle renders correctly in the on state from a typed boolean prop
    Given a typed boolean prop of true is passed to SettingsToggle
    When the component renders
    Then the toggle visually reflects the on state

  @ui @regression
  Scenario: SettingsToggle renders correctly in the off state from a typed boolean prop
    Given a typed boolean prop of false is passed to SettingsToggle
    When the component renders
    Then the toggle visually reflects the off state

  @ui @regression
  Scenario: onChange callback is invoked with the correct typed boolean value
    Given a SettingsToggle is rendered with an onChange handler
    When the user clicks the toggle
    Then the onChange callback receives a typed boolean value and not a DOM event or `any`

  @ui @regression
  Scenario: Typed disabled prop prevents toggle interaction and callback invocation
    Given a SettingsToggle is rendered with the typed disabled prop set to true
    When the user attempts to click the toggle
    Then the toggle does not change state and the onChange callback is not invoked

  @ui @regression
  Scenario: aria-checked attribute matches the typed boolean value
    Given a SettingsToggle is rendered with a typed boolean prop
    When the component renders
    Then the aria-checked attribute value matches the typed boolean prop

  @regression
  Scenario: Passing a non-boolean to the value prop produces a TypeScript compile error
    Given an existing caller that previously passed a truthy non-boolean to the SettingsToggle value prop
    When the module is compiled with the new typed prop signature
    Then the TypeScript compiler reports an error for the non-boolean value

  @ui @smoke @regression
  Scenario: Full Settings page loads without runtime errors after the type refactor
    Given the application is built with the refactored settings module
    When the Settings page is navigated to
    Then the page loads completely without any runtime JavaScript errors

  @regression
  Scenario: All existing Settings-related unit tests pass unmodified
    Given the test suite contains pre-existing Settings unit tests
    When the full test suite is executed after the type refactor
    Then every pre-existing Settings unit test passes without modification to test logic

  @regression
  Scenario: Components outside the Settings module that import refactored types still compile and behave identically
    Given components in other modules import types from the refactored settings types module
    When those modules are compiled and their tests are executed
    Then compilation succeeds and all tests pass with identical behaviour

  @regression @smoke
  Scenario: TypeScript strict mode compile passes with zero errors and zero suppressions
    Given TypeScript strict mode is enabled for the project
    When the full project is compiled
    Then the compiler reports zero errors and no ts-ignore or @ts-expect-error suppressions are present in the settings module

  @regression
  Scenario: Bundle size does not increase unexpectedly due to new interface definitions materialised at runtime
    Given the production build is generated before and after the type refactor
    When the bundle sizes are compared
    Then the settings bundle size has not increased beyond an acceptable threshold caused by runtime interface materialisation

  @api @smoke
  Scenario: Oversized or malformed payloads on previously any-typed user input fields are rejected at the API layer
    Given a user input field that was previously typed as `any`
    When an oversized or structurally malformed payload is submitted
    Then the API layer rejects the payload and does not process it

  @api @smoke
  Scenario: A crafted retention period payload below the server-side minimum is rejected
    Given the typed retention period interface enforces the server-side minimum
    When a payload with a retention period below the minimum is constructed and submitted
    Then the request is rejected and the server-side minimum is enforced

  @api @regression
  Scenario: New interface fields do not expose internal server metadata to the client
    Given the new typed interfaces are inspected for fields present in the API response
    When each field is evaluated against the list of fields safe to expose to the client
    Then no field exposes internal server metadata unintentionally

  @api @smoke
  Scenario: Typed API responses are not passed to eval innerHTML or dangerouslySetInnerHTML
    Given typed API response data is consumed by the settings module
    When the data flow is traced through the component tree
    Then no typed response value is passed to eval, innerHTML, or dangerouslySetInnerHTML

  @regression @smoke
  Scenario: No new as any or unsafe widening casts were introduced in the fix
    Given the refactored settings module source files
    When the source is scanned for `as any` and `as unknown as X` patterns
    Then no new occurrences exist that were not present before the refactor

  @api @regression
  Scenario: Net-new exported interfaces have at least one positive and one negative test scenario
    Given new interfaces exported from the settings types module with no prior any equivalent
    When positive test data conforming to each interface is validated
    Then the data is accepted and all assertions pass
      And when non-conforming data is validated against each interface the type system rejects it

  @ui @regression
  Scenario: Settings UI correctly hides or shows features based on the presence of optional typed fields
    Given a settings response that includes some optional typed fields and omits others
    When the Settings page renders
    Then UI sections tied to present optional fields are visible and those tied to absent fields are hidden

  @api @regression
  Scenario: Type guard functions return true for valid interface shapes and false for invalid ones
    Given type guard functions introduced alongside the new interfaces
    When a valid object matching the interface shape is passed to a type guard
    Then the type guard returns true
      And when an invalid object is passed the type guard returns false

