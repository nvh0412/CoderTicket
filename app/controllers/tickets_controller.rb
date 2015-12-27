class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event, only: [:new, :create]
  respond_to :json, :js, :html

  def index
    @tickets = current_user.tickets
    respond_with @tickets
  end

  def new
    @ticket = current_user.tickets.build()
  end

  def create
    @ticket = current_user.tickets.build(ticket_params.merge(event_id: @event.id))
    if @ticket.save_ticket
      redirect_to events_path
    else
      render :new
    end
  end

  protected

  def ticket_params
    params.require(:ticket).permit(:quantity, :price, :ticket_type_id);
  end

  def get_event
    @event = Event.find(params[:event_id])
  end
end
