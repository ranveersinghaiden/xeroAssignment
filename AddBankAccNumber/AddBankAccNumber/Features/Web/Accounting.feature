@accounting
Feature: Accounting

Background: Initialize browser
	Given I initialize the browser
	And I navigate to login url.
	And I login using default user
	And I select security question for authentication.
	And I answer security questions.
	Then I should be re-directed to home page.

@bankAccount
Scenario: Add bank account number
	Given I am on home page
	And I navigate to Bank Accounts page
	And I click 'Add Bank Account' button.
	And I am taken to bank search page
	And I search for ANZ bank
	And I am taken to account details page
	And I enter account name Ranveer Singh Aiden 7
	And I select account type Everyday (day-to-day)
	And I enter account number 00-000000-000-07
	And I click continue.
	Then I am taken to download form page
	And I navigate to Bank Accounts page 
	Then Bank account 00-000000-000-07 should be visible