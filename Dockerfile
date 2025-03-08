FROM python:2.7.18-slim-buster

COPY TI-BASIC_* /tmp/
COPY ti-basic /usr/local/bin/
WORKDIR /opt
RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/rzuckerm/pitybas -b v$(cat /tmp/TI-BASIC_VERSION) && \
    find pitybas -mindepth 1 -maxdepth 1 '!' '(' -name 'pb.py' -o -name 'pitybas' ')' -exec rm '{}' ';' && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV PYTHONPATH=/opt/pitybas
