FROM nginx:1.23.3-alpine-slim
COPY public_html/ /usr/share/nginx/html
EXPOSE 80
