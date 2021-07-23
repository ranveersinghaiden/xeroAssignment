using AddBankAccNumber.POM.Web;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.Helpers
{
    class SeleniumHelper : BaseWebClass
    {
        public void OpenBrowser(string browserName)
        {
            driver = browserMgr.CreateWebDriver(browserName);
            driver.Manage().Window.Maximize();
        }

        public void OpenBrowser()
        {
            OpenBrowser(browser);
        }

        public void NavigateToUrl(string testUrl)
        {
            driver.Navigate().GoToUrl(testUrl);
        }

        public void NavigateToUrl()
        {
            NavigateToUrl(url);
        }

        public IWebElement WaitUntilElementIsClickable(By element, int timeoutInSeconds = 30)
        {
            WebDriverWait tempWait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeoutInSeconds));
            return tempWait.Until<IWebElement>(SeleniumExtras.WaitHelpers.ExpectedConditions.ElementToBeClickable(element));            
        }

        public IWebElement WaitUntilElementIsVisible(By element, int timeoutInSeconds = 30)
        {
            WebDriverWait tempWait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeoutInSeconds));
            return tempWait.Until<IWebElement>(SeleniumExtras.WaitHelpers.ExpectedConditions.ElementIsVisible(element));            
        }

        public IWebElement WaitUntilELementIsPresent(By element, int timeoutInSeconds = 30)
        {
            WebDriverWait tempWait = new WebDriverWait(driver, TimeSpan.FromSeconds(timeoutInSeconds));
            return tempWait.Until<IWebElement>(driver => driver.FindElement(element));
        }

        public void EnterText(By element, string text)
        {
            IWebElement inputElement = WaitUntilElementIsClickable(element);
            inputElement.Click();
            inputElement.SendKeys(text);
        }

        public void Click(By element)
        {
            WaitUntilElementIsClickable(element).Click();
        }

        public bool CheckIfElementIsVisible(By element)
        {
            try
            {
                var ele = driver.FindElement(element);
                return ele.Displayed;
            }
            catch (NoSuchElementException ex) {
            }

            return false;
        }
    }
}
