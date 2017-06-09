class EventsController < ApplicationController
  before_action :restrict_to_signed_in, only: [:new, :create, :index]

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
        redirect_to events_path
    end
  end

  def index
    @events = Event.all
    @past_events = Event.where('date < DATE()')
    @upcoming_events = Event.where('date > DATE()')
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to events_path
  end

  private

    def event_params
        params.require(:event).permit(:title, :description, :date)
    end
end
