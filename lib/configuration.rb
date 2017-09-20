require 'yaml'

class Configuration
  class << self
    def root_path
      @root_path ||= File.expand_path('..', File.dirname(__FILE__))
    end

    def conf_file
      @conf_file ||= File.join(root_path, 'conf', 'conf.yml')
    end

    def log_dir
      @log_dir ||= File.join(root_path, 'log')
    end

    def sdk_log_file
      @log_file ||= File.join(log_dir, 'oss_sdk.log')
    end

    def device_log_dir
      @device_log_dir ||= File.join(root_path, 'log', 'device')
    end

    def db_file
      @db_file ||= File.join(root_path, 'db', 'registry')
    end

    private

    def config
      @config ||= YAML.safe_load(File.read(conf_file))
    end
  end

  config.each do |key, value|
    define_singleton_method(key) do
      value
    end
  end
end
