json.data do
  json.type 'Ticket'
  json.id @ticket.id.to_s
  json.attributes do
    json.extract! @ticket,
                  :request_number,
                  :sequence_number,
                  :request_type,
                  :response_due_date_time,
                  :primary_service_area_code,
                  :additional_service_area_codes,
                  :digsite_info_well_known_text
    if @ticket.excavator.present?
      json.excavator do
        json.extract! @ticket.excavator, :company_name, :address, :crew_on_site
      end
    end
  end
  json.meta do
    json.created_at @ticket.created_at.iso8601
    json.updated_at @ticket.updated_at.iso8601
  end
end
