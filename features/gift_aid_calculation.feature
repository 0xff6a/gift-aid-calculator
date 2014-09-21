Feature: Stories 1 & 2
  As a donor
  I want to see my gift aid calculated according to the current tax rate
  So that I know how much extra cash the charity will make

  Scenario: Calculation
    Given I am on the homepage
      And I fill in a donation amount
    When I click "Calculate"
    Then I should see the correct gift aid amount

    Scenario: Rounding
    Given I have submitted a calculation
    Then I should see the gift aid amount rounded to 2 decimal places
