class PostSlackMessageJob < ApplicationJob
  queue_as :default

  def perform(message:)
    slack_client = Slack::Web::Client.new
    channel_id = SlackChannelService.supervisor_inspections_channel_id(slack_client)
    slack_client.chat_postMessage(channel: channel_id, text: message)
  end

  # TODO: handle cases where supervisor_inspections_channel_id is not valid (i.e. if #supervisor-inspections doesn't exist)
end
