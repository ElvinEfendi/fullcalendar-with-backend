class EventsController < ApplicationController
  def index
  end

  def fetch
    events = MetaEvent.events_for_week [ Time.parse(params[:start]), Time.parse(params[:end]) ]
    render json: events
  end

  def create
    @meta_event = MetaEvent.new event_params
    @meta_event.save
  end

  private
  def event_params
    params.require(:meta_event).permit([ :notes, :starts_at, :ends_at, :repeat_until, :repeating_infinitely ])
  end
end
