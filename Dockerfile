FROM python:slim

RUN useradd -ms /bin/bash urlwatch
USER urlwatch

RUN pip3 install \ 
  appdirs \
  cssselect \
  jq \
  keyring \
  lxml \
  minidb \
  requests \
  pyyaml    \
  chump     \
  urlwatch  \
  yacron

ENV PATH="/home/urlwatch/.local/bin:$PATH"
VOLUME /home/urlwatch/.urlwatch
WORKDIR /home/urlwatch/.urlwatch

ENTRYPOINT [ "yacron", "-c", "/home/urlwatch/.urlwatch/cron.yaml" ]
