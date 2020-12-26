FROM nginx:1.19.6-alpine

RUN rm -f /etc/nginx/conf.d/*

COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/bike_app.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf