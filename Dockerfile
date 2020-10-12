FROM 0x01be/sdcc as sdcc
FROM 0x01be/pyside as pyside

FROM alpine

COPY --from=sdcc /opt/sdcc/ /opt/sdcc/
COPY --from=pyside /opt/pyside/ /opt/pyside/

ENV PATH  ${PATH}:/opt/sdcc/bin/

RUN apk add --no-cache --virtual rfcat-build-dependencies \
    git \
    build-base \
    python3-dev \
    py3-pip

ENV RFCAT_REVISION master
RUN git clone --depth 1 --branch ${RFCAT_REVISION} https://github.com/atlas0fd00m/rfcat.git /opt/rfcat/bin/

WORKDIR /opt/rfcat/bin
RUN pip3 install -r requirements.txt --prefix /opt/rfcat/

