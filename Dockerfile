FROM opensuse

RUN zypper -n in ruby
RUN gem install sinatra

COPY server.rb /

CMD /server.rb

EXPOSE 4567
