class SlackModalBuilder
  def self.build(inspections:, sheets:)
    {
      type: "modal",
      callback_id: "incident_submission",
      title: { type: "plain_text", text: "Manually trigger" },
      submit: { type: "plain_text", text: "Run inspection" },
      close: { type: "plain_text", text: "Cancel" },
      blocks: [
        # TODO: Implement a way to filter the inspections an optional sheet selection (though not sure how dynamic slack forms can be)
        # {
        #   type: "input",
        #   block_id: "sheet_block",
        #   element: {
        #     type: "static_select",
        #     action_id: "sheet_input",
        #     options: sheets.sort_by { |sheet| sheet.name.downcase }.map do |sheet|
        #       {
        #         text: { type: "plain_text", text: sheet.name },
        #         value: sheet.id.to_s
        #       }
        #     end
        #   },
        #   label: { type: "plain_text", text: "Select sheet" }
        # },
        {
          type: "input",
          block_id: "inspection_block",
          element: {
            type: "static_select",
            action_id: "inspection_input",
            options: inspections.sort_by(&:title).map do |inspection|
              {
                text: { type: "plain_text", text: inspection.title },
                value: inspection.id.to_s
              }
            end
          },
          label: { type: "plain_text", text: "Select inspection" }
        }
      ]
    }
  end
end
