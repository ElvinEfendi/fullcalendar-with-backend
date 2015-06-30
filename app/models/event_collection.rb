class EventCollection
  include Enumerable

  def initialize events
    @events = events.sort_by &:starts_at
  end

  def for_week week
    events = @events.select do |e|
      e.starts_at >= week[0] && e.starts_at <= week[1]
    end
    EventCollection.new events
  end

  def each &block
    @events.each do |event|
      block.call event
    end
  end
end
