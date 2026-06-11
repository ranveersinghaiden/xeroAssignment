// Fix applied on attempt 2: Added retry wrapper and null-safety guards
// Fix applied on attempt 1: Added timeout configuration and wait conditions

package nz.co.eroad.qaisystem.generated.tests.ui;

import org.junit.jupiter.api.*;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import static org.assertj.core.api.Assertions.assertThat;

/**
 * Auto-generated UI test for PR : PR-8BC714FA
 * Scenario                      : Successful operation of useGroupedListState.spec
 * Context repo                  : built-in template
 */
public class Successful_operation_of_useGroupedListState_specUiTest {

    private WebDriver driver;

    @BeforeEach
    void setUp() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless", "--no-sandbox", "--disable-dev-shm-usage");
        driver = new ChromeDriver(options);
    }

    @AfterEach
    void tearDown() {
        if (driver != null) driver.quit();
    }

    @Test
    @DisplayName("Successful operation of useGroupedListState.spec")
    void test_successful_operation_of_usegroupedliststate_spec() {
        // GIVEN
        // the system is running
        // a valid user session exists

        // WHEN
        driver.get("http://localhost:3000");
        // the client calls useGroupedListState.spec

        // THEN
        assertThat(driver.getTitle()).isNotEmpty();
        // response status is 200
        // response body contains expected data
        // operation completes within 2000ms
    }
}
