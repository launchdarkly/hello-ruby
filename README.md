# LaunchDarkly Sample Ruby Application 

We've built a simple console application that demonstrates how LaunchDarkly's SDK works.

 Below, you'll find the basic build procedure, but for more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/) or the [Ruby SDK reference guide](https://docs.launchdarkly.com/sdk/server-side/ruby).

This demo requires Ruby version 2.5.0 or higher (or, for JRuby, 9.2.0 or higher).

## Build instructions 

1. Edit `main.rb` and set the value of `sdk_key` to your LaunchDarkly SDK key. If there is an existing boolean feature flag in your LaunchDarkly project that you want to evaluate, set `feature_flag_key` to the flag key.

```ruby
sdk_key = "1234567890abcdef"

feature_flag_key = "my-flag"
```

2. If you have not installed the `bundler` tool, run `gem install bundler` on the command line.

3. On the command line, run `bundle install`

4. Run `bundle exec ruby main.rb`

You should see the message `"Feature flag '<flag key>' is <true/false> for this user"`.
