class Api::TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @context = Tickets::Create.call(params: params_ticket)
    @ticket = @context.result
  end

  private

  def params_ticket
    params.permit(
      :RequestNumber,
      :SequenceNumber,
      :RequestType,
      DateTimes: [:ResponseDueDateTime],
      ServiceArea: [
        PrimaryServiceAreaCode: [:SACode],
        AdditionalServiceAreaCodes: [SACode: []]
      ],
      DigsiteInfo: [:WellKnownText],
      Excavator: [:CompanyName, :Address, :CrewOnSite]
    )
  end
end
