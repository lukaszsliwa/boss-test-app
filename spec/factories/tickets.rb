FactoryBot.define do
  factory :ticket do
    request_number { rand(1000000000) }
    sequence(:sequence_number)
    request_type { 'Normal' }
    response_due_date_time { Time.zone.now }
    primary_service_area_code { %w(ZZL00 ZZL01 ZZL02 ZZL03 ZZL04 ZZL05 ZZL06 ZZL07 ZZL08 ZZL09).sample }
    additional_service_area_codes { %w(ZZL00 ZZL01 ZZL02 ZZL03 ZZL04 ZZL05 ZZL06 ZZL07 ZZL08 ZZL09).sample(4) }
    digsite_info_well_known_text { '' }
  end
end
