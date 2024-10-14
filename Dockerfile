# Use the official Node.js 18 image as the base image (or specify another version if needed)
FROM node:lts-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install --production

# Copy the rest of the application code to the container
COPY . .

# Expose the port on which the application will run (adjust if necessary)
EXPOSE 3000

# Specify the command to start the Node.js application
CMD ["npm", "start"]
