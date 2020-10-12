FROM 0x01be/sdcc:arm32v6 as sdcc

FROM arm32v6/alpine

COPY --from=sdcc /opt/sdcc/ /opt/sdcc/

RUN apk add --no-cache --virtual rfcat-build-dependencies \
    git \
    build-base \
    python3-dev \
    py3-pip \
    bison \
    flex \
    boost-dev \
    libusb-dev \
    py3-numpy

ENV RFCAT_REVISION master
RUN git clone --depth 1 --branch ${RFCAT_REVISION} https://github.com/atlas0fd00m/rfcat.git /opt/rfcat/bin/

WORKDIR /opt/rfcat/bin
RUN pip3 install --prefix /opt/rfcat/ \
    pyusb \
    future \
    ipython \
    pyserial

RUN ln -s /opt/sdcc/bin/sdcc /usr/bin/FUCKNO_use_SDCC_3.5.0_instead
RUN ln -s /usr/bin/python3 /usr/bin/python

ENV PATH ${PATH}:/opt/sdcc/bin/
WORKDIR /opt/rfcat/bin/firmware
RUN make

