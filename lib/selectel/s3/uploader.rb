require 'open-uri'
require 'aws-sdk-s3'

module Selectel
  module S3
    class Uploader
      def initialize(container_name)
        @s3_resource = Aws::S3::Resource.new(
          region: config.region, access_key_id: config.access_key_id,
          secret_access_key: config.secret_access_key, endpoint: config.endpoint
        )
        @container_name = container_name
      end

      def upload_remote_file(file_url, remote_path)
        object = s3_resource.bucket(container_name).object(remote_path)

        file = fetch_file(file_url)

        object.upload_file(file)

        file.delete
      end

      def upload_file(file_path, remote_path = file_path)
        object = s3_resource.bucket(container_name).object(remote_path)

        object.upload_file(file_path)
      end

      def upload_folder(folder_path, remote_path)
        started_at = Time.now
        absolute_folder_path = File.expand_path(folder_path)
        files = fetch_all_files(absolute_folder_path)

        files.each do |file_path|
          remote_file_path = file_path.sub(absolute_folder_path, remote_path)

          upload_file(file_path, remote_file_path)
        end

        puts "Uploaded #{ files.size } files for #{ Time.now - started_at } seconds"
      end

      private

      attr_reader :container_name, :s3_resource

      def config
        @config ||= S3.configuration
      end

      def fetch_all_files(folder_path)
        Dir["#{ folder_path }/**/*"].select { |path| File.file?(path) }
      end

      def fetch_file(file_url)
        file = open(file_url)

        return file unless file.is_a?(StringIO)

        result = Tempfile.new

        File.write(result.path, file.string)

        result
      end
    end
  end
end
