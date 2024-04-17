require 'ldclient-rb'

# Set sdk_key to your LaunchDarkly SDK key before running
sdk_key = ENV['LAUNCHDARKLY_SERVER_KEY']

# Set feature_flag_key to the feature flag key you want to evaluate
feature_flag_key = ENV['LAUNCHDARKLY_FLAG_KEY']

ci = ENV['CI']

if sdk_key == ''
  puts "*** Please set the LAUNCHDARKLY_SERVER_KEY environment variable\n"
  exit 1
elsif feature_flag_key == ''
  puts "*** Please set the LAUNCHDARKLY_FLAG_KEY environment variable\n"
  exit 1
end

def show_flag_message(flag_key, flag_value)
  puts "*** Feature flag '#{flag_key}' is #{flag_value} for this context\n"

  if flag_value
    puts
    puts "        ██       "
    puts "          ██     "
    puts "      ████████   "
    puts "         ███████ "
    puts "██ LAUNCHDARKLY █"
    puts "         ███████ "
    puts "      ████████   "
    puts "          ██     "
    puts "        ██       "
    puts
  end
end

class FlagChangeListener
  def update(changed)
    show_flag_message(changed.key, changed.new_value)
  end
end

client = LaunchDarkly::LDClient.new(sdk_key)

if client.initialized?
  puts "*** SDK successfully initialized!\n"
else
  puts "*** SDK failed to initialize\n"
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

show_flag_message(feature_flag_key, flag_value)

if ci
  exit 0
end

client.flag_tracker.add_flag_value_change_listener(feature_flag_key, context, FlagChangeListener.new)

# Run the Hello App continously to react to flag change in LaunchDarkly
thr = Thread.new {
  puts "*** Press Ctrl+C to terminate the hello app."
  sleep
}
thr.join