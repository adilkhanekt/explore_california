FROM ruby:alpine
MAINTAINER Adilkhan <adilkhanekt@gmail.com>

RUN apk add --no-cache build-base ruby-nokogiri
RUN gem install rspec capybara selenium-webdriver

ENTRYPOINT [ "rspec" ]