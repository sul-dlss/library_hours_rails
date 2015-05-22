class Calendar < ActiveRecord::Base
  belongs_to :location
  has_one :library, through: :location

  scope :in_range, (lambda do |range|
    where('dtstart BETWEEN ? AND ?', range.begin.to_time.midnight, range.end.to_time.end_of_day)
  end)

  scope :for_date, (lambda do |t|
    where('dtstart BETWEEN ? AND ?', t.to_time.midnight, t.to_time.end_of_day)
  end)

  def update_hours(combo)
    case combo
    when 'closed'
      closed!
    when 'open 24h'
      self.dtstart = dtstart.midnight
      self.dtend = dtstart.end_of_day
    when /-/
      range_begin, range_end = combo.split('-')
      range_begin += 'm' unless range_begin.ends_with? 'm'
      range_end += 'm' unless range_end.ends_with? 'm'

      begin_time = Time.parse(range_begin)
      end_time = Time.parse(range_end)

      self.dtstart = Time.parse(dtstart.strftime('%F') + begin_time.strftime('T%T'))
      self.dtend = Time.parse(dtstart.strftime('%F') + end_time.strftime('T%T'))

      self.dtend += 1.day if dtend < dtstart
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

  def open?
    !closed?
  end

  def open_24h?
    dtstart.localtime == dtstart.localtime.midnight &&
      dtend.localtime == dtstart.localtime.end_of_day
  end

  def self.week(str)
    start = DateTime.strptime(str, '%GW%V').to_time.midnight.to_date

    start...(start + 7.days)
  end
end
