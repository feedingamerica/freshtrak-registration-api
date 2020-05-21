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

## Local development

Unit Tests
```bash
bundle exec rspec
```

Development server
```bash
bundle exec jets server --port 4444
```

Console
```bash
bundle exec jets console
```

## Deployment

This project is deployed using the [jets cli](https://rubyonjets.com/docs/deploy/).
Under the hood it creates nested [CloudFormation stacks](https://rubyonjets.com/docs/debugging/cloudformation/).
The relevant configuration files are at `config/application.rb` and `config/environments/*`.
Environment variables are set using the `.env.*` files.

```
AWS_PROFILE=<profile> AWS_REGION=us-east-2 JETS_ENV=<env> bundle exec jets db:migrate
AWS_PROFILE=<profile> AWS_REGION=us-east-2 JETS_ENV=<env> bundle exec jets deploy
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
