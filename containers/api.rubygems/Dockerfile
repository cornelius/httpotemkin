FROM server
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

COPY secure_server.rb /httpotemkin/api.rubygems/
COPY server.crt /httpotemkin/api.rubygems/
COPY server.key /httpotemkin/api.rubygems/
COPY latest_specs.4.8.gz /httpotemkin/api.rubygems/
COPY rubygems-update-2.5.0.gemspec.rz /httpotemkin/api.rubygems/

CMD /httpotemkin/api.rubygems/secure_server.rb

EXPOSE 443
