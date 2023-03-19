FROM node:12.2.0-alpine

WORKDIR node-todo-cicd
COPY node-todo-cicd /node-todo-cicd
RUN ls -la

RUN npm install

expose 8000
CMD ["node","app.js"]
