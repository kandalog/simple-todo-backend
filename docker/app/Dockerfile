FROM ruby:3.2.2

WORKDIR /myapp

COPY Gemfile* /myapp/

# build-essential provide essential function to build something. ex C Compiler g++
# You ought install if you wanted to use rbenv
RUN apt -qq update && apt install -y build-essential mariadb-client

RUN gem update --system && \
    bundle install

COPY . /myapp

# You ought health check in yml if you wanted to wait building database
COPY ./docker/app/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]
