FROM centos
MAINTAINER kusari-k

EXPOSE 943
EXPOSE 1194/udp
ARG root_password="password"

RUN yum -y install https://as-repository.openvpn.net/as-repo-centos8.rpm
RUN sed -i -e "\$afastestmirror=true" /etc/dnf/dnf.conf
RUN dnf update -y && \
	dnf install -y rsyslog openvpn-as passwd&& \
	dnf clean all

RUN echo $root_password|passwd --stdin openvpn

#syslog setting
RUN sed -i -e "/imjournal/ s/^/#/" \
	-e "s/off/on/" /etc/rsyslog.conf

#PAM setting
RUN sed -i -e "/pam_nologin/ s/^/#/" /etc/pam.d/openvpnas

COPY run.sh  /usr/local/bin/
RUN  chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
