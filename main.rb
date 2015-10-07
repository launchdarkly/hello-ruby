require 'ldclient-rb'

client = LaunchDarkly::LDClient.new("YOUR_API_KEY")

user = {
  key: "bob@example.com",
  firstName: "Bob",
  lastName: "Loblaw",
  custom: {
    groups: "beta_testers"
  }
}

if client.toggle?("YOU_FEATURE_FLAG_KEY", user, false)
  # application code to show the feature
  puts "Showing your feature to #{user[:key]}"
else
  # the code to run if the feature is off
  puts "Not showing your feature to #{user[:key]}"
end

client.flush()
