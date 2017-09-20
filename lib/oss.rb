require 'aliyun/oss'
require 'configuration'

module OSS
  def self.client
    unless @client
      Aliyun::Common::Logging.set_log_file(Configuration.sdk_log_file)
      @client = Aliyun::OSS::Client.new(
        endpoint: Configuration.endpoint,
        access_key_id: Configuration.access_key_id,
        access_key_secret: Configuration.access_key_secret
      )
    end
    @client
  end
end
