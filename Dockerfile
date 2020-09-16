#FROM openjdk:latest
#FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
FROM ibmjava
RUN apt update && apt -y upgrade && apt install -y python3 python3-pip unzip
#COPY tspy-2.0.5.0.tar.gz timeseries-insights-master.zip log4j-1.2.17.jar py4j0.10.9.1.jar time-series-assembly-python-2.0.5-jar-with-dependencies.jar ./app/
COPY opts.json log4j-1.2.17.jar py4j0.10.9.1-mm.jar time-series-assembly-python-2.0.5-jar-with-dependencies.jar ./app/
WORKDIR ./app
#RUN pip3 install pandas py4j
#RUN pip3 install tspy-2.0.5.0.tar.gz
CMD ["java", "-classpath", "./py4j0.10.9.1-mm.jar:./log4j-1.2.17.jar:./time-series-assembly-python-2.0.5-jar-with-dependencies.jar", "py4j.GatewayServer", "opts.json"]
