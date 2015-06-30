class MetaEvent < ActiveRecord::Base
  validates_presence_of :starts_at, :ends_at

  scope :non_repeating, -> { where repeat_until: nil, repeating_infinitely: false }
  scope :repeating, -> {
    t = MetaEvent.arel_table
    MetaEvent.where(t[:repeat_until].not_eq(nil).or(t[:repeating_infinitely].eq(true)))
  }

  def self.events_for_week week
    t = MetaEvent.arel_table
    non_repeating_meta_events_for_week = MetaEvent.non_repeating.where('starts_at >=? AND starts_at <= ?', week[0], week[1])
    repeating_meta_events_for_week = MetaEvent.repeating.where(
      t[:repeat_until].gteq(week[0]).or(t[:repeating_infinitely].eq(true))
    )
    events = non_repeating_meta_events_for_week.map { |me| me.events_for_week(week) }.flatten +
      repeating_meta_events_for_week.map { |me| me.events_for_week(week) }.flatten
    EventCollection.new events
  end

  def is_repeating?
    repeat_until.present? || repeating_infinitely?
  end

  def events_for_week week
    _e = Event.new self

    if !is_repeating? && starts_at >= week[0] && starts_at <= week[1]
      return [ _e ]
    elsif !is_repeating?
      return []
    end

    events = []

    repeating_date = starts_at
    i = -1
    while repeating_date < week[1]
      i += 1
      _e.starts_at = starts_at + (7 * i).days
      _e.ends_at   = ends_at   + (7 * i).days
      repeating_date = _e.starts_at + 7.days

      next if _e.starts_at < week[0]
      events << _e
      _e = _e.dup
    end

    events
  end

end
