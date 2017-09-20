# require 'device_log/configuration'
# require 'device_log/oss'
# require 'device_log/log_bucket'
# require 'device_log/log_fetcher'

module DeviceLog
  autoload :Configuration, 'device_log/configuration.rb'
  autoload :OSS, 'device_log/oss.rb'
  autoload :LogBucket, 'device_log/log_bucket.rb'
  autoload :LogFetcher, 'device_log/log_fetcher.rb'
end
