# Build Stage -----------

# Use existing java image
FROM java:latest AS build

ARG MAVEN_ARCHIVE_URL="http://www-us.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz"

# Download apache maven
RUN curl -L -o "/opt/apache-maven-3.5.0-bin.tar.gz" "${MAVEN_ARCHIVE_URL}"

# Extract files from tar file
RUN tar xzvf /opt/apache-maven-3.5.0-bin.tar.gz -C /opt

ARG MAVEN_ARCHIVE_SHA256="beb91419245395bd69a4a6edad5ca3ec1a8b64e41457672dc687c173a495f034"

# Validate checksum
RUN echo "${MAVEN_ARCHIVE_SHA256} /opt/apache-maven-3.5.0-bin.tar.gz" | sha256sum -c -

# Remove tar file
RUN rm -f /opt/apache-maven-3.5.0-bin.tar.gz

# Create symlink for maven
RUN ln -s /opt/apache-maven-3.5.0 /opt/maven

# Enviroment variable for maven commands
ENV PATH="${PATH}:/opt/maven/bin"

# Create folder for java project
RUN mkdir /build

# Copy current directory to build folder in container
COPY . /build/

# Set working directory to /build
WORKDIR /build

# Build application
RUN mvn clean install



# Execution Stage -----------
FROM java

COPY --from=build /build/target/test-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/

# Run application
CMD ["java", "-jar", "/opt/test-1.0-SNAPSHOT-jar-with-dependencies.jar"]
