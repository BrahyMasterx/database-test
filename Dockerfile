FROM node:latest

EXPOSE 3000

WORKDIR /home/choreouser

COPY . /home/choreouser/

RUN apt-get update &&\
    apt-get install -y iproute2 vim

RUN npm install

RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser
    
USER 10014
    
CMD ["npm", "start"]
