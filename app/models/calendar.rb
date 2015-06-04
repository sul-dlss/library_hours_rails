class Calendar < ActiveRecord::Base
  belongs_to :location
  has_one :library, through: :location

  scope :in_range, (lambda do |range|
    where('dtstart BETWEEN ? AND ?', range.begin.to_time.midnight, range.end.to_time.end_of_day)
  end)

  scope :for_date, (lambda do |t|
    where('dtstart BETWEEN ? AND ?', t.to_time.midnight, t.to_time.end_of_day)
  end)

  def self.valid_range?(range)
    case range
    when 'closed'
      true
    when 'open 24h'
      true
    when /-/
      parse_time_range(range).is_a? Range
    end
  rescue
    false
  end

  def self.parse_time_range(combo)
    range_begin, range_end = combo.split('-')
    range_begin += 'm' if range_begin =~ (/[ap]$/)
    range_end += 'm' if range_end =~ (/[ap]$/)
    Time.zone.parse(range_begin)..Time.zone.parse(range_end)
  end

  def update_hours(combo)
    case combo
    when 'closed'
      closed!
    when 'open 24h'
      open_24h!
    when /-/
      update_range(Calendar.parse_time_range(combo))
    end
  end

  def date
    dtstart.to_date
  end

  def closed!
    self.closed = true

    self.dtstart = dtstart.midnight
    self.dtend = dtstart
  end

  def open_24h!
    self.closed = false
    self.dtstart = dtstart.midnight
    self.dtend = dtstart.end_of_day
  end

  def update_range(range)
    self.closed = false
    self.dtstart = Time.zone.parse(dtstart.strftime('%F') + range.begin.strftime('T%T'))
    self.dtend = Time.zone.parse(dtstart.strftime('%F') + range.end.strftime('T%T'))

    if dtend < dtstart
      next_date = dtstart.to_date + 1.day
      # Parse the time again, just in case daylight saving happened.
      self.dtend = Time.zone.parse("#{next_date}" + range.end.strftime('T%T'))
    end
  end

  ##
  # The library website can't handle end times that are in the next day; when
  # we have that case, subtract a day from the end time to make it happen the same
  # day
  def dtend_drupal
    if dtstart.end_of_day < dtend
      dtend - 1.day
    else
      dtend
    end
  end

  def open?
    !closed?
  end

  def open_24h?
    dtstart == dtstart.midnight &&
      dtend >= dtstart.end_of_day - 1.second
  end

  def self.week(str)
    start = DateTime.strptime(str, '%GW%V').to_date - 1.day

    start..(start + 6.days)
  end

  def status_drupal
    case
    when closed?
      0
    when open_24h?
      2
    else
      1
    end
  end
end
