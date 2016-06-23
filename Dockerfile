FROM sequenceiq/hadoop-ubuntu:2.6.0
MAINTAINER Joseph Cheng<indiejoseph@gmail.com>

RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.6.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN /etc/bootstrap.sh && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hadoop fs -put $SPARK_HOME-1.6.1-bin-hadoop2.6/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV SPARK_JAR hdfs:///spark/spark-assembly-1.6.1-hadoop2.6.0.jar
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

CMD ["/etc/bootstrap.sh", "-d"]
