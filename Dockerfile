FROM postgres:9.3

RUN \
    apt-get update && \
    apt-get clean && \
    apt-get install -y postgresql-9.3-plv8 && \
    apt-get install postgresql-contrib-9.3 -y

ADD secrets_to_env.sh /usr/lib/bin/
ADD 001_secrets_to_env_specifier.sh /docker-entrypoint-initdb.d/
