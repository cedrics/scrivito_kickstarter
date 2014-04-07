# Scrival Kickstarter

[![Gem Version](https://badge.fury.io/rb/scrival_kickstarter.png)](http://badge.fury.io/rb/scrival_kickstarter)
[![Code Climate](https://codeclimate.com/github/infopark/scrival_kickstarter.png)](https://codeclimate.com/github/infopark/scrival_kickstarter)
[![Dependency Status](https://gemnasium.com/infopark/scrival_kickstarter.png)](https://gemnasium.com/infopark/scrival_kickstarter)
[![Build Status](https://travis-ci.org/infopark/scrival_kickstarter.png)](https://travis-ci.org/infopark/scrival_kickstarter)

Scrival Kickstarter provides generators and rake tasks to quickly setup or enhance an
[Scrival](http://scrival.com) Ruby on Rails project. All generated code
represents a working example, but can be fully customized within the application.


## Installation and Usage

Please visit our Documentation to get the
[latest installation and usage information](https://dev.infopark.net/kickstarter).


## Testing

There are two types of tests. First there are rspec tests of the Kickstarter
engine. You can run these tests by simply calling:

    $ rake spec

There are also integration tests, that can be run by:

    $ rake test:integration

In order to run the tests successfully, you need to download the application configuration from the
[Scrival Dashboard](https://scrival.com) and unpack it into the ```config``` folder. See the
contributing section below for more information.

The integration tests are rather slow, because they create an entire new application, execute
```rails generate cms:kickstart``` and run all the other generators and then execute the tests of
the newly created application. Therefore, all tests can also run on the Continuous Integration
platform [Travis](https://travis-ci.org).


### Continuous Integration with Travis

As the Kickstarter is a public repository, it is easily possible for you to run *Continuous
Integration* tests of your fork with [Travis](https://travis-ci.org) as you develop new features. In
order to run all Kickstarter Tests on the platform you should:

1. See the **Contributing** section and set up your local fork of the Kickstarter. Make
   sure that all tests are passing on your local machine.

2. Go into your local Kickstarter directory and run `rake travis_encrypt` to get a list of
   secure travis credentials and add them to the `.travis.yml` file. Please check these changes in
   with your next pull request.

3. Sign in at [Travis](https://travis-ci.org) with your Github Account.

4. Enable the Travis Webhook for your `scrival_kickstarter` fork.

If you now push commits to your forked repository or send a pull request, travis will automatically
run all tests for you and indicate the build status.


## Changelog

See [Changelog](https://github.com/infopark/scrival_kickstarter/blob/master/CHANGELOG.md) for more
details.


## Contributing

We would be very happy and thankful if you open new issues in order to further improve Scrival
Kickstarter. If you want to go a step further and extend the functionality or fix a problem, you can
do so any time by following the steps below.

1. Signup for a [free Scrival account](http://www.scrival.com/) and setup a test CMS
   component in the Scrival Dashboard.

2. Fork and clone the
   [Scrival Kickstarter GitHub repository](https://github.com/infopark/scrival_kickstarter).

        git clone git@github.com:_username_/scrival_kickstarter.git
        cd scrival_kickstarter

3. We suggest using [rbenv](https://github.com/sstephenson/rbenv/) for managing your local Ruby
   version. Make sure to use at least Ruby version 2.0.

        ruby --version

3. Copy the tenant name and api key for your Ruby on Rails application from the Scrival Dashboard
   and insert them to your cloned Kickstarter gem `config` folder.

        config/scrival.yml

4. Create the bundle and run all test to make sure everything is working before you add your own
   changes. You find some more details about testing above in the __Testing__ section.

        bundle
        rake spec
        rake test:integration

5. Create your feature branch and create a pull request for the `develop` branch. Please take a
   look at the already existing generators and rake tasks to get an impression of our coding style
   and the general architecture.

6. We are using the [GitHub Styleguides](https://github.com/styleguide) and would prefer if you
   could stick to it.


## License
Copyright (c) 2009 - 2014 Infopark AG (http://www.infopark.com)

This software can be used and modified under the LGPLv3. Please refer to
http://www.gnu.org/licenses/lgpl-3.0.html for the license text.
