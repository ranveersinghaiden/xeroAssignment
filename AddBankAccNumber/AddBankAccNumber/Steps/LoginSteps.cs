using AddBankAccNumber.POM.Web;
using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using TechTalk.SpecFlow;
using Xunit;

namespace AddBankAccNumber.Steps
{
    [Binding]
    class LoginSteps : CommonSteps
    {
        private LoginPage LoginPageObject;
        private HomePage HomePageObject;

        public LoginSteps()
        {
            LoginPageObject = new LoginPage();
            HomePageObject = new HomePage();
        }

        [Given("I input username (.*)")]
        public void GivenIInputLoginUsername(string username)
        {
            Test.EnterText(LoginPageObject.UsernameInput, username);
        }

        [Given("I input password (.*)")]
        public void GivenIInputLoginPassword(string password)
        {
            Test.EnterText(LoginPageObject.PasswordInput, password);
        }

        [Given("I click Log In.")]
        public void GivenIClickLogin()
        {
            Test.Click(LoginPageObject.LoginButton);
        }

        [Given("I login using default user")]
        public void GivenILoginUsingDefaultUser()
        {
            GivenIInputLoginUsername("ranveersinghaiden@gmail.com");
            GivenIInputLoginPassword("Paass@123");
            GivenIClickLogin();
        }

        [Given("I am on home page")]
        [Then("I should be re-directed to home page.")]
        public void ThenIShouldBeRedirectedToHomePage()
        {
            IWebElement navBar = Test.WaitUntilElementIsVisible(HomePageObject.MainNavigationBar);
            Assert.True(navBar.Displayed);
        }

        [Given("I select security question for authentication.")]
        public void GivenISelectSecurityQuestionForAuthentication()
        {
            IWebElement authContinue = Test.WaitUntilElementIsClickable(LoginPageObject.AuthenticationContinueButton);
            authContinue.Click();

            IWebElement securityQuestionButton = Test.WaitUntilElementIsClickable(LoginPageObject.SecurityQuestionButton);
            securityQuestionButton.Click();

            Test.WaitUntilELementIsPresent(LoginPageObject.QuestionConfirmButton);
        }

        [Given("I answer security questions.")]
        public void GivenIAnswerSecurityQuestionDreamJob()
        {
            IWebElement questionInput;
            bool questionOneExists = Test.CheckIfElementIsVisible(LoginPageObject.DreamJobQuestionInputBox);
            bool questionTwoExists = Test.CheckIfElementIsVisible(LoginPageObject.FirstPetQuestionInputBox);
            bool questionThreeExists = Test.CheckIfElementIsVisible(LoginPageObject.DreamCarQuestionInputBox);

            if (questionOneExists)
            {
                questionInput = Test.WaitUntilElementIsClickable(LoginPageObject.FirstPetQuestionInputBox);
                questionInput.Click();
                questionInput.SendKeys("Copper");
            }
            if (questionTwoExists)
            {
                questionInput = Test.WaitUntilElementIsClickable(LoginPageObject.DreamJobQuestionInputBox);
                questionInput.Click();
                questionInput.SendKeys("Astronaut");
            }
            if (questionThreeExists)
            {
                questionInput = Test.WaitUntilElementIsClickable(LoginPageObject.DreamCarQuestionInputBox);
                questionInput.Click();
                questionInput.SendKeys("Mustang");
            }

            Test.WaitUntilElementIsClickable(LoginPageObject.QuestionConfirmButton).Click();
        }
    }
}
