FROM opensuse:leap
LABEL maintainer="Johannes Segitz <jsegitz@suse.de>"
LABEL name="BitlBee container"

ADD https://download.opensuse.org/repositories/network:/pidgin/openSUSE_Leap_15.0/repodata/repomd.xml.key /tmp/repomd_network.xml.key
ADD http://download.suse.de/ibs/SUSE:/CA/openSUSE_Leap_15.0/repodata/repomd.xml.key /tmp/repomd_ca.xml.key

RUN rpm --import /tmp/repomd_*.xml.key && \
    rm /tmp/repomd_*.xml.key && \
    zypper addrepo https://download.opensuse.org/repositories/network:/pidgin/openSUSE_Leap_15.0/network:pidgin.repo  && \
    zypper addrepo http://download.suse.de/ibs/SUSE:/CA/openSUSE_Leap_15.0/SUSE:CA.repo  && \
    zypper ref && \
    zypper install -y bitlbee libpurple-plugin-rocketchat ca-certificates-suse && \
    /usr/bin/mkdir -p /run/bitlbee && \
    /usr/bin/chown bitlbee.bitlbee /run/bitlbee
    
ADD bitlbee.conf /etc/bitlbee/bitlbee.conf

VOLUME ["/var/lib/bitlbee"]
EXPOSE 6667
USER bitlbee
CMD ["/usr/sbin/bitlbee", "-c", "/etc/bitlbee/bitlbee.conf", "-n", "-v"]
