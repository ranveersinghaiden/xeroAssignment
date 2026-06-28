Feature: Tests for PR: PR-D6D336C1

  Scenario: Display formatted date and time values in the dashcam domain
    Given a dashcam record with a date-time value provided as an ISO string
    When the record is displayed in the system
    Then the date and time should be formatted and displayed with the appropriate timezone

  @VSF-3500
  Scenario: Render nothing when no date-time value is provided
    Given a dashcam record with no date-time value
    When the record is displayed in the system
    Then the system should render nothing instead of an empty element

  @VSF-3500
  Scenario: Fetch a list of dashcams with filtering, pagination, and sorting
    Given the user requests a list of dashcams
    When the user applies filters for serial number, lifecycle state, and health status
      And the user specifies pagination and sorting preferences
    Then the system should return a filtered, paginated, and sorted list of dashcams

  @VSF-3500
  Scenario: Retrieve snapshots for a specific dashcam
    Given a dashcam with a unique identifier
    When the user requests snapshots for the dashcam
    Then the system should retrieve and display the snapshots for the specified dashcam

  @VSF-3500
  Scenario: Assign a dashcam to a machine
    Given a dashcam and a machine
      And a payload with device configurations and plans
    When the user assigns the dashcam to the machine
    Then the system should successfully assign the dashcam to the specified machine

  @VSF-3500
  Scenario: Fetch the count of add-ons for a specific machine
    Given a machine with a unique identifier
    When the user requests the count of add-ons for the machine
    Then the system should return the correct count of add-ons

  @VSF-3500
  Scenario: Retrieve available products for a machine and dashcam combination
    Given a machine and a dashcam
    When the user requests available products for the combination
    Then the system should return a list of available products

  @VSF-3500
  Scenario: Check the availability of a machine for dashcam assignment
    Given a machine with a unique identifier
    When the user checks the availability of the machine for dashcam assignment
    Then the system should indicate whether the machine is available for assignment

  @VSF-3500
  Scenario: Reassign a dashcam from one machine to another
    Given a dashcam assigned to a machine
      And a new machine with a unique identifier
    When the user reassigns the dashcam to the new machine
    Then the system should successfully update the assignment to the new machine

