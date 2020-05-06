FROM centos
MAINTAINER kusari-k

EXPOSE 443
EXPOSE 1194/udp
ARG root_password="password"

RUN yum -y install https://as-repository.openvpn.net/as-repo-centos8.rpm
RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y rsyslog openvpn-as passwd&& \
	dnf clean all

RUN echo $root_password|passwd --stdin openvpn

#/etc/rsyslog.conf
RUN sed -i -e "/imjournal/ s/^/#/" \
	-e "s/off/on/" /etc/rsyslog.conf

COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
