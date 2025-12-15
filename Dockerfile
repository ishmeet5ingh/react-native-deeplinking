FROM node:22.18.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all the source files to the working directory
COPY . .

ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

# (before `npm run build`)
RUN echo "VITE_API_URL=$VITE_API_URL" > .env

# Build the frontend (Vite will generate static files in the dist directory)
RUN npm run build

RUN npm install -g serve

CMD ["serve", "-s", "dist", "-l", "80"]

EXPOSE 80
