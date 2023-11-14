# Use the official Node.js Alpine image as a base
FROM node:14-alpine as builder
# Set the working directory in the container
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
# Install app dependencies
RUN npm install
# Copy the rest of the application code to the working directory
COPY . .
# Set The ENV
ENV PORT 3000
ENV AMQP_URL amqp://localhost:5672
# Expose the port the app runs on
EXPOSE 3000
# Define the command to run your application
CMD ["npm", "start"]
