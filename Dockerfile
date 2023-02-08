FROM nginx:1.23.3-alpine-slim
COPY public_html/ /usr/share/nginx/html
EXPOSE 80
LABEL org.opencontainers.image.source https://github.com/yisu12/hello-2048
