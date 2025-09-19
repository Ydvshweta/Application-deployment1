FROM public.ecr.aws/docker/library/node:18-alpine AS builder
WORKDIR /app


# Copy all files and build the app
COPY . .


# Install a lightweight static server to serve the build
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "dist", "-l", "3000"]

