require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  render_views

  describe '#index' do
    let!(:ticket1) { create(:ticket) }
    let!(:ticket2) { create(:ticket) }
    let!(:ticket3) { create(:ticket) }

    it 'should render index template' do
      get :index, format: 'html'
      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    let!(:ticket) { create(:ticket) }

    it 'should render show template' do
      get :show, params: { id: ticket.id }, format: 'html'
      expect(response.status).to eq(200)
    end
  end
end
