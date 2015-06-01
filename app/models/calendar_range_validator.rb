class CalendarRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if Calendar.valid_range?(value) || value.blank?
    record.errors[attribute] << "#{value} is not a time range"
  end
end
