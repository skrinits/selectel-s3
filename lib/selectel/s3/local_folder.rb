require 'aws-sdk-s3'
require 'selectel/s3/uploader'

module Selectel
  module S3
    class LocalFolder
      def initialize(path)
        @path = File.expand_path(path)
        @s3_resource = Aws::S3::Resource.new(
          region: config.region, access_key_id: config.access_key_id,
          secret_access_key: config.secret_access_key, endpoint: config.endpoint
        )
      end

      def synchronize(container_name, remote_path)
        objects = s3_resource.bucket(container_name).objects
        uploader = Uploader.new(container_name)
        started_at = Time.now

        hashed_objects = objects.each_with_object({}) { |object, result| result[object.key] = object }

        fetch_all_files.each do |file_path|
          object_key = file_path.sub(path, remote_path)

          if hashed_objects.key?(object_key)
            hashed_objects.delete(object_key)
          else
            uploader.upload_file(file_path, object_key)
          end
        end

        hashed_objects.values.each(&:delete)

        puts "Synchronized for #{ Time.now - started_at } seconds"
      end

      private

      attr_reader :path, :s3_resource

      def fetch_all_files
        Dir["#{ path }/**/*"].select { |object_path| File.file?(object_path) }
      end

      def config
        @config ||= S3.configuration
      end
    end
  end
end
