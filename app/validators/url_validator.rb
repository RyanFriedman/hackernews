class UrlValidator < ActiveModel::EachValidator
 
  def validate_each(record, attribute, value)
    valid = begin
      !!URI.parse(value)
    rescue URI::InvalidURIError
      false
    end
    unless valid
      record.errors[attribute] << (options[:message] || "is an invalid URL")
    end
  end
 
end