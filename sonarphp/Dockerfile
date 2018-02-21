FROM openjdk:alpine

RUN apk add --no-cache curl
RUN apk add --no-cache ttf-dejavu git
RUN apk add --no-cache gnupg unzip
RUN apk add --no-cache libressl wget
RUN apk add --no-cache su-exec
RUN apk add --no-cache bash

# Http port
EXPOSE 9000

RUN addgroup -S sonarqube && adduser -S -G sonarqube sonarqube

WORKDIR /data

ENV SONARQUBE_VERSION 4.5.4
ENV SONARQUBE_HOME /data/sonar
ENV SONAR_PLUGIN_HOME $SONARQUBE_HOME/extensions/plugins

RUN echo 'http://mirror.yandex.ru/mirrors/alpine/v3.7/main' > /etc/apk/repositories && \
    curl -L -o sonarqube.zip https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONARQUBE_VERSION.zip && \
    unzip sonarqube.zip && \
    mv sonarqube-$SONARQUBE_VERSION sonar
RUN sed -i 's|#wrapper.java.additional.6=-server|wrapper.java.additional.6=-server|g' /data/sonar/conf/wrapper.conf && \
    sed -i 's|#sonar.jdbc.password=sonar|sonar.jdbc.password=sonar|g' /data/sonar/conf/sonar.properties && \
    sed -i 's|#sonar.jdbc.user=sonar|sonar.jdbc.user=sonar|g' /data/sonar/conf/sonar.properties && \
    sed -i 's|sonar.jdbc.url=jdbc:h2|#sonar.jdbc.url=jdbc:h2|g' /data/sonar/conf/sonar.properties && \
    sed -i 's|#sonar.jdbc.url=jdbc:postgresql://localhost/sonar|sonar.jdbc.url=jdbc:postgresql://db:5432/sonar|g' /data/sonar/conf/sonar.properties && \
    echo 'sonar.web.javaOpts=-server' >> /data/sonar/conf/sonar.properties
RUN rm sonarqube.zip

RUN set -x && curl -o ${SONAR_PLUGIN_HOME}/sonar-java-plugin-3.10.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-3.10.jar

RUN set -x && curl -o ${SONAR_PLUGIN_HOME}/sonar-php-plugin-2.8.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-php-plugin/sonar-php-plugin-2.8.jar

RUN set -x && curl -o ${SONAR_PLUGIN_HOME}/sonar-javascript-plugin-2.8.jar -fSL http://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-2.8.jar

RUN set -x && curl -o ${SONAR_PLUGIN_HOME}/sonar-pdfreport-plugin-1.4.jar -fSL http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-pdfreport-plugin/1.4/sonar-pdfreport-plugin-1.4.jar

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]
