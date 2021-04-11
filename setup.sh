#!/bin/sh

# python setuptools must be installed to run. This can be installed as:
# sudo apt-get install -y python-setuptools
cd ripl && python3 setup.py install
cd ../
cd riplpox && python3 setup.py install
cd ../
cd jellyfish && python3 setup.py install
