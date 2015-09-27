FROM opensuse
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install ruby-devel gcc-c++ make libopenssl-devel
RUN zypper --non-interactive install ca-certificates-mozilla
RUN zypper --non-interactive install curl
RUN gem install --no-document sinatra thin

COPY server.crt /
COPY server.key /

COPY server.rb /
COPY secure_server.rb /

CMD /server.rb -p 80

EXPOSE 80
EXPOSE 4568
