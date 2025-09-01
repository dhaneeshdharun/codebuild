FROM maven:3.9.11-amazoncorretto  As builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*jar /usr/local/tomcat/webapps/app.jar
EXPOSE 8080
CMD ["catalina.sh", "run"]