class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new , :create, :destroy, :update]
  respond_to :html, :json, :js

  def index
    @events = Event.up_comming()
    @events = @events.search_event(params[:search]) if params[:search].present?
    respond_with @events
  end

  def event_of_user
    @events = current_user.events
    render :index
  end

  def show
    @event = Event.find_recent_event(params[:id]).first
    respond_with @event
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to edit_event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
  end

  protected
  def event_params
    params.require(:event).permit(:name, :starts_at, :ends_at, :hero_image_url, :published,
                                  :extended_html_description, :venue_id, :category_id,
                                  ticket_types_attributes: [:name, :price, :max_quantity])
  end
end
