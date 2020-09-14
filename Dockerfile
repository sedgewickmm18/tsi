#FROM openjdk:latest
FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
COPY log4j-1.2.17.jar  py4j0.10.9.jar  time-series-assembly-python-2.0.5-jar-with-dependencies.jar ./app/
WORKDIR ./app
CMD ["java", "-classpath", "./py4j0.10.9.jar:./log4j-1.2.17.jar:./time-series-assembly-python-2.0.5-jar-with-dependencies.jar", "py4j.GatewayServer", "25333"]
