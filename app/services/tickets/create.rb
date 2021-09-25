module Tickets
  class Create
    attr_reader :result

    def initialize(params:)
      @params = params
    end

    def self.call(params:)
      new(params: params).tap(&:perform)
    end

    def perform
      @result = Ticket.create params_ticket
    end

    def success?
      @result.present? && @result.errors.empty?
    end

    private

    def params_ticket
      {
        request_number: @params.dig('RequestNumber'),
        sequence_number: @params.dig('SequenceNumber'),
        request_type: @params.dig('RequestType'),
        response_due_date_time: @params.dig('DateTimes', 'ResponseDueDateTime'),
        primary_service_area_code: @params.dig('ServiceArea', 'PrimaryServiceAreaCode', 'SACode'),
        additional_service_area_codes: @params.dig('ServiceArea', 'AdditionalServiceAreaCodes', 'SACode'),
        digsite_info_well_known_text: @params.dig('DigsiteInfo', 'WellKnownText'),
        excavator_attributes: {
          company_name: @params.dig('Excavator', 'CompanyName'),
          address: @params.dig('Excavator', 'Address'),
          crew_on_site: @params.dig('Excavator', 'CrewOnSite')
        }
      }
    end
  end
end
