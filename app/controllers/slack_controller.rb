class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def trigger_inspection
    @inspections = Inspection.all
    @sheets = Sheet.all
    modal_payload = render_to_string(template: "slack/modals/inspect_form", formats: [ :json ]).html_safe

    modal_payload = SlackModalBuilder.build(inspections: @inspections, sheets: @sheets)

    slack_client = Slack::Web::Client.new

    slack_client.views_open(
      trigger_id: params[:trigger_id],
      view: modal_payload
    )

    head :ok
  end
end
