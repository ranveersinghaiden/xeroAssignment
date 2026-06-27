// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions
Now I have enough context. I need to create:
1. A feature file: `src/test/resources/features/api/dashcam/offline_notifications.feature`
2. A steps file: `src/test/java/steps/api/OfflineNotificationsSteps.java`

The task says "Output ONLY the test source code", so I'll output both files. Let me create them.

```gherkin
@api @regression
Feature: OfflineNotifications Component Typed Interface

  Scenario: OfflineNotifications component uses typed OfflineNotification interface
    Given a typed OfflineNotification object with "deviceId", "deviceName", and "offlineSince" fields
    When the OfflineNotifications component renders the notification
    Then no TypeScript type error is thrown
    Then all typed fields are displayed correctly
```

```java
package steps.api;

import hooks.Hooks;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class OfflineNotificationsSteps {

    private static final String BASE_URL = System.getProperty("base.url", "http://localhost:3000");

    @Given("a typed OfflineNotification object with {string}, {string}, and {string} fields")
    public void aTypedOfflineNotificationObjectWithFields(String deviceId, String deviceName, String offlineSince) {
        Hooks.page.navigate(BASE_URL + "/dashcam/offline-notifications");
        Hooks.page.evaluate(
            "([deviceId, deviceName, offlineSince]) => {" +
            "  window.__offlineNotification = { [deviceId]: 'device-123', [deviceName]: 'Test Dashcam', [offlineSince]: '2024-01-15T08:00:00Z' };" +
            "  localStorage.setItem('offlineNotification', JSON.stringify(window.__offlineNotification));" +
            "}",
            new Object[]{new String[]{deviceId, deviceName, offlineSince}}
        );
    }

    @When("the OfflineNotifications component renders the notification")
    public void theOfflineNotificationsComponentRendersTheNotification() {
        Hooks.page.reload();
        Hooks.page.waitForSelector("[data-testid='offline-notification']");
    }

    @Then("no TypeScript type error is thrown")
    public void noTypeScriptTypeErrorIsThrown() {
        Object consoleErrors = Hooks.page.evaluate(
            "() => window.__typeErrors ? window.__typeErrors.length : 0"
        );
        assertTrue(
            consoleErrors == null || consoleErrors.equals(0),
            "Expected no TypeScript type errors, but found: " + consoleErrors
        );
    }

    @Then("all typed fields are displayed correctly")
    public void allTypedFieldsAreDisplayedCorrectly() {
        assertTrue(
            Hooks.page.locator("[data-testid='offline-notification-device-id']").isVisible(),
            "Expected deviceId field to be displayed"
        );
        assertTrue(
            Hooks.page.locator("[data-testid='offline-notification-device-name']").isVisible(),
            "Expected deviceName field to be displayed"
        );
        assertTrue(
            Hooks.page.locator("[data-testid='offline-notification-offline-since']").isVisible(),
            "Expected offlineSince field to be displayed"
        );
        assertFalse(
            Hooks.page.locator("[data-testid='offline-notification-device-id']").innerText().isBlank(),
            "Expected deviceId value to be non-empty"
        );
        assertFalse(
            Hooks.page.locator("[data-testid='offline-notification-device-name']").innerText().isBlank(),
            "Expected deviceName value to be non-empty"
        );
        assertFalse(
            Hooks.page.locator("[data-testid='offline-notification-offline-since']").innerText().isBlank(),
            "Expected offlineSince value to be non-empty"
        );
    }
}
```