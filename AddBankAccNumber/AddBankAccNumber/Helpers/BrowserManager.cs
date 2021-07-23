using AddBankAccNumber.POM.Web;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Support.UI;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.Helpers
{
    class BrowserManager : BaseWebClass
    {
        public IWebDriver CreateWebDriver(string browser)
        {
            IWebDriver driver;

            // Switch case can be used to initialize different browsers.
            //
            //switch (browser)
            //{
            //    case "chrome":
            //        driver = new ChromeDriver((ChromeOptions)CreateDriverOptions(browser));
            //        break;
            //    //default:
            //    //    driver = new FirefoxDriver((FirefoxOptions)CreateDriverOptions(browser));
            //    //    break;
            //    default: break;
            //}

            driver = new ChromeDriver((ChromeOptions)CreateDriverOptions(browser));
            return driver;
        }

        public DriverOptions CreateDriverOptions(string browser)
        {
            // Switch case can be used to initialize different browser options.
            //
            //DriverOptions driverOptions;

            //switch (browser)
            //{
            //    case "chrome":
            //        driverOptions = new ChromeOptions();
            //        break;
            //    //default:
            //    //    driverOptions = new FirefoxOptions();
            //    //    break;
            //}

            return new ChromeOptions();
        }
    }
}
