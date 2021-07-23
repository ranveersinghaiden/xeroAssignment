using AddBankAccNumber.Helpers;
using AddBankAccNumber.POM.Web;
using System;
using System.Collections.Generic;
using System.Text;
using TechTalk.SpecFlow;

namespace AddBankAccNumber.Hooks.Web
{
    [Binding]
    class WebHooks : BaseWebClass
    {
        [BeforeFeature]
        public static void WebFeatureSetup()
        {
            envSetup = new EnvironmentSetup();

            browser = envSetup.GetEnvironmentVariables("browser");
            url = envSetup.GetEnvironmentVariables("browserUrl");
            DefaultUsername = envSetup.GetEnvironmentVariables("defaultUsername");
            DefaultPassword = envSetup.GetEnvironmentVariables("defaultPassword");
            browserMgr = new BrowserManager();
        }

        [BeforeScenario]
        public static void WebScenarioSetup()
        {
        }

        [AfterScenario]
        public void WebScenarioTeardown()
        {
            driver.Quit();
        }
    }
}
