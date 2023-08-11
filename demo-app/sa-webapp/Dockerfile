FROM maven:3.5-jdk-8-alpine AS builder
COPY . /sa-webapp
WORKDIR /sa-webapp/
RUN mvn install


ENV SA_LOGIC_API_URL http://sa-logic:5000

FROM openjdk:8-jre-alpine
COPY --from=builder /sa-webapp/target/sentiment-analysis-web-0.0.1-SNAPSHOT.jar ./
EXPOSE 8081
CMD ["java", "-jar", "sentiment-analysis-web-0.0.1-SNAPSHOT.jar", "--sa.logic.api.url=${SA_LOGIC_API_URL}"]
