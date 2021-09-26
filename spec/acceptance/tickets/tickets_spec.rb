require 'rails_helper'

describe "the signin process", type: :feature do
  context '/tickets' do
    let!(:ticket1) { create(:ticket) }
    let!(:ticket2) { create(:ticket) }
    let!(:ticket3) { create(:ticket) }
    let!(:ticket4) { create(:ticket) }

    it 'should list all tickets' do
      visit tickets_path
      within(".table") do
        expect(page).to have_selector('tr', count: 4)
      end
    end
  end

  context '/tickets/:ticket_id' do
    let!(:ticket) { create(:ticket) }

    it 'should be able to show a ticket' do
      visit tickets_path
      within('.table') do
        expect(page).to have_selector('tr', count: 1)
        click_link ticket.request_number
      end
      expect(page).to have_text(ticket.request_number)
    end
  end
end
