FROM opensuse
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install curl
RUN zypper --non-interactive install ruby

COPY certificates /certificates

COPY run_test.rb /run_test.rb

CMD /run_test.rb
