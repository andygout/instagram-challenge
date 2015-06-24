[![Build Status](https://travis-ci.org/andygout/instagram-challenge.png)](https://travis-ci.org/andygout/instagram-challenge)

Instagram Challenge
===================


Challenge:
-----

Build Instagram: Simple huh!

Your challenge is to build Instagram using Rails. You'll need **users** who can post **pictures**, write **comments** on pictures and **like** a picture. Style it like Instagram's website (or more awesome).

Bonus if you can add filters!


User stories:
-------

```
As an avid photographer
I want to be able to post my pictures on the internet
So that I can share them with the world

As a follower of photography
I want to be able to comment on other users' photos
So that I can let the photographer know my thoughts

As a pedantic follower of photography
I want to be able to edit/delete my comments on other users' photos
So that I can rectify what I originally write

As a photography enthusiast with little time
I want to be able to quickly 'like' other users' photos
So that I can register my appreciation of the photo

As a user who has an account
I want permission to add/edit/delete my photos only when logged into my account
So that I can control my collection

As a forgetful visitor of the site
I want to only be able to 'like' photos once
So that I don't mistakenly tally up the 'likes' of a photo
```


Technologies Used:
-------

* Ruby On Rails (full stack, Web application framework)
* Tested using RSpec (provides a behaviour driven development framework for the language, allowing to write application scenarios and test them.)
* Shoulda (Ruby gem for testing)
* Devise (Ruby gem which handles building a user model, routes for your users controller, and also OmniAuth (which handles those 'Log in with Facebook'-type buttons))
* OmniAuth (OmniAuth is a flexible Ruby authentication framework utilizing Rack middleware aimed to abstract away the difficulties of working with various types of authentication providers)
* Poltergeist (headless browser for Capybara based on PhantomJS (scripted, headless browser used for automating web page interaction; provides a JavaScript API enabling automated navigation, screenshots, user behavior and assertions making it a common tool used to run browser-based unit tests in a headless system like a continuous integration environment))


Set-up Steps:
-----

* `$ gem install rails`
* `$ rails --help` (provides menu)
* `$ rails new . instagram-challenge -d postgresql -T` (`instagram-challenge` - name of app; `-d` - preconfigures app for particular type of database (being overridden to use PostgreSQL); `-T` turns off built-inRails test suite to allow RSpec)
* Start server: `$ bin/rails server` or (shortcut) `$ rails s`
* Create databases: `$ bin/rake db:create RAILS_ENV=test` and `$ bin/rake db:create RAILS_ENV=development`
* Add to test group in `Gemfile`: `'rspec-rails'` and `'capybara'`
* Install newly added gems: `$ bundle`
* Initiate RSpec: `$ bin/rails generate rspec:install` (creates `spec` directory with `spec_helper.rb` and `rails_helper.rb` and `.rspec` file)
* `.rspec` file should include: `-- color` `--format documentation` `--require spec_helper`
* `spec/rails_helper.rb` - add below other require statements: `require 'capybara/rails`
* `spec/features` dir: add first feature test
* `config.routes.rb` add: `root : 'photos#index'` `resources :photos` (`$ bin/rake routes` to display different CRUD (create-read-update-delete) routes created)
* `bin/rails g controller photos` - generates a 'photos_controller.rb` in `app/controllers` and rspec test in `spec/controllers` (delete latter) (`g` = generate)
* `app/controllers/photos_controller.rb` -> define `index` method
* `touch app/views/photos/index.html.erb` -> creates index file for controller to reference
* Generate model: `$ bin/rails g model photo descr:string` (migration files stored in `db/migrate/` - version control system that compiles database upon migration)
* Run migration generated by preceding command: `bin/rake db:migrate` (or poss. `bin/rake db:migrate RAILS_ENV=test` and `bin/rake db:migrate RAILS_ENV=development`)
* Add `shoulda` gem to Gemfile and run `bundle install`
* Add `devise` gem to Gemfile and run `bundle install`; run Devise generator `$ bin/rails g devise:install`; tell Devise to make user model `$ bin/rails g devise User`; then `$ rake db:migrate` to add user table to database.
* Add `omniauth-facebook` gem to Gemfile and run `bundle install`
* Add columns 'provider' (string) and 'uid' (string) to your user model: `rails g migration AddColumnsToUsers provider uid`; then `rake db:migrate` to effect changes
* Declare provider in `config/initializers/devise.rb`: `config.omniauth :facebook, "APP_ID", "APP_SECRET"`
* Make model (`app/models/user.rb`) omniauthable: `devise :omniauthable, :omniauth_providers => [:facebook]`
* See `Github - OmniAuth: Overview` link below for remaining steps required
* Poltergeist required PhantomJS - install using Homebrew: `brew install phantomjs`
* Add `poltergeist` gem to Gemfile; run `bundle install`; require in `spec/rails_helper.rb`: `require 'capybara/poltergeist'` `Capybara.javascript_driver = :poltergeist`
* Add `database_cleaner` gem to Gemfile; run `bundle install`; require in `spec/rails_helper.rb`: `require 'support/database_cleaner'`
* In `spec/rails_helper.rb` switch following line from true to false: `config.use_transactional_fixtures = false`
* Add dir and file: `spec/support/database_cleaner.rb`; add to file code from [Virtuous Code - Configuring database_cleaner with Rails, RSpec, Capybara, and Selenium](http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/)
* Install ImageMagick (code library that deals with image compression) with Homebrew: `$ brew install imagemagick`
* Add `paperclip` gem to Gemfile and run `bundle install` (Paperclip is a gem that makes file uploads to Ruby apps a bit simpler)
* Amazon Web Services (AWS) S3 (Simple Storage Service) cloud server to save image files: add Amazon Web Services (AWS) `'aws-sdk', '< 2.0'` gem to Gemfile; run `bundle install`


Next Steps:
-------

* Try alternate method of RSpec test for successful upload and display of image: `expect(page).to have_css('img[alt="Iceland"]')`

* Rectify tests after adding `<%= photo.user.email %>` to `views/photos/index.html.erb` (all test images must have attributed user else error thrown)

* Check pluralize method is working (in both localhost and testing environment)

* Validation: image file must be uploaded if photo is being added/updated

* When editing photo, image file should be included as existing file for given photo

* Attribute users to comments and likes

* Add image to photo's profile page

* Functionality and testing to prevent user from liking same photo more than once

* Functionality and testing to prevent user from liking their own photo

* Tests to cover all facets of authentication as per `app/controllers/photos_controller.rb` and `app/controllers/comments_controller.rb`

* Use partials for: `app/views/photos/new.html.erb` and `app/views/photos/edit.html.erb` (`@photos.errors.any?` block is duplicated; possible to use partial for entire form except minor differences of button labels (add / update)?)

* Ability to edit comments w/requisite validation and testing (currently only able to add comments)

* Apply Ruby 'Time Ago In Words' gem:-

[Ruby On Rails - Time Ago In Words gem](http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-time_ago_in_words)

[Ruby Doc - Gems info](http://www.rubydoc.info/gems/time_ago_in_words/0.1.1)


Links:
-------

[Github - Makers Academy: Instagram Challenge](https://github.com/makersacademy/instagram-challenge)

[Github - OmniAuth: Overview](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)


Images:
-------

- Instagram (Tom Anderson @myspacetom)
![Tom Anderson Instagram page](git_imgs/instagram-myspacetom.png)