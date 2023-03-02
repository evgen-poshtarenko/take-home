FROM ruby:3.1.2

# yarn repo
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |\
  gpg --dearmor |\
  tee /usr/share/keyrings/yarnpkg.gpg > /dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/yarnpkg.gpg] https://dl.yarnpkg.com/debian/ stable main" |\
  tee /etc/apt/sources.list.d/yarn.list

# packages
RUN apt-get update -qq && apt-get install -qq postgresql-client iputils-ping nmap vim

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

# node stuff
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get upgrade -qq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && npm install -g yarn@1

RUN npm install -g sass

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app

RUN gem update --system 3.4.6

ENV BUNDLE_PATH /gems

RUN bundle install --full-index

COPY . /usr/src/app/

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0", "-p", "3001"]
