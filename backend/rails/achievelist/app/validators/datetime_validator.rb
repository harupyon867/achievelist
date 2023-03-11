class DatetimeValidator < ActiveModel::EachValidator
  require 'date'

  def validate_each(record, attribute, value)
    value_string = to_string(value)

    begin
      date = DateTime.parse(value_string)
      record.errors.add attribute, :datetime, message: options[:message] if date.nil? || date == false
    rescue Date::Error => e
      record.errors.add attribute, :datetime, message: options[:message]
      puts e.message
    end
  end

  private

  def to_string(time)
    if time.is_a?(String)
      time
    elsif time.is_a?(ActiveSupport::TimeWithZone)
      time.strftime('%Y-%m-%d %H:%M:%S')
    else
      ''
    end
  end
end
