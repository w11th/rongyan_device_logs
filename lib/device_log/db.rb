module DeviceLog
  module DB
    class << self
      def timestamp
        unless File.file?(Configuration.db_file)
          self.timestamp = 0
          return 0
        end
        File.read(Configuration.db_file).to_i
      end

      def timestamp=(timestamp)
        File.open(Configuration.db_file, 'w') do |f|
          f.puts timestamp
        end
      end
    end
  end
end
