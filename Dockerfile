# Stage 1 - Build React App
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2 - Serve with 'serve'
FROM node:18
RUN npm install -g serve
WORKDIR /app
COPY --from=builder /app/build ./build
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "tcp://0.0.0.0:3000"]
