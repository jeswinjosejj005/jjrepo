FROM tomcat
RUN rm -fr /usr/local/tomcat/webapps/ROOT
COPY target/webapp.war /usr/local/tomcat/webapps/ROOT.war
