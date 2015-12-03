FROM server
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

COPY secure_server.rb /httpotemkin/rubygems/
COPY server.crt /httpotemkin/rubygems/
COPY server.key /httpotemkin/rubygems/

CMD /secure_server.rb

EXPOSE 443
