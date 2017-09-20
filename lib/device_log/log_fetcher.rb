module DeviceLog
  module LogFetcher
    # 在 db/registry 记录上一次执行的时间戳，在获取日志文件列表后，判断日志文件的更新时间。
    # 如果更新时间在上一次执行的时间之前，则不处理该文件，减少请求次数。
    def self.fetch
      # 从 db/registry 获取上一次执行的时间， UTC
      last_run_timestamp = DB.timestamp
      new_run_time = Time.now

      # for logging
      logs_count = 0
      saved_logs = []

      logs = LogBucket.list_logs
      logs.each do |log|
        logs_count += 1
        next if log.last_modified.to_i < last_run_timestamp
        Logging.logger.debug "#{log.key} need to be saved. last_modified=#{log.last_modified}, last_run_time=#{Time.strptime(last_run_timestamp.to_s, '%s').utc}"
        p "[#{new_run_time}] #{log.key} need to be saved. last_modified=#{log.last_modified}, last_run_time=#{Time.strptime(last_run_timestamp.to_s, '%s').utc}"
        LogBucket.save_log(log.key)
        saved_logs << log.key
      end

      DB.timestamp = new_run_time.to_i
      Logging.logger.info "used_time: #{Time.now - new_run_time} total_logs: #{logs_count} saved_logs: #{saved_logs.count}"
      p "[#{new_run_time}] used_time: #{Time.now - new_run_time} total_logs: #{logs_count} saved_logs: #{saved_logs.count}"
    end
  end
end
