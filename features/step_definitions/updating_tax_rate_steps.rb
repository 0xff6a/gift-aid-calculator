When(/^fill in a new tax rate$/) do
  fill_in '20.0%', with: 41
end

When(/^I fill in a correct authentication string$/) do
  fill_in 'Authentication string', with: 'JGHackers'
end

Then(/^I should see the new tax rate displayed$/) do
  expect(page).to have_content('41.0%')
end

Given(/^I am trying to update the tax rate$/) do
  visit '/'
  click_link 'Update Tax Rate'
  fill_in '41.0%', with: 19
end

Given(/^I have filled in an invalid authentication string$/) do
  fill_in 'Authentication string', with: 'wrong'
end

Then(/^I should see an error message$/) do
  expect(page).to have_content('ERROR: Invalid Authorisation String')
end
