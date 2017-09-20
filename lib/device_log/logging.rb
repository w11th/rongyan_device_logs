module DeviceLog
  module Logging
    def self.logger
      @logger ||= Logger.new(Configuration.log_file, 10, 10 * 1024 * 1024)
    end
  end
end
