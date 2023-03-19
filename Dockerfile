FROM node:12.2.0-alpine

WORKDIR app
COPY node-todo-cicd/ /app
RUN ls -la

RUN npm install

expose 8000
CMD ["node","app.js"]
