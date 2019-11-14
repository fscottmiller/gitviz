FROM ruby

WORKDIR /project
COPY Gemfile .
COPY do.rb .

RUN bundle install

ENTRYPOINT ["ruby", "do.rb"]
