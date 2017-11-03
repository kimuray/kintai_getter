require 'slack'

class SlackApi
  attr_reader :client

  def initialize
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
    @client = Slack::Web::Client.new
  end

  def get_channel(channel_name)
    list = client.conversations_list.channels
    list.find { |item| item.name == channel_name }
  end

  def get_user(user_name)
    list = client.users_list.members
    list.find { |item| item.name == user_name }
  end

  def get_messages(channel_id,
                   user_id,
                   start_date: Time.current.beginning_of_month,
                   last_date: Time.current.end_of_month)
    list = client.conversations_history(channel: channel_id, oldest: start_date, latest: last_date, limit: 1000).messages
    list.select { |item| item.user == user_id }
  end
end
