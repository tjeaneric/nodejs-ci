# Use a lightweight Node.js base image
FROM node:alpine AS base

# Set working directory
WORKDIR /app

COPY . .

# 
RUN chmod +x ./start.sh
RUN ./start.sh


CMD [ "npm", "start" ]

# # Copy package.json and package-lock.json (or yarn.lock)
# COPY package*.json ./

# # Install dependencies (adjust based on your package manager)
# RUN npm install --production

# # Copy your application code
# COPY . .

# # Expose port (adjust if your application listens on a different port)
# EXPOSE 3000

# # Define the default command to run the application (adjust as needed)
# CMD [ "npm", "start" ]
