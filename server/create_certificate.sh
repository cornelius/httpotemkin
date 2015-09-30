openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 1000 -nodes -subj '/CN=api.rubygems.org'
