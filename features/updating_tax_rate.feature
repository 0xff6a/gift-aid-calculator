Feature: Story 2
  As a site administrator
  I want to be able to change the applicable tax rate
  So that I don't need to change the code when the tax rate changes

  Scenario: Modifying the tax rate
    Given I am on the homepage
    When I click "Update Tax Rate"
      And fill in a new tax rate
      And I fill in a correct authentication string
      And I click "Update"
    Then I should see the new tax rate displayed

  Scenario: Attempting to modify the tax rate with invalid credentials
    Given I am trying to update the tax rate
      And I have filled in an invalid authentication string
    When I click "Update"
    Then I should see an error message
