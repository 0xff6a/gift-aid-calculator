Technical Test: Gift Aid Calculator
===================================

[![Code Climate](https://codeclimate.com/github/foxjerem/gift-aid-calculator/badges/gpa.svg)](https://codeclimate.com/github/foxjerem/gift-aid-calculator) [![Test Coverage](https://codeclimate.com/github/foxjerem/gift-aid-calculator/badges/coverage.svg)](https://codeclimate.com/github/foxjerem/gift-aid-calculator)

Please run feature tests (instructions below) for detailed description of functionality

Ruby Version:
-------------
Ruby 2.1.2

Objectives:
-----------
- Create a simple gift aid calculator
- Gift Aid calculated as donation_amount * ( tax_rate / (100 - tax_rate ) )
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
- Worked in pure TDD style throughout and ensured thorough test coverage
- Started with a single class to complete the first user story and added additional classes as complexity grew to maintain single responsibility
- Created user and admin class to update tax rate for extensibility and to ensure code remained semantically rich (vs a simple admin/user input to GiftAidCalculator functions)
- Command line interface to demonstrate functionality would have been clunky and inflexible so created simple sinatra web app instead
- Created cucumber feature tests based on stories provided

Running the test suite:
-----------------------
From root directory:

***Feature Tests***
```shell
$ bundle
$ cucumber
```

***Unit Tests***
```shell
$ bundle
$ rspec
```

Running the application:
------------------------
From root directory opens the application on http://localhost:9292/. Authentication string to change tax rate is 'JGHackers'.

```shell
$ bundle
$ rackup 
```

