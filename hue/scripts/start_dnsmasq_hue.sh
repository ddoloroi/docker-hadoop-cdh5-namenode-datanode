#!/bin/bash

#Update clustername
/etc/scripts/cluster_name.sh

#Start serf
/etc/serf/start-ssh-serf.sh

#Join node to cluster
/etc/serf/handlers/member-join

# Start HUE
/hue/build/env/bin/python2.7 build/env/bin/hue runserver_plus 0.0.0.0:8888

