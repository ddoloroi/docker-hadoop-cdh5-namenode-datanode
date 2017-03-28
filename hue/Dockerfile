# Creates a base ubuntu image with serf and dnsmasq
FROM gethue/hue

# Install dnsmasq
RUN apt-get install -y dnsmasq
RUN apt-get install -y unzip
RUN apt-get install -y curl

# dnsmasq configuration
COPY dnsmasq/* /etc/
COPY scripts /etc/scripts

RUN mkdir /etc/serf

# install serf
RUN curl -Lso serf.zip https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip && \
unzip serf.zip -d /bin && \
rm serf.zip
# configure serf
ENV SERF_CONFIG_DIR /etc/serf
COPY serf/* $SERF_CONFIG_DIR/
COPY handlers $SERF_CONFIG_DIR/handlers


RUN chmod +x  $SERF_CONFIG_DIR/event-router.sh $SERF_CONFIG_DIR/start-serf-agent.sh /etc/scripts/* /etc/serf/start-ssh-serf.sh $SERF_CONFIG_DIR/handlers/*

EXPOSE 22 7373 7946 8888

CMD '/etc/scripts/start_dnsmasq_hue.sh'; 'bash'
