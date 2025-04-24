class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def commands
    slack_client = Slack::Web::Client.new

    slack_client.views_open(
      trigger_id: params[:trigger_id],
      view: {
        type: "modal",
        callback_id: "incident_submission",
        title: { type: "plain_text", text: "Manually trigger" },
        submit: { type: "plain_text", text: "Run inspection" },
        close: { type: "plain_text", text: "Cancel" },
        blocks: [
          {
            type: "input",
            block_id: "spreadsheet_block",
            optional: true,
            element: {
              type: "static_select",
              action_id: "spreadsheet_input",
              options: [
                {
                  text: { type: "plain_text", text: "sheet 1" },
                  value: "sev0"
                },
                {
                  text: { type: "plain_text", text: "sheet 2" },
                  value: "sev1"
                },
                {
                  text: { type: "plain_text", text: "sheet 3" },
                  value: "sev2"
                }
              ]
            },
            label: { type: "plain_text", text: "Select spreadsheet" }
          },
          {
            type: "input",
            block_id: "inspection_block",
            element: {
              type: "static_select",
              action_id: "inspection_input",
              options: [
                {
                  text: { type: "plain_text", text: "inspection 1" },
                  value: "sev0"
                },
                {
                  text: { type: "plain_text", text: "inspection 2" },
                  value: "sev1"
                },
                {
                  text: { type: "plain_text", text: "inspection 3" },
                  value: "sev2"
                }
              ]
            },
            label: { type: "plain_text", text: "Select inspection" }
          }
        ]
      }
    )
  end
end
