FROM nginx:alpine

# Ta bort nginx standardinnehåll
RUN rm -rf /usr/share/nginx/html/*

# Kopiera appen och konfigfiler
COPY grocy-inventory.html /usr/share/nginx/html/index.html
COPY nginx.conf           /etc/nginx/conf.d/default.conf
COPY config.js.template   /etc/nginx/config.js.template
COPY entrypoint.sh        /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
