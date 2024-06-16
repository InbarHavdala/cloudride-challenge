#nginx as base image
FROM nginx:alpine

# Copy custom index.html file to nginx default public directory
COPY index.html /usr/share/nginx/html/index.html
