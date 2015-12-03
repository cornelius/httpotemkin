FROM server
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

COPY secure_server.rb /httpotemkin/obs/
COPY server.crt /httpotemkin/obs/
COPY server.key /httpotemkin/obs/

CMD /httpotemkin/obs/secure_server.rb

EXPOSE 443
