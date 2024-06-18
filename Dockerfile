#nginx as base image
FROM nginx:alpine

# remove the nginx defult
RUN rm /usr/share/nginx/html/index.html

#Copy custom index.html file to nginx default public directory
COPY index.html /usr/share/nginx/html/

EXPOSE 80
