#!/bin/bash

curl --cacert /certificates/rubygems.crt https://api.rubygems.org -s
curl --cacert /certificates/obs.crt https://api.opensuse.org -s
