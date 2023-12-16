FROM ubuntu:18.04

COPY TI-BASIC_* /tmp/
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen "en_US.UTF-8" && \
    update-locale LC_ALL="en_US.UTF-8" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV LC_ALL="en_US.UTF-8"
RUN apt-get update && \
    apt-get install -y git default-jdk && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/patrickfeltes/ti-basic-interpreter && \
    cd ti-basic-interpreter && \
    git reset --hard $(cat /tmp/TI-BASIC_COMMIT_HASH) && \
    mkdir build && \
    cd src && \
    sed -i -r '/System\.out\.println\(tokens\);/d' com/patrickfeltes/interpreter/Main.java && \
    javac -d ../build $(find -name '*.java') && \
    cd ../build && \
    jar --main-class=com.patrickfeltes.interpreter.Main -c -v -f ../TiBasicInterpreter.jar * && \
    cd / && \
    find /opt/ti-basic-interpreter -mindepth 1 -maxdepth 1 '!' -name '*.jar' -exec rm -rf '{}' ';' && \
    apt-get remove -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
