class Enumeration
  def self.add_item(key,value)
    @hash ||= {}
    @hash[key] = value
  end

  def self.const_missing(key)
    @hash[key]
  end

  def self.each
    @hash.each { |k,v| yield(k,v) }
  end

  def self.values
    @hash.values || []
  end

  def self.keys
    @hash.keys || []
  end

  def self.[](*keys)
    return @hash[keys[0]] if keys.size == 1
    keys.map { |k| @hash[k] }
  end
end

# Handles Global Consants
class Constants < Enumeration
  #time constants
  self.add_item(:STANDARD_TZ, "UTC")
  self.add_item(:TIME_FORMAT, "%Y-%m-%dT%H:%M:%S.%3N%:z")
  self.add_item(:MINUTE_IN_SECONDS, 60)
  self.add_item(:HOUR_IN_MINUTES, 60)
  self.add_item(:HOUR_IN_SECONDS, 60*60)
  self.add_item(:DAY_IN_HOURS, 24)
  self.add_item(:WEEK_IN_DAYS, 7)
  self.add_item(:SITE_NAME, "Facebook Research Viz")
  self.add_item(:TAB_INDENT, " ")

  # Session constants
  self.add_item(:USER_ID, '_user')

  self.add_item(:CONTACT_EMAIL, "sauvik@cmu.edu")
  self.add_item(:ROOT_URL, "https://experiment.sauvik.me/")
  self.add_item(:TURK_SANDBOX_ENABLED, true)

  self.add_item(:AWS_ACCESS_KEY, ENV['S3_KEY'])
  self.add_item(:AWS_SECRET_KEY, ENV['S3_SECRET'])
end