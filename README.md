# Conair CoreOS Container

Run systemd, etcd, fleet and docker in a container.

## Requirements

 * Conair

## Create a CoreOS container on CoreOS

```
wget http://conair.teemow.com/bin/conair
chmod +x ./conair
sudo ./conair init
sudo ./conair pull base
git clone https://github.com/teemow/conair-coreos
cd conair-coreos
sudo ../conair build coreos
sudo ../conair run coreos coreos-01
machinectl status coreos-01
```
