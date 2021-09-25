class TicketsController < ApplicationController
  def index
    @tickets = Ticket.page(params[:page])
  end

  def show
    @ticket = Ticket.find params[:id]
  end
end
