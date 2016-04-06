FROM centos:7
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root

RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y update && yum -y install puppet-agent rubygems && gem install librarian-puppet

COPY puppet/modules/ /etc/puppetlabs/code/environments/production/modules/
COPY puppet/manifests/ /etc/puppetlabs/code/environments/production/manifests/

RUN . /etc/profile.d/puppet-agent.sh && puppet apply -v /etc/puppetlabs/code/environments/production/manifests/base.pp
