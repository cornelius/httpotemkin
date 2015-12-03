FROM opensuse
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install ruby-devel gcc-c++ make libopenssl-devel
RUN zypper --non-interactive install ca-certificates-mozilla
RUN zypper --non-interactive install curl
RUN gem install --no-document sinatra thin

COPY server_base.rb /httpotemkin/server/
COPY secure_server.rb /httpotemkin/server/
COPY server.rb /httpotemkin/server/

CMD /httpotemkin/server/server.rb -p 80

EXPOSE 80
EXPOSE 443
