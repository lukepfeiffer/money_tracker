# MoneyTracker

A light weight budgeting service.

The MoneyTracker is built for college students who may or may not have a consistent income due to only working on irregular periods. Budget smarter.

## Development Setup

1. Clone the project down.
2. Run `bundle install`
3. Run `rake db:setup`
4. Create a `.env` file.
5. The following lines:
6. EMAIL_USERNAME="foo@bar.com"
7. EMAIL_PASSWORD="email_password_for_foo_bar"
8. EMAIL_DOMAIN="domain_of_email"
9. EMAIL_ADDRESS="smtp.someaddress.com"
10. ADMIN_EMAIL="admin@example.com"

1. Will also need to install `mailcatcher`, to do so run `gem install mailcatcher`

## Running tests

1. Run `rake`
2. All tests will pass. To run cucumber (integration tests) run `cucumber .`. To run respec (unit tests) run `rspec .`
