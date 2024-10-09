
FROM node:18 AS builder


WORKDIR /app


COPY package*.json ./


RUN npm install --only=production


COPY . .




# Ejecución
FROM node:18-alpine AS runner


WORKDIR /app


COPY --from=builder /app/node_modules ./node_modules


COPY --from=builder /app .


EXPOSE 3000


CMD ["node", "index.js"]

