FROM ubuntu:14.04 
MAINTAINER Frank Wang "eternnoir@gmail.com"

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN apt-get clean

ENV VERSION 3.4.6

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
        && mv /opt/zookeeper-$VERSION /opt/zookeeper \
        && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
        && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
EXPOSE 2181 2888 3888
WORKDIR /opt/zookeeper
VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]
ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
