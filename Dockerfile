FROM lambci/lambda:build-ruby2.7
RUN yum update -y
RUN printf '[pgdg10] \nname=PostgreSQL 10 for RHEL/CentOS 7 - x86_64 \nbaseurl=https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64 \nenabled=1 \ngpgcheck=0' > /etc/yum.repos.d/pgdg.repo
RUN yum makecache
RUN yum install -y postgresql10 postgresql10-server postgresql10-devel
RUN gem update bundler
CMD "/bin/bash"