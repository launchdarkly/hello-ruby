require 'ldclient-rb'

# Set sdk_key to your LaunchDarkly SDK key before running
sdk_key = ENV['LAUNCHDARKLY_SERVER_KEY']

# Set feature_flag_key to the feature flag key you want to evaluate
feature_flag_key = ENV['LAUNCHDARKLY_FLAG_KEY']

def show_message(msg)
  puts "*** #{msg}"
  puts
end

if sdk_key == ''
  show_message 'Please set the LAUNCHDARKLY_SERVER_KEY environment variable'
  exit 1
elsif feature_flag_key == ''
  show_message 'Please set the LAUNCHDARKLY_FLAG_KEY environment variable'
  exit 1
end

client = LaunchDarkly::LDClient.new(sdk_key)

if client.initialized?
  show_message 'SDK successfully initialized!'
else
  show_message 'SDK failed to initialize'
  exit 1
end

# Set up the context properties. This context should appear on your LaunchDarkly contexts dashboard
# soon after you run the demo.
context = LaunchDarkly::LDContext.create({
                                           key: 'example-user-key',
                                           kind: 'user',
                                           name: 'Sandy'
                                         })

flag_value = client.variation(feature_flag_key, context, false)

show_message "Feature flag '#{feature_flag_key}' is #{flag_value} for this context"

# Here we ensure that the SDK shuts down cleanly and has a chance to deliver analytics
# events to LaunchDarkly before the program exits. If analytics events are not delivered,
# the context properties and flag usage statistics will not appear on your dashboard. In a
# normal long-running application, the SDK would continue running and events would be
# delivered automatically in the background.
client.close
