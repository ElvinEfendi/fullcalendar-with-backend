class EventsController < ApplicationController
  def index
  end

  def create
    @meta_event = MetaEvent.new meta_event_params
    @meta_event.save
  end

  private
  def meta_event_params
    params.require(:meta_event).permit([ :notes, :starts_at, :ends_at, :repeat_until, :repeating_infinitely ])
  end
end
