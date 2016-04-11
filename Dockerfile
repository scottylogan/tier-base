FROM centos:7
MAINTAINER Scotty Logan <swl@stanford.edu>

USER root

# install the YUM repo for the latest PuppetLabs packages
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# ensure we have the latest packages installed
# then install git, the puppet agent, and rubygems via yum
# and librarian-puppet via gem
RUN yum -y update && \
    yum -y install git puppet-agent rubygems && \
    gem install librarian-puppet

COPY Puppetfile /etc/puppetlabs/code
COPY default.pp /etc/puppetlabs/code/environments/production/manifests/

WORKDIR /etc/puppetlabs/code
RUN librarian-puppet install --verbose --clean

WORKDIR /
RUN . /etc/profile.d/puppet-agent.sh && \
  puppet apply -v /etc/puppetlabs/code/environments/production/manifests/default.pp
