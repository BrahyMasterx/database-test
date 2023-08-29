FROM node:lts-alpine3.18

WORKDIR /app

COPY . .

RUN npm install

RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser
    
USER 10014

CMD ["npm", "start"]
