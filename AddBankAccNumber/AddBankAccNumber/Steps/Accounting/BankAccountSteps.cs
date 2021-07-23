using AddBankAccNumber.POM.Web.Accounting;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;
using TechTalk.SpecFlow;
using Xunit;

namespace AddBankAccNumber.Steps.Accounting
{
    [Binding]
    class BankAccountSteps : CommonSteps
    {
        public BankAccountsPage BankAccountsPageObject;

        public BankAccountSteps()
        {
            BankAccountsPageObject = new BankAccountsPage();
        }

        [Given("I click 'Add Bank Account' button.")]
        public void GivenIClickOnAddBankAccountButton()
        {
            Test.Click(BankAccountsPageObject.AddBankAccountButton);
            IWebElement searchResults = Test.WaitUntilElementIsVisible(BankAccountsPageObject.SearchResults);
            Assert.True(searchResults.Displayed);
        }

        [Given("I am taken to bank search page")]
        [When("I am taken to bank search page")]
        [Then("I am taken to bank search page")]
        public void ThenIAmTakenToBankSearchPage()
        {
            IWebElement searchBar = Test.WaitUntilElementIsVisible(BankAccountsPageObject.SearchBar);
            Assert.True(searchBar.Displayed);
        }

        [Given("I search for ANZ bank")]
        public void GivenISearchForBank()
        {
            IWebElement searchResults = Test.WaitUntilElementIsVisible(BankAccountsPageObject.SearchResults);
            IWebElement searchResultANZ;

            try {
                // Check if bank is listed in default search list
                searchResultANZ = searchResults.FindElement(BankAccountsPageObject.SearchResultANZ);
            }
            catch (NoSuchElementException ex) {
                // Search for bank using search bar
                IWebElement searchBar = Test.WaitUntilElementIsVisible(BankAccountsPageObject.SearchBar);
                searchBar.Click();
                searchBar.SendKeys("ANZ (NZ)");
                searchResultANZ = Test.WaitUntilElementIsClickable(BankAccountsPageObject.SearchResultANZ);
            }
            
            searchResultANZ.Click();
        }

        [Given("I am taken to account details page")]
        [When("I am taken to account details page")]
        [Then("I am taken to account details page")]
        public void ThenIAmTakenToAccountDetailsPage()
        {
            IWebElement accountNameBar = Test.WaitUntilElementIsVisible(BankAccountsPageObject.AccountNameBar);
            Assert.True(accountNameBar.Displayed);
        }

        [Given("I enter account name (.*)")]
        public void GivenIEnterAccountName(string accountName)
        {
            IWebElement bankDetailsContainer = Test.WaitUntilElementIsVisible(BankAccountsPageObject.BankDetailsContainer);
            IWebElement accountNameBar = bankDetailsContainer.FindElement(BankAccountsPageObject.AccountNameBar);
            accountNameBar.SendKeys(accountName);
        }

        [Given("I select account type (.*)")]
        public void GivenISelectAccountType(string accountType)
        {
            IWebElement bankDetailsContainer = Test.WaitUntilElementIsVisible(BankAccountsPageObject.BankDetailsContainer);

            IWebElement accountTypeBar = bankDetailsContainer.FindElement(BankAccountsPageObject.AccountTypeBar);
            accountTypeBar.Click();

            IWebElement desiredAccountType = Test.WaitUntilElementIsClickable(By.XPath($"//li[text()='{accountType}']"));
            desiredAccountType.Click();
        }

        [Given("I enter account number (.*)")]
        public void GivenIEnterAccountNumber(string accountNumber)
        {
            IWebElement bankDetailsContainer = Test.WaitUntilElementIsVisible(BankAccountsPageObject.BankDetailsContainer);

            IWebElement accountNumberBar = bankDetailsContainer.FindElement(BankAccountsPageObject.AccountNumberInput);
            accountNumberBar.Click();
            accountNumberBar.SendKeys(accountNumber);
            Assert.True(accountNumberBar.Displayed);
        }

        [Given("I click continue.")]
        public void GivenIClickContinue()
        {
            IWebElement continueButton = Test.WaitUntilElementIsClickable(BankAccountsPageObject.BankDetailsContinueButton);
            continueButton.Click();

            // wait for the next page
            Test.WaitUntilElementIsClickable(BankAccountsPageObject.IHaveGotAFormButton);
        }

        [Then("I am taken to download form page")]
        public void ThenIAMTakenToDownloadFormPage()
        {
            IWebElement iHaveAFormButton = Test.WaitUntilElementIsClickable(BankAccountsPageObject.IHaveGotAFormButton);
            Assert.True(iHaveAFormButton.Enabled);
        }

        [Then("Bank account (.*) should be visible")]
        public void ThenBankAccountShouldBePresent(string accountNumber)
        {
            IWebElement accountNumElement = Test.WaitUntilElementIsVisible(By.XPath($"//div[@class='document bank-accounts']//span[text()='{accountNumber}']"));
            Assert.True(accountNumElement.Displayed);
        }
    }
}
