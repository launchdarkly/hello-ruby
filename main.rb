require 'ldclient-rb'

# Set sdk_key to your LaunchDarkly SDK key before running
sdk_key = ""

# Set feature_flag_key to the feature flag key you want to evaluate
feature_flag_key = "my-boolean-flag"


if sdk_key == ""
  puts "Please edit main.rb to set sdk_key to your LaunchDarkly SDK key first"
  exit 1
end


# The only custom configuration we are doing here is to reduce the amount of logging.
log = ::Logger.new($stdout)
log.level = ::Logger::WARN
config = LaunchDarkly::Config.new({:logger => log})

client = LaunchDarkly::LDClient.new(sdk_key, config)

# Set up the user properties. This user should appear on your LaunchDarkly users dashboard
# soon after you run the demo.
user = {
  key: "bob@example.com",
  firstName: "Bob",
  lastName: "Loblaw",
  custom: {
    groups: "beta_testers"
  }
}

show_feature = client.variation(feature_flag_key, user, false)

puts "Feature flag '#{feature_flag_key}' is #{show_feature} for this user"

# Calling client.close() ensures that the SDK shuts down cleanly before the program exits.
# Unless you do this, the SDK may not have a chance to deliver analytics events to LaunchDarkly,
# so the user properties and the flag usage statistics may not appear on your dashboard. In a
# normal long-running application, events would be delivered automatically in the background
# and you would not need to close the client.
client.close()
