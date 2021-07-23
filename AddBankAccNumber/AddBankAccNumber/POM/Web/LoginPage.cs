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

        public By FirstPetQuestionInputBox = By.XPath("//form//label[text()='What was the name of your first pet?']/following-sibling::div/input");
        public By DreamJobQuestionInputBox = By.XPath("//form//label[text()='What is your dream job?']/following-sibling::div/input");
        public By DreamCarQuestionInputBox = By.XPath("//form//label[text()='What is your dream car?']/following-sibling::div/input");
        
        public By QuestionConfirmButton = By.CssSelector("[data-automationid='auth-submitanswersbutton']");
    }
}
