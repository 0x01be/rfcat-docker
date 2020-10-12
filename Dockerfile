FROM 0x01be/rfcat:build as build

FROM alpine

COPY --from=build /opt/ /opt/

RUN apk add --no-cache --virtual rfcat-runtime-dependencies \
    libstdc++ \
    python3 \
    py3-numpy

ENV PATH ${PATH}:/opt/sdcc/bin/:/opt/rfcat/bin/
ENV PYTHONPATH /usr/lib/python3.8/site-packages/:/opt/rfcat/lib/python3.8/site-packages/

