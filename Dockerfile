FROM dockerfile/java
MAINTAINER neil@cazcade.com
ENV HOME /root
WORKDIR /root

RUN echo deb http://apt.newrelic.com/debian/ newrelic non-free >> /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN add-apt-repository ppa:chris-lea/zeromq
RUN apt-get update
RUN apt-get install -y libzmq3-dbg libzmq3-dev libzmq3 wget python-pip python-dev build-essential newrelic-sysmond
RUN nrsysmond-config --set license_key=7fab41848a24a778e9dc6868cf94fb17fc5ce7a8
RUN /etc/init.d/newrelic-sysmond start
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz
RUN tar zxvf logstash-1.4.1.tar.gz
ADD logstash.conf /root/logstash.conf
RUN pip install elasticsearch-curator

#elasticsearch
EXPOSE 9200 9292 514 4712 7007 2120 12201

ADD start.sh /root/start.sh
RUN chmod 755 start.sh
CMD /root/start.sh 1