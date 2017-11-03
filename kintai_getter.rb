require 'active_support/time'
require './slack_api'

class KintaiGetter
  attr_reader :client, :channel, :user, :start_date, :last_date

  # - channel_name - 取得対象のSlackチャンネル
  # - user_name - 取得したいユーザー名
  # - start_date - 取得したい日付範囲の開始日
  # - last_date - 取得したい日付範囲の終了日
  #
  # Example
  #   kintai_getter = KintaiGetter.new(
  #     channel_name: '',
  #     user_name: 'diver',
  #     start_date: Time.current.prev_month.beginning_of_month,
  #     last_date: Time.current.prev_month.end_of_month
  #   )
  def initialize(channel_name: nil,
                 user_name: nil,
                 start_date: Time.current.beginning_of_month,
                 last_date: Time.current.end_of_month)
    @client = SlackApi.new
    @channel = client.get_channel(channel_name)
    @user = client.get_user(user_name)
    @start_date = start_date.to_i
    @last_date = last_date.to_i
  end

  def execute
    messages = client.get_messages(channel.id, user.id, start_date: start_date, last_date: last_date).reverse
    messages.each do |message|
      if message.text.match(/出勤|退勤/)
        puts "#{Time.at(message.ts.to_i).strftime("%m月%d日")} #{message.text.split("\n")[0]}"
      end
    end
  end
end
