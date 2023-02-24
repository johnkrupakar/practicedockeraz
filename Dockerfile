FROM node:slim
WORKDIR /app
COPY . /app
RUN npm install
RUN npm install express
EXPOSE 3000
CMD node index.js