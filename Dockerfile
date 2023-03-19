FROM node:12.2.0-alpine

WORKDIR app

COPY ./node-todo-cicd .

RUN npm install
expose 8000

WORKDIR app/node-todo-cicd
CMD ["node","app.js"]
