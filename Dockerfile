# Use an official Node runtime as a parent image
FROM node:14-alpine AS build
WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application and build the app
COPY . .
RUN npm run build

# Use a lighter weight web server to serve the app
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]