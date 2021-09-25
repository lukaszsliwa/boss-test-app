FactoryBot.define do
  factory :excavator do
    ticket
    company_name { FFaker::Company.name }
    address { FFaker::Address.street_address }
    crew_on_site { false }
  end
end
