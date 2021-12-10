FROM golang:1.14.3

RUN apt-get update && apt-get install -y git python jq curl

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN npm install gulp -g
RUN npm install yarn -g

#psql
RUN apt-get install -y postgresql-client

#heroku
RUN curl https://cli-assets.heroku.com/install.sh | sh


# cleanup
RUN set -eux; \
        \
        apt-get autoremove -y; \
        apt-get clean autoclean; \
        rm -rf \
            /usr/local/go/pkg/*/cmd \
            /usr/local/go/pkg/bootstrap \
            /usr/local/go/pkg/obj \
            /usr/local/go/pkg/tool/*/api \
            /usr/local/go/pkg/tool/*/go_bootstrap \
            /usr/local/go/src/cmd/dist/dist \
            /var/lib/{apt,dpkg,cache,log}
