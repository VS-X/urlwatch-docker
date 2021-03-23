FROM python:slim

RUN apt-get update \ 
  && apt-get install -y --no-install-recommends python3-cryptography \
  python3-appdirs \ 
  python-cssselect \
  python-keyring \ 
  python-lxml \
  python3-minidb \
  python3-requests  \
  && rm -rf /var/cache/apt/lists

RUN useradd -ms /bin/bash urlwatch
USER urlwatch

RUN pip3 install \ 
  pyyaml    \
  chump     \
  urlwatch  \
  yacron

ENV PATH="/home/urlwatch/.local/bin:$PATH"
VOLUME /home/urlwatch/.urlwatch
WORKDIR /home/urlwatch/.urlwatch

ENTRYPOINT [ "yacron", "-c", "/home/urlwatch/.urlwatch/cron.yaml" ]
