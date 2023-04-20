
FROM --platform=linux/amd64 gradle:4.3 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build 

FROM --platform=linux/amd64 openjdk:alpine
COPY --from=build /home/gradle/src/build/libs/scorekeep-api-1.0.0.jar scorekeep-api-1.0.0.jar
#ADD build/libs/scorekeep-api-1.0.0.jar scorekeep-api-1.0.0.jar
ENV AWS_REGION=""
ENV NOTIFICATION_TOPIC=""
ENV JAVA_OPTS=""
EXPOSE 5000
ENTRYPOINT [ "sh", "-c", "java -Dserver.port=5000 -jar scorekeep-api-1.0.0.jar" ]
