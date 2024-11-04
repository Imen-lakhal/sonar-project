FROM node:18-bullseye-slim

RUN groupadd -r appgroup && useradd -r -g appgroup appuser
ENV PORT 3000
# Create app directory
RUN mkdir -p /usr/src/app/trello
WORKDIR /usr/src/app/trello
COPY package.json yarn.lock ./
RUN yarn install --ignore-scripts

# Copying source files
COPY src ./src
COPY public ./public
COPY pages ./pages

# Expose the port
EXPOSE 3000

CMD ["yarn", "dev"]
