FROM centos:7.3.1611

# Install java
RUN  yum update -y && \
     yum install -y java-1.8.0-openjdk-devel && \
     yum clean -y all

# Enviroment variable for java sdk
ENV JAVA_HOME="/etc/alternatives/java_sdk"

# Download apache maven
RUN curl -L -o "/opt/apache-maven-3.5.0-bin.tar.gz" http://www-us.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz

# Extract files from tar file
RUN tar xzvf /opt/apache-maven-3.5.0-bin.tar.gz -C /opt/

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

# Run application
CMD ["java", "-jar", "/build/target/test-1.0-SNAPSHOT-jar-with-dependencies.jar"]