# Proteus

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/proteus`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

Only supports ActiveRecord for now

## Installation

Add this line to your application's Gemfile:

Add the configuration intializer -> todo make this a generator that copies
automatically with defaults

```ruby
gem 'proteus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proteus

## Usage

Proteus needs to be able to server many domains. The key change to the app is
how stylesheet and assets are hooked into the app.

instead of stylesheet_link_to we will need to make a 
proteus_stylesheet("application") and javascript method as well. This method
takes in the request for the domain name and then will determine which
stylesheet it needs to serve

whitelabeled_link_to
background_color_for(:propery)
image_for(:property)

# avoid import loops
# only .scss manifests & syntax supported
# add gitignore lines 

#### Add the following to your .gitignore file
```
proteus_variables/
proteus_variables/**/*
proteus_*
```


Add proteus stylesheets and vars directory into gitignore

# whitelabeled_domain
#   domain_name -> string
#   slug -> unique indexed string
#   compiled_stylesheet -> default false
#   enabled -> default true

# proteus property
#   type -> SassVar / FeatureFlag / CustomProperty
#   


-> Asset compilation 
each whitelabel domain will probably require it's own custom stylesheet. Since
this deploys with the application it could take a long time per compilation.
Is this acceptable???




## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/proteus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Proteus project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/proteus/blob/master/CODE_OF_CONDUCT.md).


# TODO List

- backend web interface (in progress)
   - home page (DONE)
   - create (DONE)
   - edit
   - delete
   - setup variables (DONE)

- add to hosts whitelist (Rails 6) (DONE)
- before_filter for checking the domain
- check the domain for enabled 

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance [ "yarn:install" ]
end

desc "Compile all the assets named in config.assets.precompile"
  task :precompile => :environment do
    with_logger do
      # see below for how to get the manifest
      # assets is the list of assets to compile "application.css" etc
      manifest.compile(assets)
    end
  end
end

# we can get the manifest above by below
require 'sprockets/rails/task'
Sprockets::Rails::Task.new(Rails.application)

# Rake::Task['db:migrate'].enhance(['db:post_migration_hook'])

# https://github.com/rails/sprockets/blob/master/lib/sprockets/manifest.rb#L160

### rails 6 whitelist hosts

Rails 6 added host whitelisting. We can hook into this in an initializer but
need to find a way to add a new domain and add to the apps in memory config

# config.hosts << "app.getmagnexus.local" 

# loading something live in production
# compilation flag 
# config.assets.compile = true


# the below line outputs the url path to the asset and not the actual file
# path
# source = compute_asset_path("get_magnexus.css", { debug: true, unknown_asset_fallback: true })


# TODO: Items
# proteus:cleanup rake task -> delete all proteus files

# improved asset compilation... this one will be hard but done right it could
# work quite well. If we can get the original manifest and the variables then
# we can change the values so they get output into the stylesheet. At that 
# point we can replace the placeholder values for each final stylesheet. 
# biggest problems will be digests and such. 
