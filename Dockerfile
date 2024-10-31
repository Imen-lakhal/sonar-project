FROM node:12-stretch-slim

# Create a non-privileged user and group
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

ENV PORT 3000

# Create app directory
RUN mkdir -p /usr/src/app/trello
WORKDIR /usr/src/app/trello

# Installing dependencies
COPY package.json /usr/src/app/trello
COPY yarn.lock /usr/src/app/trello

RUN yarn install --ignore-scripts

# Copying source files
COPY src ./src
COPY public ./public
COPY pages ./pages

# Change ownership of the app directory to the non-privileged user
RUN chown -R appuser:appgroup /usr/src/app/trello
 
# Switch to the non-privileged user
USER appuser

CMD ["yarn", "dev"]

EXPOSE 3000
