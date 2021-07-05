# Selectel::S3

Uploading files to selectel s3 store (https://developers.selectel.ru/docs/cloud-services/cloud-storage/s3/storage_s3_api/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'selectel-s3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install selectel-s3

## Usage
### Configuration
```ruby

  Selectel::S3.configure do |config|
    config.access_key_id = 'access_key_id'
    config.secret_access_key = 'secret_access_key'
    config.endpoint = 'https://s3.selcdn.ru' # default value
    config.region = 'ru-1' # default value
  end


```

### Code example
```ruby
  require 'selectel/s3/uploader'


  uploader = Selectel::S3::Uploader.new('container_name')

  # upload a local file
  uploader.upload_file('local_file_path', 'remote_path')
  # upload a local folder
  uploader.upload_folder('local_folder_path', 'remote_folder_path')
  # upload a remote file
  uploader.upload_remote_file('file_url', 'remote_path')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/selectel-s3. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Selectel::S3 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/selectel-s3/blob/master/CODE_OF_CONDUCT.md).
