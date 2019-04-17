FROM adoptopenjdk/openjdk11:latest

# Install dependencies
RUN apt-get update && apt-get install -y sqlite3

# Create homedir
RUN mkdir -p /home/pleo

# Switch to app homedir
WORKDIR /home/pleo

# Copy over source code
COPY . /home/pleo

# When the container starts: build and test.
CMD ./gradlew build && ./gradlew test


FROM adoptopenjdk/openjdk11:latest

# Expose the app port.
EXPOSE 7000

# Create homedir
RUN mkdir /home/pleo

# Switch to app homedir
WORKDIR /home/pleo

# Copy over final jar file
COPY --from=0 /home/pleo /home/pleo

CMD ./gradlew run
