class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def commands
    case params[:command]
    when "/triggerinspection"
      @inspections = Inspection.all
      @sheets = Sheet.all

      modal_payload = SlackModalBuilder.build(inspections: @inspections, sheets: @sheets)

      slack_client = Slack::Web::Client.new

      slack_client.views_open(
        trigger_id: params[:trigger_id],
        view: modal_payload
      )
      head :ok
    else
      head :ok
    end
  end

  def interactions
    payload = JSON.parse(params[:payload])
    inspection_id = payload["view"]["state"]["values"]["inspection_block"]["inspection_input"]["selected_option"]["value"]
    inspection = Inspection.find(inspection_id)

    message = inspection.blank_cells? ? "There are blank cells in range #{inspection.range_to_check} of #{inspection.sheet.name}!" : "There are no blank cells in #{inspection.range_to_check} of #{inspection.sheet.name}!"

    # TODO: render message in slack
  end
end
