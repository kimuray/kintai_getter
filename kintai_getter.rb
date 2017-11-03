require 'slack'
require 'active_support/time'

class KintaiGetter
  attr_reader :client, :channel, :user, :start_date, :last_date

  # - channel_name - 取得対象のSlackチャンネル
  # - user_name - 取得したいユーザー名
  # - start_date - 取得したい日付範囲の開始日
  # - last_date - 取得したい日付範囲の終了日
  #
  # Example
  #   kintai_getter = KintaiGetter.new(
  #     channel_name: 'all-today_to_do',
  #     user_name: 'diver',
  #     start_date: Time.current.prev_month.beginning_of_month,
  #     last_date: Time.current.prev_month.end_of_month
  #   )
  def initialize(channel_name: nil,
                 user_name: nil,
                 start_date: Time.current.beginning_of_month,
                 last_date: Time.current.end_of_month)
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
    @client = Slack::Web::Client.new
    @channel = get_channel(channel_name)
    @user = get_user(user_name)
    @start_date = start_date.to_i
    @last_date = last_date.to_i
  end

  def execute
    messages = get_messages(user.id).reverse
    messages.each do |message|
      if message.text.match(/出勤|退勤/)
        puts "#{Time.at(message.ts.to_i).strftime("%m月%d日")} #{message.text.split("\n")[0]}"
      end
    end
  end

  private

  def get_channel(channel_name)
    list = client.conversations_list.channels
    list.find { |item| item.name == channel_name }
  end

  def get_user(user_name)
    list = client.users_list.members
    list.find { |item| item.name == user_name }
  end

  def get_messages(user_id)
    list = client.conversations_history(channel: channel.id, oldest: start_date, latest: last_date, limit: 1000).messages
    list.select { |item| item.user == user.id }
  end
end
