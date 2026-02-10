
#build stage for frontend application
FROM node:18-alpine AS builder

#set working directory
WORKDIR /app

#copy package files to the working directory
COPY frontend/package.json ./
COPY frontend/package-lock.json ./

# install dependencies
RUN npm install 

#copy the rest of the application code to the working directory
COPY frontend/ .
#build the application
RUN npm run build

#production stage for serving the built application
FROM nginx:alpine AS production

#copy the built application from the builder stage to the nginx html directory
COPY --from=builder /app/dist /usr/share/nginx/html

COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

#expose port 80 for nginx
EXPOSE 80
#start nginx server
CMD ["nginx", "-g", "daemon off;"]
