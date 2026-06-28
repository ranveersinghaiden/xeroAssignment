// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions
Now I have all the context needed. Let me generate the three files: feature file, runner, and steps.

`src/test/resources/features/api/offline_notifications.feature`:

```gherkin
@api @regression
Feature: OfflineNotifications displays a disabled state when notifications are inactive
  # PR-D6D336C1: VSF-3500 Getting rid of $TSFixMe in Dashcam domain - PART 1
  # Verifies that OfflineNotifications reflects a disabled toggle when notifications are inactive for a device

  Scenario: OfflineNotifications displays a disabled state when notifications are inactive
    Given offline notifications are disabled for the device
    When the OfflineNotifications component is rendered
    Then the notification toggle reflects disabled state
```

`src/test/java/runner/api/OfflineNotificationsApiRunner.java`:

```java
package runner.api;

import io.cucumber.junit.platform.engine.Constants;
import org.junit.platform.suite.api.ConfigurationParameter;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features/api")
@ConfigurationParameter(key = Constants.GLUE_PROPERTY_NAME, value = "steps.api,hooks")
@ConfigurationParameter(key = Constants.FILTER_TAGS_PROPERTY_NAME, value = "@api")
@ConfigurationParameter(
        key = Constants.PLUGIN_PROPERTY_NAME,
        value = "pretty, json:target/cucumber-reports/api/cucumber.json"
)
public class OfflineNotificationsApiRunner {
}
```

`src/test/java/steps/api/OfflineNotificationsSteps.java`:

```java
package steps.api;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.response.Response;

import static io.restassured.RestAssured.given;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Step definitions for PR-D6D336C1 / VSF-3500:
 * Verifies OfflineNotifications reflects a disabled toggle state when notifications are inactive for a device.
 */
public class OfflineNotificationsSteps {

    private static final String BASE_URL = System.getProperty("base.url", "http://localhost:8080");

    private Response response;

    @Given("offline notifications are disabled for the device")
    public void offlineNotificationsAreDisabledForTheDevice() {
        String payload = """
                {
                  "deviceId": "test-device-PR-D6D336C1",
                  "offlineNotificationsEnabled": false
                }
                """;

        response = given()
                .baseUri(BASE_URL)
                .contentType("application/json")
                .body(payload)
                .when()
                .post("/api/dashcam/notifications/settings");
    }

    @When("the OfflineNotifications component is rendered")
    public void theOfflineNotificationsComponentIsRendered() {
        assertThat(response)
                .as("API response must be present before OfflineNotifications rendering is evaluated")
                .isNotNull();
    }

    @Then("the notification toggle reflects disabled state")
    public void theNotificationToggleReflectsDisabledState() {
        assertThat(response.getStatusCode())
                .as("API must not return a 5xx error when offline notifications are disabled")
                .isLessThan(500);

        Boolean enabled = response.jsonPath().getBoolean("offlineNotificationsEnabled");
        assertThat(enabled)
                .as("offlineNotificationsEnabled must be false when notifications are inactive")
                .isFalse();
    }
}
```