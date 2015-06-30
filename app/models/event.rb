class Event
  attr_reader :meta_event

  def initialize meta_event
    @meta_event = meta_event
  end

  def starts_at
    meta_event.starts_at
  end

  def ends_at
    meta_event.ends_at
  end

  def as_json(options={})
    {
      id: meta_event.id,
      title: '',
      start: starts_at,
      end: ends_at
    }
  end

end
