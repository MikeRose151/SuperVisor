class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def commands
    case params[:command]
    when "/triggerinspection"
      @inspections = Inspection.all
      @sheets = Sheet.all

      modal_payload = SlackModalBuilder.build(inspections: @inspections, sheets: @sheets)

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
    
    if payload["type"] == "view_submission"
      inspection_id = payload.dig("view", "state", "values", "inspection_block", "inspection_input", "selected_option", "value")
      inspection = Inspection.find_by(id: inspection_id)

      message = if inspection.blank_cells?
                  "There are blank cells in range #{inspection.range_to_check} of #{inspection.sheet.name}!"
                else
                  "There are no blank cells in #{inspection.range_to_check} of #{inspection.sheet.name}!"
                end
      
      PostSlackMessageJob.perform_later(
        channel_id: SlackChannelService.supervisor_inspections_channel_id(slack_client),
        message: message
      )

      head :ok
      # TODO: handle cases where supervisor_inspections_channel_id is not valid (i.e. if #supervisor-inspections doesn't exist)
    else
      head :ok
    end
  end

  private

  def slack_client
    @slack_client ||= Slack::Web::Client.new
  end
end
