FROM ubuntu:latest
MAINTAINER Adam J. McPartlan "adam.mcpartlan@nynet.co.uk"
ENV UPDATED 04-01-2017

## To Add - networking & volumes ##
## Files required - Test Config

# Install Nagios
RUN apt-get -y install nagios3

# Adding Test Config
ADD ./nagios3/* /etc/nagios3/

# Add mail config
ADD ./postfix/main.cf /etc/postfix/main.cf

# Add HTTP Radius Auth

## This is to combat the Yubikey php/refresh
ADD ./html/index.html /usr/share/nagios3/htdocs/index.html

## Add the radius servers
ADD ./apache2/apache2.conf /etc/apache2/apache2.conf

## Change the http auth type to radius
ADD ./apache2/nagios3.conf /etc/apache2/conf-available/nagios3.conf

## Send Logs to Syslog
ADD ./rsyslog/50-default.conf /etc/rsyslog.d/50-default.conf

# Expose the port
EXPOSE 80

# Restart Nagios Postfix & Apache2

CMD ["service postfix restart"]
CMD ["service apache2 restart"]
CMD ["service nagios3 restart"]
