# ---- Build stage ----
FROM public.ecr.aws/docker/library/node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package manifests only
COPY package.json package-lock.json ./

# Install dependencies fresh inside container
RUN npm install

# Copy source code
COPY . .

# Build the React app
RUN npm run build

# ---- Runtime stage ----
FROM public.ecr.aws/docker/library/nginx:alpine

# Copy built app from builder stage to nginx html folder
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 3000 (optional, nginx default is 80)
EXPOSE 3000

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

