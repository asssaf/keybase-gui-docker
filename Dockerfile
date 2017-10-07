FROM ubuntu

RUN apt-get update \
	&& apt-get install -y curl fuse libgconf-2-4 libx11-xcb1 libxss1 libnss3 libasound2 \
	&& curl -O https://prerelease.keybase.io/keybase_amd64.deb \
	&& dpkg -i keybase_amd64.deb ; apt-get install -yf \
	&& rm /keybase_amd64.deb \
	&& rm -rf /var/lib/apt/lists/* \

ENV logdir=/tmp/keybase

ENV HOME=/tmp
RUN mkdir $HOME/.config
RUN chmod 1777 $HOME/.config

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT /entrypoint.sh
