FROM nginx:alpine

# Remove default HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy local files to the container
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# start nginx
CMD ["nginx", "-g", "daemon off;"]

