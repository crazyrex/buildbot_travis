#!/bin/sh
B=`pwd`
if [ ! -f $B/buildbot.tac ]
then
    bbtravis create-master $B

    echo
    echo buildbot is now setup on the docker host in /var/lib/buildbot
    echo
    echo You can now edit the configuration file there to sweet your needs!
    echo
    echo
fi
# wait for pg to start by trying to upgrade the master
for i in `seq 100`
do
    buildbot upgrade-master $B && break
    sleep 1
done
exec twistd -ny $B/buildbot.tac