# Use an official Node.js runtime as a parent image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY backend/package.json ./
COPY backend/package-lock.json ./

# Install dependencies
RUN npm install
ENV NODE_ENV=production
# Copy the rest of the application code to the working directory
COPY . .

# Build the application
EXPOSE 4000

# Start the application
CMD ["node", "server.js"]
