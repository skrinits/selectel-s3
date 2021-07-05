require "selectel/s3/version"
require "selectel/s3/configuration"

module Selectel
  module S3
    class << self
      def configuration
        @configuration ||= S3::Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end
