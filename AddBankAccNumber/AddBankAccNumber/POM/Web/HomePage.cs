using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.POM.Web
{
    class HomePage
    {
        public By MainNavigationBar = By.ClassName("xnav-navigation");
        public By NavigationEventAccounting = By.CssSelector("[data-event-action='Clicked NAVIGATION: accounting']");
        public By NavigationSubEventBankAccount = By.CssSelector("[data-event-action='Clicked NAVIGATION_SUBMENU: bank-accounts']");
    }
}
