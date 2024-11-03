FROM node:16-slim

# Set the environment variable for the port
ENV PORT 3000

# Create app directory
RUN mkdir -p /usr/src/app/trello
WORKDIR /usr/src/app/trello

# Installing dependencies
COPY package.json yarn.lock ./

# Install dependencies using yarn
RUN yarn install

# Copying source files
COPY . .

# Expose the port
EXPOSE 3000

# Command to run the application
CMD ["yarn", "dev"]
