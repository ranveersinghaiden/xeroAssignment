// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions
Now I have enough context. I'll add the new scenario to the feature file and add the step definitions to the existing `OfflineNotificationsSteps.java`.

Here is the output — the updated `OfflineNotificationsSteps.java` with the new step definitions, and the updated feature file:

---

**`src/test/resources/features/api/dashcam/offline_notifications.feature`**

```gherkin
@api @regression
Feature: OfflineNotifications Component Typed Interface

  Scenario: OfflineNotifications component uses typed OfflineNotification interface
    Given a typed OfflineNotification object with "deviceId", "deviceName", and "offlineSince" fields
    When the OfflineNotifications component renders the notification
    Then no TypeScript type error is thrown
    Then all typed fields are displayed correctly

  Scenario: OfflineNotifications component handles multiple offline devices correctly
    Given three dashcam devices where two are "OFFLINE" and one is "ONLINE"
    When the OfflineNotifications component processes the device list
    Then exactly two offline notifications are displayed
```

---

**`src/test/java/steps/api/OfflineNotificationsSteps.java`** (new steps appended):

```java
    @Given("three dashcam devices where two are {string} and one is {string}")
    public void threeDashcamDevicesWhereTwoAreStatusAndOneIsStatus(String offlineStatus, String onlineStatus) {
        Hooks.page.navigate(BASE_URL + "/dashcam/offline-notifications");
        Hooks.page.evaluate(
            "([offlineStatus, onlineStatus]) => {" +
            "  const devices = [" +
            "    { id: 'device-001', name: 'Dashcam Alpha', status: offlineStatus }," +
            "    { id: 'device-002', name: 'Dashcam Beta',  status: offlineStatus }," +
            "    { id: 'device-003', name: 'Dashcam Gamma', status: onlineStatus  }" +
            "  ];" +
            "  localStorage.setItem('dashcam.devices', JSON.stringify(devices));" +
            "}",
            new Object[]{new String[]{offlineStatus, onlineStatus}}
        );
    }

    @When("the OfflineNotifications component processes the device list")
    public void theOfflineNotificationsComponentProcessesTheDeviceList() {
        Hooks.page.reload();
        Hooks.page.waitForSelector("[data-testid='offline-notification']");
    }

    @Then("exactly two offline notifications are displayed")
    public void exactlyTwoOfflineNotificationsAreDisplayed() {
        int count = Hooks.page.locator("[data-testid='offline-notification']").count();
        assertEquals(2, count,
            "Expected exactly 2 offline notifications to be displayed, but found: " + count);
    }
```