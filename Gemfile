source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.1.2"

gem "autoprefixer-rails"
gem "bcrypt", "3.1.13"

gem "active_storage_validations", "0.8.2"
gem "bootstrap-sass", "3.4.1"
gem "config"
gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"
gem "figaro"
gem "i18n-js", "~> 3.8", ">= 3.8.1"
gem "image_processing", "1.12.2"
gem "importmap-rails"
gem "jbuilder"
gem "mini_magick", "4.9.5"
gem "mysql2", "~> 0.5"
gem "pagy", "~> 5.10", ">= 5.10.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.5", ">= 6.1.5.1"
gem "rails-i18n"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbolinks", "~> 5"
gem "turbo-rails"
gem "webpacker", "~> 5.0"

gem "bootsnap", require: false
gem "net-smtp", require: false
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

group :development, :test do
  gem "debug", platforms: %i(mri mingw x64_mingw)
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
