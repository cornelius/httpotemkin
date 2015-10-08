FROM opensuse
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install curl
RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install --no-recommends osc

COPY oscrc /root/.oscrc

COPY certificates/rubygems.crt /etc/pki/trust/anchors/rubygems.pem
COPY certificates/api.rubygems.crt /etc/pki/trust/anchors/api.rubygems.pem
COPY certificates/obs.crt /etc/pki/trust/anchors/obs.pem

RUN update-ca-certificates

COPY run_test.rb /run_test.rb

CMD /run_test.rb
