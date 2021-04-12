require 'ldclient-rb'

# Set sdk_key to your LaunchDarkly SDK key before running
sdk_key = ""

# Set feature_flag_key to the feature flag key you want to evaluate
feature_flag_key = "my-boolean-flag"

def show_message(s)
  puts "*** #{s}"
  puts
end

if sdk_key == ""
  show_message "Please edit main.rb to set sdk_key to your LaunchDarkly SDK key first"
  exit 1
end

client = LaunchDarkly::LDClient.new(sdk_key)

if client.initialized?
  show_message "SDK successfully initialized!"
else
  show_message "SDK failed to initialize"
  exit 1
end

# Set up the user properties. This user should appear on your LaunchDarkly users dashboard
# soon after you run the demo.
user = {
  key: "example-user-key",
  name: "Sandy"
}

flag_value = client.variation(feature_flag_key, user, false)

show_message "Feature flag '#{feature_flag_key}' is #{flag_value} for this user"

# Here we ensure that the SDK shuts down cleanly and has a chance to deliver analytics
# events to LaunchDarkly before the program exits. If analytics events are not delivered,
# the user properties and flag usage statistics will not appear on your dashboard. In a
# normal long-running application, the SDK would continue running and events would be
# delivered automatically in the background.
client.close()
