ARG BASE_TAG=jammy
FROM ubuntu:${BASE_TAG}

RUN apt-get update -q \
    && apt-get install -qy build-essential wget libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Install TexLive with scheme-basic
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
	mkdir /install-tl-unx; \
	tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
    echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; \
	/install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile; \
    rm -r /install-tl-unx; \
	rm install-tl-unx.tar.gz

RUN cd /usr/local/texlive/ \
    && ln -s $(find . -type d -regextype posix-egrep -regex '^./2[0-9]{3}$') current
ENV PATH="/usr/local/texlive/current/bin/x86_64-linux:${PATH}"

ENV HOME /data
WORKDIR /data

# Install latex packages
RUN tlmgr install scheme-full

# Install texstudio
RUN apt-get update
RUN apt-get install -y texstudio ghostscript

RUN mkdir /entrypoints
COPY texstudio-entrypoint.sh /entrypoints/texstudio-entrypoint.sh

RUN chmod +x /entrypoints/texstudio-entrypoint.sh
RUN chown $HOST_UID:$HOST_GID /entrypoints/texstudio-entrypoint.sh
RUN chown -R $HOST_UID:$HOST_GID /data

VOLUME ["/data"]