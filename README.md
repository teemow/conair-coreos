# Conair CoreOS Container

Run systemd, etcd, fleet and docker in a container.

## Requirements

 * Conair

## Create a CoreOS container on CoreOS

This is a short step-by-step example on how to create a CoreOS container with conair. Downloading conair and the base image is the easiest option. But you can also build those yourself. Check the conair repository for instructions.

```
# fetch the latest conair binary
wget http://conair.teemow.com/bin/conair
chmod +x ./conair
alias conair="sudo $(pwd)/conair"

# initialize host setup
conair init

# create a base image
conair pull base

# create a coreos image
git clone https://github.com/teemow/conair-coreos
cd conair-coreos
conair build coreos

# run your coreos container
conair run coreos coreos-01

# check if it is running
machinectl status coreos-01

# access your coreos (user: core, pass: coreos)
ssh core@$(conair ip coreos-01)
```

## Fleet access from outside of the container

To make it easier to play with the CoreOS container you definitely want to access fleet from the host. Assuming some of you do this on CoreOS itself this little script does everything for you. For all the others: Ofc you don't have to generate a key and run another agent if you already have one.

```
# generate a key and run an agent
ssh-keygen -P "" -f ~/.ssh/conair
eval $(ssh-agent)
ssh-add ~/.ssh/conair

# add your key to the container
echo "mkdir -p /home/core/.ssh" | conair attach coreos-01
echo "echo '$(cat ~/.ssh/conair.pub)' >> /home/core/.ssh/authorized_keys" | conair attach coreos-01
echo "chown core.core -R /home/core/.ssh" | conair attach coreos-01
echo "chmod 600 /home/core/.ssh/authorized_keys" | conair attach coreos-01

# check fleet (you should add your ssh key first)
fleetctl --tunnel $(conair ip coreos-01) list-machines
```
