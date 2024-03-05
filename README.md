# LaunchDarkly Sample Ruby Application 

[![Build and run](https://github.com/launchdarkly/hello-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/launchdarkly/hello-ruby/actions/workflows/ci.yml)

We've built a simple console application that demonstrates how LaunchDarkly's SDK works.

Below, you'll find the basic build procedure, but for more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/) or the [Ruby SDK reference guide](https://docs.launchdarkly.com/sdk/server-side/ruby).

This demo requires Ruby version 3.0.0 or higher (or, for JRuby, 9.4.0 or higher).

## Build instructions 

1. On the command line, set the value of the environment variable `LAUNCHDARKLY_SERVER_KEY` to your LaunchDarkly SDK key.
    ```bash
    export LAUNCHDARKLY_SERVER_KEY="1234567890abcdef"
    ```
1. On the command line, set the value of the environment variable `LAUNCHDARKLY_FLAG_KEY` to an existing boolean feature flag in your LaunchDarkly project that you want to evaluate.

    ```bash
    export LAUNCHDARKLY_FLAG_KEY="my-boolean-flag"
    ```
1. If you have not installed the `bundler` tool, run `gem install bundler` on the command line.
1. On the command line, run `bundle install`
1. Run `bundle exec ruby main.rb`

You should see the message `"Feature flag '<flag key>' is <true/false> for this user"`.
