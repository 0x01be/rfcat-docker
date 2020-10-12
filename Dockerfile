FROM arm32v6/alpine

RUN apk add --no-cache --virtual rfcat-build-dependencies \
    git \
    build-base \
    python3-dev \
    py3-pip \
    bison \
    flex \
    boost-dev \
    libusb-dev

ENV SDCC_REVISION master
RUN git clone --depth 1 --branch ${SDCC_REVISION} https://github.com/swegener/sdcc.git /sdcc

ENV RFCAT_REVISION master
RUN git clone --depth 1 --branch ${RFCAT_REVISION} https://github.com/atlas0fd00m/rfcat.git /opt/rfcat/bin/

WORKDIR /sdcc

RUN ./configure \
    --build=amd64-linux \
    --disable-pic14-port \
    --disable-pic16-port \
    --prefix=/opt/sdcc

RUN apk add zlib-dev

RUN make
RUN make install

WORKDIR /rfcat
RUN pip3 install -r requirements.txt --prefix /opt/rfcat/

