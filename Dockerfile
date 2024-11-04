FROM node:16-stretch-slim

# Create a non-privileged user and group
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
ENV PORT 3000

# Create app directory
RUN mkdir -p /usr/src/app/trello
WORKDIR /usr/src/app/trello
COPY package.json yarn.lock ./

# Install dependencies using yarn
RUN yarn install --ignore-scripts

# Copying source files
COPY src ./src
COPY public ./public
COPY pages ./pages

# Expose the port
EXPOSE 3000

# Command to run the application
CMD ["yarn", "dev"]
