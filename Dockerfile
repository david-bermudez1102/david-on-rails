# syntax=docker/dockerfile:1
FROM ruby:2.7.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /david-on-rails
COPY Gemfile /david-on-rails/Gemfile
COPY Gemfile.lock /david-on-rails/Gemfile.lock
RUN bundle config set force_ruby_platform true
RUN gem install nokogiri --platform=ruby
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]