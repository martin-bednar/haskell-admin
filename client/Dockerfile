FROM node:14
EXPOSE 5000
COPY . /build
WORKDIR /build
RUN npm install
RUN npm run build
CMD npm run start