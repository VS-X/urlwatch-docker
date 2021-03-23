FROM python:slim

# all the libraries to run Pyppeteer (headless Chromium)
RUN apt-get update \ 
  && apt-get install -y --no-install-recommends libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libcairo2 \
  libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
  libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxss1 libxtst6 libappindicator1 libnss3 libasound2 libatk1.0-0 libc6 \
  python3-cryptography \
  python3-appdirs \ 
  python-cssselect \
  python-keyring \ 
  python-lxml \
  python3-minidb \
  python3-requests  \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash urlwatch
USER urlwatch

RUN pip3 install \ 
  pyyaml    \
  chump     \
  urlwatch  \
  yacron    \
  pyppeteer

ENV PATH="/home/urlwatch/.local/bin:$PATH"
VOLUME /home/urlwatch/.urlwatch
WORKDIR /home/urlwatch/.urlwatch

ENTRYPOINT [ "yacron", "-c", "/home/urlwatch/.urlwatch/cron.yaml" ]
