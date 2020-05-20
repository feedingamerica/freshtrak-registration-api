# Freshtrak Registration API
Public API that exposes select tables for the Freshtrak pre-registration process.

Built and deployed using the [Ruby on Jets](https://rubyonjets.com/) framework

## Prerequisites

1. [Ruby 2.5.3](https://www.ruby-lang.org/en/downloads/)
2. [Bundler](https://bundler.io/)
3. [MySQL 8.0.x](https://dev.mysql.com/doc/refman/8.0/en/installing.html)

## Setup

From the `freshtrak-registration-api` folder
```bash
bundle install # Install dependencies
```

## Local developmentUnit Tests
```bash
bundle exec rspec
```

Development server
```bash
bundle exec jets server
```

Console
```bash
bundle exec jets console
```

### Updating the schema file

From time to time, new tables or columns are added to the source database. The `db/schema.rb` file needs to be kept in sync when this happens. It's also nice to take a fresh dump of the db at that time to make local development easier.
```bash
DB_HOST=<rds_host> DB_USER=<user> DB_PASS=<password> DB_NAME=registration_api_development bundle exec jets db:schema:dump
```
```bash
rm ./setup/seed.sql.zip
mysqldump -h <rds_host> -u <user> -p<password> registration_api_development > setup/seed.sql
zip setup/seed.sql.zip setup/seed.sql
rm setup/seed.sql
```

### Setting up on Windows OS

WSL (Windows Subsystem for Linux) is required to run Jets framework and will need to be installed by enabling this Windows feature. An extension is available for 
Visual Studio code that allows the user to run VS code using remote WSL. 
 - Installing WSL - https://docs.microsoft.com/en-us/windows/wsl/install-win10
 - VS Code WSL Extension - https://github.com/Microsoft/vscode-remote-release
 - WSL FAQ - https://docs.microsoft.com/en-us/windows/wsl/faq

 Once WSL is running you can install the project's requirements as stated above (Ruby, Bundler) in the project folder using the Linux distro. MySQL can be installed aywhere.
 After setting up the project dependencies, including MySQL, the DB environment variables need to be set inside the ".bashrc" file in the WSL Linux distro, otherwise every time
 the WSL session is closed you will lose the environment variables. Once finished with the variables, restart the WSL session so the environment variables take affect. 

 There is a known issue where MySQL will attempt to use an SHA2 Password Plugin. If an error regarding this is a blocker a work around can be found at the following web address.
  - https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded

* Dependencies
* Configuration
* Database setup
* How to run the test suite
* Deployment instructions