FROM frkhit/docker-python:3.6
MAINTAINER frkhit "frkhit@gmail.com"

# ref from https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeChrome/Dockerfile
ARG CHROME_VERSION="google-chrome-stable"
ARG CHROME_DRIVER_VERSION
RUN apt-get update -qqy \

  # install chrome
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \

  # install chrome drive
  && if [ -z "$CHROME_DRIVER_VERSION" ]; \
  then CHROME_MAJOR_VERSION=$(google-chrome --version | sed -E "s/.* ([0-9]+)(\.[0-9]+){3}.*/\1/") \
    && CHROME_DRIVER_VERSION=$(wget --no-verbose -O - "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR_VERSION}"); \
  fi \
  && echo "Using chromedriver version: "$CHROME_DRIVER_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver \

  # install fonts
  && apt-get -qqy install ttf-wqy-zenhei ttf-wqy-microhei fonts-droid-fallback fonts-arphic-ukai fonts-arphic-uming \
  
  # install selenium
  && pip install --upgrade selenium \
  && rm -rf /root/.cache/pip/* \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
