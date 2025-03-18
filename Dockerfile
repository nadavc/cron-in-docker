FROM eclipse-temurin:17-jdk-focal

# Download Superchronic to manage cron without needing root access
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.33/supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=71b0d58cc53f6bd72cf2f293e09e294b79c666d8 \
    SUPERCRONIC=supercronic-linux-amd64

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# Create the moderne user
RUN useradd -u 8877 moderne
USER moderne
WORKDIR /home/moderne/

# Copy entrypoint.sh and crontab into the container 
COPY --chown=moderne:moderne ./files .
RUN chmod +x ./entrypoint.sh

# Runs superchronic in the background and launches another process
ENTRYPOINT ["./entrypoint.sh"]
