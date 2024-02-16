FROM httpd:latest
RUN apt-get update
RUN apt-get install wget 9base libtext-markdown-perl imagemagick -y
RUN wget --no-check-certificate http://werc.cat-v.org/download/werc-1.5.0.tar.gz -O /tmp/werc.tgz && tar zxvf /tmp/werc.tgz -C /var/ && mv /var/werc* /var/werc
COPY ./werc-apache.conf /usr/local/apache2/conf/httpd.conf
RUN sed -i 's#$PLAN9#/usr/lib/plan9#g' /var/werc/etc/initrc
RUN export HOSTNAME=testdocker.nfalcone.net && mv /var/werc/sites/werc.cat-v.org /var/werc/sites/$HOSTNAME
ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $PATH:$HTTPD_PREFIX/bin
RUN ln -s /usr/lib/plan9 /usr/local/plan9
CMD ["httpd-foreground"]

