# LaunchDarkly Sample Ruby Application

We've built a simple console application that demonstrates how LaunchDarkly's SDK works.

This sample is configured to use the [FDv2 protocol](https://launchdarkly.com/docs/sdk/features/data-saving-mode) and connects to a [Relay Proxy](https://launchdarkly.com/docs/home/relay-proxy) at `https://localhost:8030`. Override the URI by setting `LAUNCHDARKLY_RELAY_URI`.

Below, you'll find the basic build procedure. For more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/) or the [Ruby reference guide](https://docs.launchdarkly.com/sdk/server-side/ruby).

This demo requires Ruby version 3.0.0 or higher (or, for JRuby, 9.4.0 or higher), the LaunchDarkly Ruby SDK 8.12.3 (pinned in the `Gemfile`), and Relay Proxy 9.0.0-rc.1 or higher.

## Build instructions

1. Make sure your Relay Proxy is running and reachable at `https://localhost:8030` (or set `LAUNCHDARKLY_RELAY_URI` to point elsewhere).
1. Set the environment variable `LAUNCHDARKLY_SDK_KEY` to your LaunchDarkly SDK key. If there is an existing boolean feature flag in your LaunchDarkly project that you want to evaluate, set `LAUNCHDARKLY_FLAG_KEY` to the flag key; otherwise, a boolean flag of `sample-feature` will be assumed.
    ```bash
    export LAUNCHDARKLY_SDK_KEY="1234567890abcdef"
    export LAUNCHDARKLY_FLAG_KEY="my-boolean-flag"
    export LAUNCHDARKLY_RELAY_URI="https://localhost:8030"
    ```
1. If you have not installed the `bundler` tool, run `gem install bundler` on the command line.
1. On the command line, run `bundle install`
1. Run `bundle exec ruby main.rb`

You should receive the message "The <flagKey> feature flag evaluates to <flagValue>.". The application will run continuously and react to the flag changes in LaunchDarkly.
