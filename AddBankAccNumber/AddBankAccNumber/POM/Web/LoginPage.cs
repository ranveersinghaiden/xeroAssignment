using OpenQA.Selenium;
using System;
using System.Collections.Generic;
using System.Text;

namespace AddBankAccNumber.POM.Web
{
    class LoginPage
    {
        public By UsernameInput = By.CssSelector("[data-automationid='Username--input']");
        public By PasswordInput = By.CssSelector("[data-automationid='PassWord--input']");
        public By LoginButton = By.CssSelector("[data-automationid='LoginSubmit--button']");
        public By AuthenticationContinueButton = By.CssSelector("[data-automationid='auth-continuebutton']");
        public By SecurityQuestionButton = By.CssSelector("[data-automationid='auth-authwithsecurityquestionsbutton']");

        public By FirstQuestionLabel = By.CssSelector("[data-automationid='auth-firstanswer--label']");
        public By SecondQuestionLabel = By.CssSelector("[data-automationid='auth-secondanswer--label']");

        public By FirstAnswerInputBox = By.XPath("//div[@data-automationid='auth-firstanswer']/input");
        public By SecondAnswerInputBox = By.XPath("//div[@data-automationid='auth-secondanswer']/input");

        public By QuestionConfirmButton = By.CssSelector("[data-automationid='auth-submitanswersbutton']");
    }
}
