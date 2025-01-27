FROM node:alpine as development

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:alpine

WORKDIR /app

COPY --from=development /app/dist ./dist

COPY package*.json ./

RUN npm install --only=production

EXPOSE 3000

CMD [ "node", "dist/main"]

