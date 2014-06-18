FROM dockerfile/java
ENV HOME /root
WORKDIR /root

RUN add-apt-repository ppa:chris-lea/zeromq
RUN apt-get update
RUN apt-get install -y libzmq3-dbg libzmq3-dev libzmq3 wget python-pip python-dev build-essential

RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.1.tar.gz
RUN tar zxvf logstash-1.4.1.tar.gz
ADD logstash.conf /root/logstash.conf
RUN pip install elasticsearch-curator

#elasticsearch
EXPOSE 9200 9292 514 4712 7007 2120 12201

ADD start.sh /root/start.sh
RUN chmod 755 start.sh
CMD /root/start.sh