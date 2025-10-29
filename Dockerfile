# FROM bitnami/minideb:latest
# Label MAINTAINER Amir Pourmand
# RUN apt-get update -y
# # add locale
# RUN apt-get -y install locales
# # Set the locale
# RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
#     locale-gen
# ENV LANG en_US.UTF-8  
# ENV LANGUAGE en_US:en  
# ENV LC_ALL en_US.UTF-8  

# # add ruby and jekyll
# RUN apt-get install --no-install-recommends ruby-full build-essential zlib1g-dev -y 
# RUN apt-get install imagemagick -y 
# RUN apt-get clean \
#     && rm -rf /var/lib/apt/lists/
# # ENV GEM_HOME='root/gems' \
# #     PATH="root/gems/bin:${PATH}"
# #RUN gem install jekyll bundler
# # RUN gem install bundler && gem install jekyll
# RUN gem install bundler:2.4.22
# RUN mkdir /srv/jekyll
# ADD Gemfile /srv/jekyll
# WORKDIR /srv/jekyll
# RUN bundle install

FROM ruby:3.2-slim

# Locale setup
RUN apt-get update -y && apt-get install -y locales build-essential zlib1g-dev imagemagick \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Bundler
RUN gem install bundler:2.4.22

# Jekyll setup
WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["bundle", "exec", "jekyll", "serve"]
