module DeviceLog
  module LogFetcher
    # 在 db/registry 记录上一次执行的时间戳，在获取日志文件列表后，判断日志文件的更新时间。
    # 如果更新时间在上一次执行的时间之前，则不处理该文件，减少请求次数。
    def self.fetch
      # 从 db/registry 获取上一次执行的时间， UTC
      unless File.file?(Configuration.db_file)
        File.open(Configuration.db_file, 'w') do |f|
          f.puts '0'
        end
      end
      last_run_timestamp = File.read(Configuration.db_file).to_i
      new_run_time = Time.now

      logs_count = 0
      saved_logs = []
      logs = LogBucket.list_logs
      logs.each do |log|
        logs_count += 1
        next if log.last_modified.to_i < last_run_timestamp
        LogBucket.save_log(log.key)
        saved_logs << log.key
      end

      File.open(Configuration.db_file, 'w') do |f|
        f.puts new_run_time.to_i
      end

      puts "start_time: [#{new_run_time}] end_time: [#{Time.now}] total_logs: #{logs_count} saved_logs: #{saved_logs.count}"
    end
  end
end
