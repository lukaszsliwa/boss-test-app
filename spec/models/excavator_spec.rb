require 'rails_helper'

RSpec.describe Excavator, type: :model do
  subject { build(:excavator) }

  it 'should create an excavator' do
    expect { subject.save }.to change { Excavator.count }
  end

  it 'should have the company name' do
    expect(subject.company_name).to be_present
  end

  it 'should have an address' do
    expect(subject.address).to be_present
  end

  it 'should have a crew_on_site' do
    expect(subject.crew_on_site).to eq(false)
  end
end
