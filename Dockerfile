#FROM openjdk:latest
#FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift
FROM ibmjava
RUN apt update && apt -y upgrade && apt install -y python3 python3-pip unzip openssh-server supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /supervisord.conf
RUN mkdir /var/run/sshd
RUN echo 'root:RIOKOENIGVONDEUTSCHLAND' | chpasswd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
# **ALL** clients are welcome
#RUN echo 'auth sufficient                      pam_permit.so' > /etc/pam.d/sshd
# expose sshd and java server
EXPOSE 22532 25333
# copy stuff of py4j backend 
COPY opts.json log4j-1.2.17.jar py4j0.10.9.1-mm.jar time-series-assembly-python-2.0.5-jar-with-dependencies.jar ./app/
WORKDIR ./app
CMD ["/usr/bin/supervisord" , "-c", "/supervisord.conf"]
