Feature: Story 4
  As an events promoter
  I want to supplement gift aid payments based on event type
  So that people will feel inspired to donate to these event types

  Scenario: Calculating gift aid based on event type
    Given I am on the homepage
      And I fill in a donation amount
      And I select a "swimming" event
    When I click "Calculate"
    Then I should see the correct gift aid amount for that event
