require 'rails_helper'

RSpec.describe Tickets::Create, type: :service do
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

  subject { described_class.new(params: params) }

  describe '#success?' do
    context 'on success' do
      before { subject.perform }

      it 'should return true' do
        expect(subject.success?).to eq(true)
      end
    end

    context 'on error' do
      it 'should return false' do
        expect(subject.success?).to eq(false)
      end
    end
  end

  describe '.call' do
    it 'should be able to call' do
      expect(described_class.call(params: params)).to be_kind_of(described_class)
    end
  end

  describe '#perform' do
    it 'should create a ticket' do
      expect { subject.perform }.to change { Ticket.count }

      expect(subject.result).to be_kind_of(Ticket)

      expect(subject.result.request_number).to eq('123-456-789-123-456-789')
      expect(subject.result.sequence_number).to eq('123-456-789')
      expect(subject.result.request_type).to eq('Normal')
      expect(subject.result.response_due_date_time).to be_present
      expect(subject.result.primary_service_area_code).to eq('ZZL01')
      expect(subject.result.additional_service_area_codes).to eq(%w(ZZL01 ZZL02 ZZL03 ZZL04))
      expect(subject.result.digsite_info_well_known_text).to eq('POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))')
      expect(subject.result.excavator.company_name).to eq('Test Company LTD')
      expect(subject.result.excavator.address).to eq('Test Street 1A/B, City, Postal code')
      expect(subject.result.excavator.crew_on_site).to eq(true)
    end
  end
end
