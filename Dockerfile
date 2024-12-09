# Stage 1: Build the React App
FROM node:20.11.1-alpine3.19 AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Set PATH to include node_modules binaries
ENV PATH /app/node_modules/.bin:$PATH

# Copy all other project files and run the build process
COPY . .
RUN npm run build

# Stage 2: Serve the built app with NGINX
FROM nginx:1.25.4-alpine3.18

# Copy custom NGINX configuration
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built React app from the build stage
COPY --from=build /app/dist /var/www/html/

# Expose port 3005
EXPOSE 3005

# Start NGINX server
ENTRYPOINT ["nginx", "-g", "daemon off;"]