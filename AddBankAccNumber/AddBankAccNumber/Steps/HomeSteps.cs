using AddBankAccNumber.POM.Web;
using AddBankAccNumber.POM.Web.Accounting;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;
using TechTalk.SpecFlow;
using Xunit;

namespace AddBankAccNumber.Steps
{
    [Binding]
    class HomeSteps : CommonSteps
    {
        public static HomePage HomePageObject;
        public static BankAccountsPage BankAccountsPageObject;

        public HomeSteps()
        {
            HomePageObject = new HomePage();
            BankAccountsPageObject = new BankAccountsPage();
        }

        [Given("I navigate to Bank Accounts page")]
        [When("I navigate to Bank Accounts page")]
        [Then("I navigate to Bank Accounts page")]
        public void GivenINavigateToBankAccountsPage()
        {
            IWebElement AccountingTab = Test.WaitUntilElementIsClickable(HomePageObject.NavigationEventAccounting);
            AccountingTab.Click();

            IWebElement BankAccountsOption = Test.WaitUntilElementIsVisible(HomePageObject.NavigationSubEventBankAccount);
            BankAccountsOption.Click();

            IWebElement AddBankAccountButton = Test.WaitUntilElementIsVisible(BankAccountsPageObject.AddBankAccountButton);
            Assert.True(AddBankAccountButton.Displayed);
        }
    }
}
