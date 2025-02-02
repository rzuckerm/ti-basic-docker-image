FROM ubuntu:18.04

COPY TI-BASIC_* /tmp/
RUN apt-get update && \
    apt-get install -y git python2.7 && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/rzuckerm/pitybas -b v$(cat /tmp/TI-BASIC_VERSION) && \
    cd pitybas && \
    find -mindepth 1 -maxdepth 1 '!' '(' -name 'pb.py' -o -name 'pitybas' ')' -exec rm '{}' ';' && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /opt/pitybas/pb.py /usr/local/bin/ti-basic
ENV PYTHONPATH=/opt/pitybas
ENV PATH="/opt/pitybas:${PATH}"
