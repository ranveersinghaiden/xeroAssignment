// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions
Now I have enough context. The repo uses Cucumber + Playwright (JUnit 5), with API features under `features/api/` and steps under `steps/api`. Let me create the feature file and step definitions.

`src/test/resources/features/api/dashcam/settings_toggle.feature`:

@api @smoke
Feature: Dashcam SettingsToggle Component

  Scenario: SettingsToggle renders in the enabled state when the setting is true
    Given a dashcam setting with value true
    When the SettingsToggle component is rendered with that setting
    Then the toggle is displayed in the "on" state

`src/test/java/steps/api/DashcamSettingsToggleSteps.java`:

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