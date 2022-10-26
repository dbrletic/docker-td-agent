FROM registry.access.redhat.com/ubi7/ubi:7.9-829
MAINTAINER Drew Brletich

# Adding in repo and key
ADD td-agent.repo /etc/yum.repos.d/td-agent.repo
ADD GPG-KEY-td-agent /etc/pki/rpm-gpg/RPM-GPG-KEY-td-agent

# Updaing repo and installing td-agent
RUN yum -y update
RUN	yum install -y td-agent

# install td-agent plugins
RUN /usr/sbin/td-agent-gem install fluent-plugin-rewrite-tag-filter fluent-plugin-s3 fluent-plugin-td --no-ri --no-rdoc -V

# add conf
ADD ./etc/fluentd /etc/fluentd

EXPOSE 24224 5140
VOLUME ["/etc/td-agent"]
ENTRYPOINT ['td-agent']
