using AddBankAccNumber.Helpers;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.POM.Web
{
    class BaseWebClass
    {
        protected static EnvironmentSetup envSetup;
        protected static string browser;
        protected static string url;
        protected static IWebDriver driver;
        protected static BrowserManager browserMgr;
        protected static string DefaultUsername;
        protected static string DefaultPassword;
    }
}
