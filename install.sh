#!/bin/sh

# Download OVS
wget http://openvswitch.org/releases/openvswitch-2.6.0.tar.gz
tar -xzvf openvswitch-2.6.0.tar.gz
mv openvswitch-2.6.0 openvswitch
cd openvswitch

# Install OVS
./boot.sh
./configure --with-linux=/lib/modules/`uname -r`/build
make && make install

# Load OVS module into kernel
cd datapath/linux
modprobe openvswitch
lsmod | grep openvswitch

# Create needed files and directories
touch /usr/local/etc/ovs-vswitchd.conf
mkdir -p /usr/local/etc/openvswitch

# Create conf.db in OVS directory
cd ../..
ovsdb-tool create /usr/local/etc/openvswitch/conf.db  vswitchd/vswitch.ovsschema
