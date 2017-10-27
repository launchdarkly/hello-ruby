require 'ldclient-rb'

log = ::Logger.new($stdout)
log.level = ::Logger::DEBUG
config = LaunchDarkly::Config.new({:logger => log})
# TODO : Enter your LaunchDarkly SDK key here
client = LaunchDarkly::LDClient.new("YOUR_SDK_KEY", config)

user = {
  key: "bob@example.com",
  firstName: "Bob",
  lastName: "Loblaw",
  custom: {
    groups: "beta_testers"
  }
}

# TODO : Enter the key for your feature flag here
if client.variation("YOUR_FEATURE_FLAG_KEY", user, false)
  # application code to show the feature
  puts "Showing your feature to #{user[:key]}"
else
  # the code to run if the feature is off
  puts "Not showing your feature to #{user[:key]}"
end

client.flush()
