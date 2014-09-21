Technical Test: Gift Aid Calculator
===================================

[![Code Climate](https://codeclimate.com/github/foxjerem/gift-aid-calculator/badges/gpa.svg)](https://codeclimate.com/github/foxjerem/gift-aid-calculator) [![Test Coverage](https://codeclimate.com/github/foxjerem/gift-aid-calculator/badges/coverage.svg)](https://codeclimate.com/github/foxjerem/gift-aid-calculator)

Ruby Version:
-------------
Ruby 2.1.2

Objectives:
-----------
- Create a simple gift aid calculator to be calculated as donation_amount * ( tax_rate / (100 - tax_rate ) )
- Allow an admin user to update the tax rate
- Ensure rounding to two decimal places
- Allow gift aid to be supplemented based on event type

Classes:
--------
- GiftAidCalculator: calculates gift aid from inputs
- User: cannot alter the tax rate
- Admin: can alter the tax rate
- Event: can supplement gift aid based on type

Workings:
---------
WIP

Running the test suite:
-----------------------
$ bundle
$ rspec from root

Running the application:
------------------------
WIP
