# Use an official Node.js runtime as the base image
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of your application code to the container
COPY . .

# Build the Angular application
RUN npm run build -- --prod

# Use an official Nginx image as the final base image for serving the Angular app
FROM nginx:alpine

# Copy the Angular build files to the Nginx web server directory
COPY --from=build /app/dist/* /usr/share/nginx/html/

# Expose port 80 (the default HTTP port)
EXPOSE 80

# Start the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
