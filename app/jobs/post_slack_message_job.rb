class PostSlackMessageJob < ApplicationJob
  queue_as :default

  def perform(channel_id:, message:)
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: channel_id, text: message)
  end
end
