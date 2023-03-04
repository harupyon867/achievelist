FROM ruby:3.2.1

WORKDIR /achievelist
COPY ./rails/achievelist/Gemfile /achievelist/Gemfile
COPY ./rails/achievelist/Gemfile.lock /achievelist/Gemfile.lock
RUN bundle install
COPY ./rails/achievelist /achievelist

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80

CMD ["rails", "server", "-b", "0.0.0.0"]