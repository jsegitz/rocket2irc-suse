# rocket2irc-suse

Bitlbee container to connect easily to chat.suse.de using a IRC client

# How to build and start

## Docker

Clone repository, change to directory and invoke 

    docker build -t rocket2irc .

Start the container

    docker run -p 6667:6667 -d --cap-drop ALL --security-opt=no-new-privileges rocket2irc:latest

## Podman

Clone repository, change to directory and invoke 

    podman build -t rocket2irc .

Start the container

    podman run --network='host' -d --cap-drop ALL --security-opt=no-new-privileges rocket2irc:latest

# How to use it

Start the container, then connect in your IRC client to 127.0.0.1:16667

    /connect 127.0.0.1 6667

In the bitlbee channel:

    register $NICKPASSWORD
    account add eionrobb-rocketchat $USERNAME $BUGZILLPASSWORD
    acc 0 set username $USERNAME|chat.suse.de
    acc 0 on
    chat add 0 $ROCKETCHANNELNAME #$LOCALIRCALIAS
    /join #$LOCALIRCALIAS

# Known problems

* Sometimes I don't see what I write in the webinterface in the IRC client
* You need to add @ before the nick to highlight someone in rocket. With that tab completion doesn't work for me in irssi
* I see disconnects from time to time. bitlbee reconnects, but it kicks you from the channel. For irssi you can use autorejoin.pl
    /SET autorejoin_channels #rsecruity
    /SET autorejoin_delay 60

# Credit

Based on Duncans work: http://mailman.suse.de/mlarch/SuSE/research/2019/research.2019.01/msg00243.html
