class Calendar < ActiveRecord::Base
  belongs_to :location
  has_one :library, through: :location

  scope :in_range, (lambda do |range|
    where('dtstart BETWEEN ? AND ?', range.begin.to_time.midnight, range.end.to_time.end_of_day)
  end)

  scope :for_date, (lambda do |t|
    where('dtstart BETWEEN ? AND ?', t.to_time.midnight, t.to_time.end_of_day)
  end)

  def date
    dtstart.to_date
  end

  def open?
    !closed?
  end

  def open_24h?
    dtstart.localtime == dtstart.localtime.midnight &&
      dtend.localtime == (dtstart.localtime.midnight + 1.day).midnight
  end

  def self.week(str)
    start = DateTime.strptime(str, '%GW%V').to_time.midnight.to_date

    start...(start + 7.days)
  end
end
