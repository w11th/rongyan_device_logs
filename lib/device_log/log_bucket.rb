require 'aliyun/oss'

module DeviceLog
  module LogBucket
    class << self
      def client
        unless @client
          ::Aliyun::Common::Logging.set_log_file(Configuration.sdk_log_file)
          @client = ::Aliyun::OSS::Client.new(
            endpoint: Configuration.endpoint,
            access_key_id: Configuration.access_key_id,
            access_key_secret: Configuration.access_key_secret
          )
        end
        @client
      end

      def bucket
        @bucket ||= client.get_bucket(Configuration.bucket_name)
      end

      def list_logs(opts = {})
        opts[:prefix] = Configuration.logs_prefix
        bucket.list_objects(opts)
      end

      def list_archived_logs(opts = {})
        opts[:prefix] = Configuration.archived_logs_prefix
        bucket.list_objects(opts)
      end

      def save_log(key)
        filename = File.basename(key)
        target_file = File.join(Configuration.device_log_dir, filename)
        bucket.get_object(key, file: target_file)
      end

      def delete_log(key)
        bucket.delete_object(key)
      end

      def archive_log(key)
        filename = File.basename(key)
        copy_to = "#{Configuration.archived_logs_prefix}#{filename}"
        bucket.copy_object(key, copy_to, meta_directive: ::Aliyun::OSS::MetaDirective::COPY)
      end
    end
  end
end
