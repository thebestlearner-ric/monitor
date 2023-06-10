FROM alpine:3.15

# Set the working directory inside the container
WORKDIR /app

RUN apt-get update && apt-get install -y curl

# Copy the script files to the container
COPY exporter/export.sh . /app/
COPY files/website.csv . /app/files/

# Make the script executable
RUN chmod +x /app/export.sh

# Set the file path to record the results
ENV RESULTS_FILE="/app/results.log"

CMD while true; do /app/export.sh >> /app/results.log 2>&1; sleep 600; done
