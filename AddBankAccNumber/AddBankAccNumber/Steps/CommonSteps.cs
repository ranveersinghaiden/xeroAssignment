using AddBankAccNumber.Helpers;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;
using TechTalk.SpecFlow;

namespace AddBankAccNumber.Steps
{
    class CommonSteps
    {
        public static SeleniumHelper Test;

        public CommonSteps()
        {
            Test = new SeleniumHelper();
        }
    }
}
