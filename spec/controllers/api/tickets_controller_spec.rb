require 'rails_helper'

RSpec.describe Api::TicketsController, type: :controller do
  render_views

  describe '#create' do
    let(:params) do
      {
        'RequestNumber' => '123-456-789-123-456-789',
        'SequenceNumber' => '123-456-789',
        'RequestType' => 'Normal',
        'DateTimes' => {
          'ResponseDueDateTime' => Time.zone.now.iso8601
        },
        'ServiceArea' => {
          'PrimaryServiceAreaCode' => { 'SACode' => 'ZZL01' },
          'AdditionalServiceAreaCodes' => { 'SACode' => %w(ZZL01 ZZL02 ZZL03 ZZL04) }
        },
        'DigsiteInfo' => {
          'WellKnownText' => 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))'
        },
        'Excavator' => {
          'CompanyName' => 'Test Company LTD',
          'Address' => 'Test Street 1A/B, City, Postal code',
          'CrewOnSite' => 'true'
        }
      }
    end

    let(:json) { JSON.parse(response.body) }

    context 'on success' do
      let(:data) { json['data'] }
      let(:attributes) { data['attributes'] }

      it 'should create a ticket base on the request data' do
        expect do
          post :create, params: params, format: 'json'
        end.to change { Ticket.count }

        expect(data['id']).to be_present
        expect(attributes['request_number']).to match('123-456-789-123-456-789')
        expect(attributes['sequence_number']).to match('123-456-789')
        expect(attributes['request_type']).to eq('Normal')
        expect(attributes['response_due_date_time']).to be_present
        expect(attributes['primary_service_area_code']).to eq('ZZL01')
        expect(attributes['additional_service_area_codes']).to eq(%w(ZZL01 ZZL02 ZZL03 ZZL04))
        expect(attributes['digsite_info_well_known_text']).to be_present
      end
    end
  end
end
