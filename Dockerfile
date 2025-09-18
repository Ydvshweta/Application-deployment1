FROM public.ecr.aws/docker/library/node:18-alpine AS builder
WORKDIR /app

COPY package.json package-lock.json ./

RUN npm cache clean --force
RUN npm install
RUN npm rebuild

# Debug: List .bin contents to verify react-scripts presence
RUN ls -la node_modules/.bin

COPY . .
RUN npm run build

FROM public.ecr.aws/docker/library/nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

