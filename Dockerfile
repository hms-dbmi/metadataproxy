FROM python:2.7.11
COPY . /srv/metadataproxy/

RUN pip --no-cache-dir install -r /srv/metadataproxy/requirements.txt && \
    pip --no-cache-dir install -r /srv/metadataproxy/requirements_wsgi.txt

RUN pip --no-cache-dir install json-logging-py

RUN apt-get update && apt-get install -y iptables

COPY provision.sh /docker-entrypoint

ENV PORT 8000
EXPOSE 8000

VOLUME ["/var/run/docker.sock"]

WORKDIR /srv/metadataproxy

ENTRYPOINT ["/docker-entrypoint"]
CMD ["/bin/sh", "run-server.sh"]
