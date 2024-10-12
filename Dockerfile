#DOCKERFILE
FROM node:14-alpine AS builder
RUN npm install -g @redocly/cli
WORKDIR /app
COPY src/openAPI.yaml .
RUN redocly build-docs openAPI.yaml --output index.html
FROM nginx:alpine
COPY --from=builder /app/index.html /usr/share/nginx/html
EXPOSE 80