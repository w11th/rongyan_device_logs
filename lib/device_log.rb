require 'logger'

module DeviceLog
  autoload :Configuration, 'device_log/configuration.rb'
  autoload :OSS, 'device_log/oss.rb'
  autoload :LogBucket, 'device_log/log_bucket.rb'
  autoload :LogFetcher, 'device_log/log_fetcher.rb'
  autoload :DB, 'device_log/db.rb'

  @logger = ::Logger.new(Configuration.log_file)
  def self.logger
    @logger
  end
end
