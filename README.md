Two-Tier Flask App with MySQL Docker Setup

This is a simple two-tier Flask app with a MySQL database and Nginx frontend. Users can submit messages, which are stored in the database and displayed on the frontend.

Prerequisites

Docker

Docker Compose

Git (optional, for cloning the repository)

Setup

Clone this repository:

git clone https://github.com/NishantYadav9602/two-tier-flask-app.git
cd two-tier-flask-app


(Optional) Create a .env file for MySQL credentials:

touch .env


Example .env:

MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=devops
MYSQL_USER=admin
MYSQL_PASSWORD=admin

Docker Compose Usage

Start the application using Docker Compose:

docker-compose up -d --build


Frontend: http://localhost:3001

Backend: http://localhost:3000

Check running containers:

docker ps


Stop and remove containers:

docker-compose down

Docker Hub Images

You can also run the app using prebuilt images on Docker Hub:

Backend: nishantyadav27/flask-backend:latest

Frontend: nishantyadav27/frontend:latest

Update your docker-compose.yml to use these images:

services:
  backend:
    image: nishantyadav27/flask-backend:latest
    ports:
      - "3000:5000"
    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASSWORD: root
      MYSQL_DB: devops
    depends_on:
      - mysql

  frontend:
    image: nishantyadav27/frontend:latest
    ports:
      - "3001:80"
    depends_on:
      - backend

Running Without Docker Compose

Build backend image:

docker build -t nishantyadav27/flask-backend:latest .


Build frontend image:

docker build -t nishantyadav27/frontend:latest -f Dockerfile.frontend .


Create a Docker network:

docker network create twotier


Run MySQL container:

docker run -d \
    --name mysql \
    -v mysql-data:/var/lib/mysql \
    --network=twotier \
    -e MYSQL_DATABASE=devops \
    -e MYSQL_ROOT_PASSWORD=root \
    -p 3306:3306 \
    mysql:5.7


Run backend container:

docker run -d \
    --name flask-backend \
    --network=twotier \
    -e MYSQL_HOST=mysql \
    -e MYSQL_USER=root \
    -e MYSQL_PASSWORD=root \
    -e MYSQL_DB=devops \
    -p 3000:5000 \
    nishantyadav27/flask-backend:latest


Run frontend container:

docker run -d \
    --name nginx-frontend \
    --network=twotier \
    -p 3001:80 \
    nishantyadav27/frontend:latest

Notes

Frontend runs on port 3001, backend on 3000.

Make sure your EC2 Security Group allows inbound traffic for these ports.

For production, always secure MySQL credentials and sanitize inputs.

To debug, check logs:

docker logs flask-backend
docker logs nginx-frontend
docker logs mysql
