# cSpell:ignore starsoft
FROM node:18-alpine

WORKDIR /app/starsoft-backend

COPY package*.json tsconfig.json ./


RUN npm install -g @nestjs/cli

RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["node", "dist/main"]