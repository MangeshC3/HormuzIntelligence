FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

# Make nginx listen on 8080 instead of 80
RUN sed -i 's/listen\s*80;/listen 8080;/g' /etc/nginx/conf.d/default.conf

EXPOSE 8080
