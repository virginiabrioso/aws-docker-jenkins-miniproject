FROM node:12.2.0-alpine

WORKDIR app
COPY ./node-todo-cicd/* .

RUN npm install

expose 8000
CMD ["node","app.js"]
