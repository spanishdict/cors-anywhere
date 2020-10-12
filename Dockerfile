FROM node:12.16.1-slim
MAINTAINER curiositymedia

# Load the secrets.
RUN apt-get update && apt-get install -y --no-install-recommends \
  ruby \
  curl \
  libssl-dev \
  && rm -rf /var/lib/apt/lists/*
RUN gem install aws-sdk-s3:'~> 1.81' aws-sdk-kms:'~> 1.31' --no-ri --no-rdoc
COPY bin/docker-entrypoint.sh /
COPY bin/getS3Config /
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# Set up the app.
RUN mkdir -p /usr/src/app/lib
RUN mkdir -p /usr/src/app/node_modules
RUN mkdir -p /usr/src/app/config
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
COPY server.js /usr/src/app/
COPY lib /usr/src/app/lib
COPY node_modules /usr/src/app/node_modules

# Run the app.
EXPOSE 8080
COPY bin/docker-cmd.sh /
RUN chmod +x /docker-cmd.sh
CMD ["/docker-cmd.sh"]
