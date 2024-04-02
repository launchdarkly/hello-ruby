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

def show_flag_message(flag_key, flag_value)
  show_message "Feature flag '#{flag_key}' is #{flag_value} for this context"

  if flag_value
    show_message "                                                  \n" +
    "                                                  \n" +
    "                       @@                         \n" +
    "                         @@@                      \n" +
    "               @(          @@@.                   \n" +
    "                 #@@@@@     @@@@@                 \n" +
    "                      @@@@@@@ @@@@@.              \n" +
    "                          @@@@@@@@@@@@            \n" +
    "         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@.         \n" +
    "                 (@@@@@@@@@@@@@@@@@@@@@@          \n" +
    "                         @@@@@@@@@@@@*            \n" +
    "                     @@@@@@@  @@@@@               \n" +
    "                 @@@@/      @@@@*                 \n" +
    "                          @@@@                    \n" +
    "                        &@@*                      \n" +
    "                       @@                         \n" +
    "                                                  \n" +
    ""
  end
end

class FlagChangeListener
  def initialize(feature_flag_key)
    @feature_flag_key = feature_flag_key
  end

  def update(changed)
    if @feature_flag_key.eql?(changed.key)
      show_flag_message(@feature_flag_key, changed.new_value)
    end
  end
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

show_flag_message(feature_flag_key, flag_value)

client.flag_tracker.add_flag_value_change_listener(feature_flag_key, context, FlagChangeListener.new(feature_flag_key))

# Run the Hello App continously to react to flag change in LaunchDarkly
thr = Thread.new {
  sleep
}
thr.join