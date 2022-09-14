# Ruby Gems
- Ruby Gems are basically Libraries, packages
- Gem packages located at: `Gemfile`
- Installing Gems: `bundle install`

## Gemfile:

```rb
# for file uploads
gem 'carrierwave', '~> 2.0'

# image filters, autosiing
gem 'mini_magick'

# api aws connctor
gem 'fog-aws'

# handling credentials securly like .env files
gem 'figaro'
```

## Setting up secrets:
- `fiagro  install`
- [fiagro docs](https://github.com/laserlemon/figaro)
> This generates `config/application.yaml` for storing credentials.
> Appends those files into `.gitignore`

**config/application.yaml**
```yaml
AWS_ACCESS_KEY_ID: "AWS_ACCESS_KEY_ID"
AWS_SECRET_ACCESS_KEY: "AWS_SECRET_ACCESS_KEY"
development:
  AWS_BUCKET: ""
production:
  AWS_BUCKET: ""
```

## File Uploader
- `rails g uploader TaskFile` gem => `carrierwave`
- Creates a uploader file `app/uploaders/task_file_uploader.rb`
- [Carrier Wave Docs](https://rubydoc.info/gems/carrierwave/frames)

```rb
class TaskFileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  include Sprockets::Rails::Helper
  # Choose what kind of storage to use for this uploader:
  # storage :file
   storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_whitelist
    %w(jpg jpeg gif png)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
```

## Authentication:
- Gem: `devise` used for authentication.
- `bundle install`
- [Devise Git](https://github.com/heartcombo/devise)

- Setup: `rails generate devise:install`

```sh
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Depending on your application's configuration some manual setup may be required:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

     * Required for all applications. *

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"
     
     * Not required for API-only Applications *

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

     * Not required for API-only Applications *

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views
       
     * Not required *

===============================================================================
```