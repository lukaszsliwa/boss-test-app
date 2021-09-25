require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { build(:ticket) }

  it 'should create a ticket' do
    expect { subject.save }.to change { Ticket.count }
  end

  it 'should have a request_number' do
    expect(subject.request_number).to be_present
  end

  it 'should have a sequence_number' do
    expect(subject.sequence_number).to be_present
  end

  it 'should have a request_type' do
    expect(subject.request_type).to be_present
  end

  it 'should have a response_due_date_time' do
    expect(subject.response_due_date_time).to be_present
  end

  it 'should have a primary_service_area_code' do
    expect(subject.primary_service_area_code).to be_present
  end

  it 'should have a additional_service_area_codes' do
    expect(subject.additional_service_area_codes.size).to eq(4)
  end

  it 'should have a digsite_info_well_known_text' do
    expect(subject.digsite_info_well_known_text).to be_blank
  end
end
