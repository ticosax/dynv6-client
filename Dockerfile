FROM alpine:3.4
MAINTAINER Nicolas Delaby <ticosax@free.fr>
RUN mkdir -p /srv/dynv6
ENV LC_ALL="en_US.UTF-8"
ENV HOME /root
ENV PATH=/srv/dynv6/venv/bin:$PATH

RUN apk --update-cache add python3 python3-dev gcc linux-headers musl-dev\
      && python3.5 -m venv /srv/dynv6/venv \
      && pip install --no-cache-dir -U pip \
      && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \
      && find / -name '*.pyc' -delete

RUN mkdir /tmp/requirements
COPY requirements.txt /tmp/requirements.txt
COPY client.py ./client.py
RUN pip install --no-compile --no-cache-dir -r /tmp/requirements.txt
RUN apk del gcc linux-headers musl-dev
ENTRYPOINT ["python", "client.py"]
CMD ["--help"]
