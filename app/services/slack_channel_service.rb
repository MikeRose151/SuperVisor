class SlackChannelService
  def self.all_channels(slack_client)
    channels = []
    cursor = nil

    loop do
      response = slack_client.conversations_list(limit: 100, cursor: cursor)
      channels.concat(response.channels)
      cursor = response.response_metadata&.next_cursor
      break if cursor.blank?
    end

    channels
  end

  def self.find_channel_by_name(name:, slack_client:)
    all_channels(slack_client).find { |c| c.name == name }
  end

  def self.supervisor_inspections_channel_id(slack_client)
    find_channel_by_name(name: "supervisor-inspections", slack_client: slack_client)&.id
  end
end
