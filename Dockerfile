FROM node:18-alpine
EXPOSE 3000
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN npm install
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

CMD ["npm", "start"]
USER 10014
