FROM node:lts-alpine3.18
EXPOSE 3000
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "start"]
