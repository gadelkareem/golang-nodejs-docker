FROM postgres:11.5

RUN sed -i 's/exec "$@"/exec "$@" \&/g' /docker-entrypoint.sh

RUN apt-get update && apt-get install -y git python jq curl wget

#### Golang https://github.com/docker-library/golang/blob/11eef5dfbc243e2c172c0ed0a38f65c0c756486d/1.14/buster/Dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /usr/local/go/bin:$PATH
RUN set -eux; \
    	\
    	wget -O go.tgz https://golang.org/dl/go1.14.4.linux-amd64.tar.gz --progress=dot:giga; \
        tar -C /usr/local -xzf go.tgz; \
        rm -f go.tgz; \
        mkdir -p $HOME/go/bin $HOME/go/src

ENV GOPATH $HOME/go
ENV PATH $GOPATH/bin/bin:$PATH

### NodeJS https://github.com/nodejs/docker-node/blob/1d6a051d71e817f3947612a260ddcb02e48c2f74/14/buster/Dockerfile
RUN set -eux; \
        \
        curl -sL https://deb.nodesource.com/setup_14.x | bash -; \
        apt-get update; \
        apt-get install -y nodejs; \
        npm install gulp -g \
        npm install yarn -g

#### redis https://github.com/docker-library/redis/blob/3a0b4f1d370e4efd30a0db32b0e0cf878f3133d3/6.0/Dockerfile
RUN set -eux; \
        \
        apt -y install redis-server

#heroku
RUN curl https://cli-assets.heroku.com/install.sh | sh
