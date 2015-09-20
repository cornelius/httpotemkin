FROM opensuse

RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install ca-certificates-mozilla
RUN gem install --no-document sinatra

COPY server.rb /

CMD /server.rb -p 80

EXPOSE 80
