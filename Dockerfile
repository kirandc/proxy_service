FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /proxy_service
WORKDIR /proxy_service
COPY Gemfile /proxy_service/Gemfile
COPY Gemfile.lock /proxy_service/Gemfile.lock
COPY config/database.yml /proxy_service/config/database.yml
RUN gem install bundle
RUN bundle install
COPY . /proxy_service

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]