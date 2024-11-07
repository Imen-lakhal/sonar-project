FROM node:18-bullseye-slim

# Create a non-root user without giving modification access to sensitive directories
RUN groupadd -r appuser && useradd -r -g appuser appuser

ENV PORT 3000

RUN mkdir -p /usr/src/app/trello
WORKDIR /usr/src/app/trello

COPY package.json yarn.lock ./
RUN yarn install --ignore-scripts --production
RUN yarn add --dev typescript
COPY src ./src
COPY public ./public
COPY pages ./pages

EXPOSE 3000



# Switch to non-root user only for running the application
USER appuser

# Run the application
CMD ["yarn", "dev"]
