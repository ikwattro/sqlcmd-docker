# ----------------------------------------------------------------------------
# This Dockerfile is provided as-is, without warranties or conditions of any kind.
# You may use, modify, and distribute this file in compliance with open-source
# software principles, and you are encouraged to improve it.
# ----------------------------------------------------------------------------
FROM debian:bullseye-slim

LABEL maintainer="Christophe Willemsen <willemsen.christophe@gmail.com>"
LABEL description="SQLCMD tool installed on a lightweight Debian slim image"
LABEL version="bullseye-slim"

# Install dependencies and SQL Server tools in one layer to reduce size
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg2 apt-transport-https ca-certificates wget && \
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    wget -qO- https://packages.microsoft.com/config/debian/10/prod.list | tee /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y --no-install-recommends sqlcmd && \
    apt-get purge -y --auto-remove wget gnupg2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["sqlcmd", "-?"]