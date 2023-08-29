FROM node:latest

WORKDIR /home/choreouser

COPY . /home/choreouser/

RUN npm install

RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser
    
CMD ["npm", "start"]

USER 10014
