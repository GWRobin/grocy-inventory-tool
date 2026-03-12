FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY grocy-inventory.html /usr/share/nginx/html/index.html

# nginx:alpine kör automatiskt envsubst på filer i /etc/nginx/templates/
# och sparar resultatet i /etc/nginx/conf.d/ vid containerstart.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80
