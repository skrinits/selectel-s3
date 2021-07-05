module Selectel
  module S3
    class Configuration
      attr_accessor :access_key_id, :secret_access_key, :endpoint, :region

      def initialize
        @endpoint = 'https://s3.selcdn.ru'
        @region = 'ru-1'
      end
    end
  end
end
