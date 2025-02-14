FROM node:23-alpine3.21

# Setup nonroot user
RUN set -x && \
    addgroup nonroot && \
    adduser -G nonroot -s /bin/sh -D nonroot

# Install tools
USER nonroot
WORKDIR /home/nonroot

COPY --chown=nonroot:nonroot package.json .
COPY --chown=nonroot:nonroot --chmod=755 entrypoint.sh .
COPY --chown=nonroot:nonroot .prettierrc .

RUN set -x && \
    npm install && \
    npm cache clean --force

# Configure runtime
WORKDIR /work
ENV PATH="/home/nonroot/node_modules/.bin:${PATH}"
ENTRYPOINT ["/home/nonroot/entrypoint.sh"]
