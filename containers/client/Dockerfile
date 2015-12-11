FROM opensuse:42.1
MAINTAINER Cornelius Schumacher <schumacher@kde.org>

RUN zypper --non-interactive install  ca-certificates-mozilla

RUN zypper --non-interactive install curl
RUN zypper --non-interactive install ruby
RUN zypper --non-interactive install --no-recommends osc
RUN zypper --non-interactive install tar

# Dependencies for yes_ship_it
RUN zypper --non-interactive install ruby2.1-rubygem-inifile ruby2.1-rubygem-rest-client ruby2.1-rubygem-cheetah
RUN zypper --non-interactive install git

# Configuration for OBS client
COPY oscrc /root/.oscrc

COPY certificates/rubygems.crt /etc/pki/trust/anchors/rubygems.pem
COPY certificates/api.rubygems.crt /etc/pki/trust/anchors/api.rubygems.pem
COPY certificates/obs.crt /etc/pki/trust/anchors/obs.pem

RUN update-ca-certificates

COPY run_test.rb /run_test.rb

# Configuration for gem
RUN mkdir /root/.gem
RUN echo ":rubygems_api_key: 123" >/root/.gem/credentials
RUN chmod 0600 /root/.gem/credentials

# Configuration for git
RUN git config --global user.email "hw@example.com"
RUN git config --global user.name "Hans Wurst"
RUN git config --global receive.denyCurrentBranch ignore
RUN git config --global push.default simple

CMD /run_test.rb
