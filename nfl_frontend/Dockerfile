FROM node:14-alpine


RUN mkdir /app
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install --silent

COPY . /app

CMD ["npm", "start", "--logevel=error"]
