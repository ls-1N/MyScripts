#!/bin/bash
#version 0.3

#Run a specific benchmark after installing all prerequisites via apt.

sudo apt-get install -y php-cli php-xml && MONITOR=all phoronix-test-suite benchmark 1704241-KH-CRAFTYMON95