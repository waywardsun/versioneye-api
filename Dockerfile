FROM        versioneye/ruby-base:2.4.24
MAINTAINER  Robert Reiz <reiz@versioneye.com>

ADD . /app

RUN cd /app/ && bundle install;

EXPOSE 9090

CMD bundle exec puma -C config/puma.rb
