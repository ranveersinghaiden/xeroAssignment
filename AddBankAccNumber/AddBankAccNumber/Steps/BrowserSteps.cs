using AddBankAccNumber.Helpers;
using System;
using System.Collections.Generic;
using System.Text;
using TechTalk.SpecFlow;

namespace AddBankAccNumber.Steps
{
    [Binding]
    class BrowserSteps : CommonSteps
    {
        [Given("I initialize the browser")]
        public void GivenIInitializeBrowser()
        {
            Test.OpenBrowser();
        }

        //[Given("I initialize the browser (.*)")]
        //public void GivenIInitializeBrowser(string browserName)
        //{
        //    Test.OpenBrowser(browserName);
        //}


        [Given("I navigate to login url.")]
        public void GivenINavigateToLoginUrl()
        {
            Test.NavigateToUrl();
        }

        //[Given("I navigate to url (.*)")]
        //public void GivenINavigateToUrl(string testUrl)
        //{
        //    Test.NavigateToUrl(testUrl);
        //}
    }
}
