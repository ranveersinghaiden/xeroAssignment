using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.POM.Web.Accounting
{
    class BankAccountsPage
    {
        public By BankDetailsContainer = By.CssSelector(".ba-pagesection");

        public By AddBankAccountButton = By.CssSelector("[data-automationid='Add Bank Account-button']");
        public By SearchBar = By.CssSelector("[data-automationid='bankSearch--input']");

        public By SearchResults = By.CssSelector("[data-automationid='searchResults']");
        public By SearchResultANZ = By.XPath("//span[text()='ANZ (NZ)']");

        public By AccountNameBar = By.XPath("//div[@data-automationid='accountName']//input"); 
        public By AccountTypeBar = By.XPath("//div[@data-automationid='accountType']//input");

        public By AccountTypeDropdownContainer = By.CssSelector(".x-boundlist-list-ct");

        public By AccountNumberInput = By.XPath("//div[contains(@id,'accountDetailGeneric')]//input[contains(@id, 'accountnumber')]");

        public By BankDetailsFooterContainer = By.CssSelector("footer.ba-page-footer");
        public By BankDetailsContinueButton = By.CssSelector("[data-automationid='continueButton']");

        public By IHaveGotAFormButton = By.CssSelector("[data-automationid='connectbank-buttonIHaveAForm']");
        public By DownloadFormButton = By.CssSelector("[data-automationid='connectbank-buttonDownloadForm']");
    }
}
