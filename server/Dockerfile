FROM opensuse
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install ca-certificates-mozilla
RUN zypper --non-interactive install curl
RUN gem install --no-document sinatra

COPY server.rb /
COPY secure_server.rb /
COPY server.crt /
COPY server.key /

CMD /server.rb -p 80

EXPOSE 80
EXPOSE 4568
