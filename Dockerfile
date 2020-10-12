FROM 0x01be/rfcat:build as build

FROM alpine

COPY --from=build /opt/ /opt/

RUN apk add --no-cache --virtual rfcat-runtime-dependencies \
    python3 \
    py3-numpy

ENV PATH ${PATH}:/opt/sdcc/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/rfcat/lib/python3.8/site-packages/

