FROM node:19-alpine

ENV NGINX_LOG_LEVEL=warn

RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/UTC /etc/localtime \
    && echo "UTC" > /etc/timezone \
    && apk del tzdata

RUN rm -rf /var/cache/apk/*

COPY index.html /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["nginx", "-g", "daemon off;"]
