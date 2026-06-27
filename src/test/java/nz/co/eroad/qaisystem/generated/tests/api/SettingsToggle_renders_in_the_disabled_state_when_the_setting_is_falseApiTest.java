// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions
Now I have all the context. I need to:
1. Add the new scenario to the `.feature` file
2. Add the new step (`aDashcamSettingWithValueFalse`) to the steps class

The `@When` and `@Then` steps are already covered by existing step definitions (shared wording). Only the `@Given` step for `false` is new. The feature file needs the new scenario, and the steps class needs the new `@Given`.

The task asks for the test source code — the feature file is the BDD test, and the steps Java file is its implementation. I'll output the updated feature file and the steps file with the new step added.

Since the task says "generate a single API test… Output ONLY the test source code", I'll output the complete updated feature file (which is the test artifact) followed by the updated steps class:

```gherkin
@api @smoke
Feature: Dashcam SettingsToggle Component

  Scenario: SettingsToggle renders in the enabled state when the setting is true
    Given a dashcam setting with value true
    When the SettingsToggle component is rendered with that setting
    Then the toggle is displayed in the "on" state

  Scenario: SettingsToggle renders in the disabled state when the setting is false
    Given a dashcam setting with value false
    When the SettingsToggle component is rendered with that setting
    Then the toggle is displayed in the "off" state
```

```java
package steps.api;

import hooks.Hooks;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class DashcamSettingsToggleSteps {

    private static final String BASE_URL = System.getProperty("base.url", "http://localhost:3000");

    @Given("a dashcam setting with value true")
    public void aDashcamSettingWithValueTrue() {
        Hooks.page.navigate(BASE_URL + "/dashcam/settings");
        Hooks.page.evaluate("() => { localStorage.setItem('dashcam.settings.enabled', 'true'); }");
    }

    @Given("a dashcam setting with value false")
    public void aDashcamSettingWithValueFalse() {
        Hooks.page.navigate(BASE_URL + "/dashcam/settings");
        Hooks.page.evaluate("() => { localStorage.setItem('dashcam.settings.enabled', 'false'); }");
    }

    @When("the SettingsToggle component is rendered with that setting")
    public void theSettingsToggleComponentIsRenderedWithThatSetting() {
        Hooks.page.reload();
        Hooks.page.waitForSelector("[data-testid='settings-toggle']");
    }

    @Then("the toggle is displayed in the {string} state")
    public void theToggleIsDisplayedInState(String expectedState) {
        String selector = "on".equals(expectedState)
                ? "[data-testid='settings-toggle'][aria-checked='true']"
                : "[data-testid='settings-toggle'][aria-checked='false']";
        assertTrue(
                Hooks.page.locator(selector).isVisible(),
                "Expected SettingsToggle to be in the '" + expectedState + "' state"
        );
    }
}
```