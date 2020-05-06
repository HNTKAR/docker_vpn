FROM centos
MAINTAINER kusari-k

EXPOSE 443 1701 5555
EXPOSE 500/udp 1194/udp 4500/udp

ARG root_password="password"
ARG version="4.34-9745"
ARG version_date="2020.04.05"

RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y rsyslog tar wget passwd gcc chkconfig libnsl openssl make && \
	dnf clean all

RUN wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v${version}-beta/softether-vpnserver-v${version}-beta-${version_date}-linux-x64-64bit.tar.gz && \
	mv softether-* softether.tar.gz && \
	tar xzvf softether.tar.gz && \
	cd vpnserver && \
	make i_read_and_agree_the_license_agreement && \
	cd .. && \
	mv vpnserver /usr/local && \
	cd /usr/local/vpnserver/ && \
	chmod 600 * && \
	chmod 700 vpncmd && \
	chmod 700 vpnserver
	


#syslog setting
RUN sed -i -e "/imjournal/ s/^/#/" \
	-e "s/off/on/" /etc/rsyslog.conf

COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
