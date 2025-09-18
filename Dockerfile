# ---- Build stage ----
FROM public.ecr.aws/docker/library/node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# ---- Runtime stage ----
FROM public.ecr.aws/docker/library/nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]

