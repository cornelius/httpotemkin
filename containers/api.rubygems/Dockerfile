FROM server
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

COPY secure_server.rb /httpotemkin/api.rubygems/
COPY server.crt /httpotemkin/api.rubygems/
COPY server.key /httpotemkin/api.rubygems/

CMD /httpotemkin/api.rubygems/secure_server.rb

EXPOSE 443
