# TOMATO - Food Ordering Website

This repository hosts the source code for TOMATO, a dynamic food ordering website built with the MERN Stack. It offers a user-friendly platform for seamless online food ordering.

## Demo

- User Panel: [https://www.dealgo.food/](https://www.dealgo.food/)
- Admin Panel: [https://www.dealgo.food/](https://www.dealgo.food/)

## Features

- User Panel
- Admin Panel
- JWT Authentication
- Password Hashing with Bcrypt
- Stripe Payment Integration
- Login/Signup
- Logout
- Add to Cart
- Place Order
- Order Management
- Products Management
- Filter Food Products
- Login/Signup
- Authenticated APIs
- REST APIs
- Role-Based Identification
- Beautiful Alerts

## Screenshots

![Hero](https://i.ibb.co/59cwY75/food-hero.png)
- Hero Section

![Products](https://i.ibb.co/JnNQPyQ/food-products.png)
- Products Section

![Cart](https://i.ibb.co/t2LrQ8p/food-cart.png)
- Cart Page

![Login](https://i.ibb.co/s6PgwkZ/food-login.png)
- Login Popup

## Run Locally

Clone the project

```bash
    git clone https://github.com/Hyysuresh/full-stack-food-delivery.git
```
Go to the project directory

```bash
    cd Food-Delivery
```
Install dependencies (frontend)

```bash
    cd frontend
    docker build frontned .
```
Install dependencies (admin)

```bash
    cd admin
    docker admin backend .
```
Install dependencies (backend)

```bash
    cd backend
    docker build backend .
```
Setup Environment Vaiables

```Make .env file in "backend" folder and store environment Variables
  JWT_SECRET=YOUR_SECRET_TEXT
  SALT=YOUR_SALT_VALUE
  MONGO_URL=YOUR_DATABASE_URL
  STRIPE_SECRET_KEY=YOUR_KEY
 ```

Setup the Frontend and Backend URL
   - App.jsx in Admin folder
      const url = YOUR_BACKEND_URL
     
  - StoreContext.js in Frontend folder
      const url = YOUR_BACKEND_URL

  - orderController in Backend folder
      const frontend_url = YOUR_FRONTEND_URL 

Start the Backend server

```bash
    nodemon server.js
```

Start the Frontend server

```bash
    npm start
```

Start the Backend server

```bash
    npm start
```
## Tech Stack
* [React](https://reactjs.org/)
* [Node.js](https://nodejs.org/en)
* [Express.js](https://expressjs.com/)
* [Mongodb](https://www.mongodb.com/)
* [Stripe](https://stripe.com/)
* [JWT-Authentication](https://jwt.io/introduction)
* [Multer](https://www.npmjs.com/package/multer)

## Deployment

### Docker Setup Guide

This guide will help you run Tometo using Docker containers. No local Node.js or MongoDB installation required!

### Prerequisites

1. Install [Docker](https://docs.docker.com/get-docker/) on your machine
2. Basic understanding of terminal/command line

### Step 1: Environment Setup

1. Create a file named `.env.local` in the root directory with the following content:
```env
# Database Configuration
MONGODB_URI=mongodb://easyshop-mongodb:27017/easyshop
NEXTAUTH_SECRET=your-nextauth-secret-key  # Generate this using the command below
JWT_SECRET=your-jwt-secret-key  # Generate this using the command below
```

> [!IMPORTANT]
> When deploying to EC2, make sure to replace `your-ec2-ip` with your actual EC2 instance's public IP address.

To generate secure secret keys, use these commands in your terminal:
```bash
# For NEXTAUTH_SECRET
openssl rand -base64 32

# For JWT_SECRET
openssl rand -hex 32
```

### Step 2: Running the Application

You have two options to run the application:

#### Option 1: Using Docker Compose (Recommended)

This is the easiest way to run the application. All services will be started in the correct order with proper dependencies.

```bash
# Start all services
docker compose up -d

# View logs
docker compose logs -f

# Stop all services
docker compose down
```

#### Option 2: Manual Docker Commands

If you prefer more control, you can run each service manually:

1. Create a Docker network:
```bash
docker create network food-delivery-network
```

2. Start MongoDB:
```bash
docker run -d \
  --name food-delivery-mongodb \
  --network food-delivery-network \
  -p 27017:27017 \
  -v mongodb_data:/data/db \
  mongo:latest
```

3. Build the frontend application:
```bash
docker build -t frontend-food-delivery .
```

4. Build the backend application:
```bash
docker build -t backend-food-delivery .
```
5. Build the admin application:
```bash
docker build -t admin-food-delivery .
```
6. Start the frontend application:
```bash
docker run -d \
  --name frontend-food-delivery \
  --network food-delivery-network \
  -p 80:80 \
  --env-file .env.local \
  frontend-food-delivery:latest
```

7. Start the backend application:
```bash
docker run -d \
  --name backend-food-delivery \
  --network food-delivery-network \
  -p 4000:4000 \
  --env-file .env.local \
  backend-food-delivery:latest
```

8. Start the admin application:
```bash
docker run -d \
  --name admin-food-delivery \
  --network food-delivery-network \
  -p 4000:4000 \
  --env-file .env.local \
  admin-food-delivery:latest
```
### Accessing the Application

1. Open your web browser
2. Visit [http://localhost:80](http://localhost:80)
3. Visit [http://localhost:5173](http://localhost:5173)
4. You should see the Tomato homepage!
5. you should see the Tomato admin page
### Useful Docker Commands

```bash
# View running containers
docker ps

# View container logs
docker logs 

# Stop containers
docker stop food-delivery food-delivery-mongodb

# Remove containers
docker rm food-delivery food-delivery-mongodb

# Remove network
docker network rm food-delivery-network
```

### Troubleshooting

1. If you can't connect to MongoDB:
   - Make sure the MongoDB container is running: `docker ps`
   - Check MongoDB logs: `docker logs food-delivery-mongodb`
   - Verify network connection: `docker network inspect food-delivery-network`
2. If the application isn't accessible:
   - Check if the container is running: `docker ps`
   - View application logs: `docker logs food-delivery`
   - Make sure port 3000 isn't being used by another application
## 🧪 Testing

> [!NOTE]
> Coming soon: Unit tests and E2E tests with Jest and Cypress

## 🔧 Troubleshooting

### Build Errors

1. **Dynamic Server Usage Warnings**
```bash
Error: Dynamic server usage: Page couldn't be rendered statically
```
**Solution**: This is expected behavior for dynamic routes and API endpoints. These warnings appear during build but won't affect the application's functionality.

2. **MongoDB Connection Issues**
```bash
Error: MongoDB connection failed
```
**Solution**: 
- Ensure MongoDB is running locally
- Check if your MongoDB connection string is correct in `.env.local`
- Try connecting to MongoDB using MongoDB Compass with the same connection string

### Development Tips
- Clear `.next` folder if you encounter strange build issues: `rm -rf .next`
- Run `npm install` after pulling new changes
- Make sure all environment variables are properly set
- Use Node.js version 18 or higher

## 📦 Project Structure

```
food-delivery/
├── admin
│   ├── Dockerfile
│   ├── public
│   ├── src
│   │   ├── App.jsx
│   │   ├── assets
│   │   ├── components
│   │   │   ├── Navbar
│   │   │   └── Sidebar
│   │   └── pages
│   │       ├── Add
│   │       ├── List
│   │       └── Orders
├── backend
│   ├── Dockerfile
│   ├── config
│   ├── controllers
│   ├── middleware
│   ├── models
│   ├── routes
│   └── uploads
├── docker-compose.yml
├── frontend
│   ├── Dockerfile
│   ├── public
│   ├── src
│   │   ├── App.jsx
│   │   ├── assets
│   │   ├── components
│   │   │   ├── AppDownload
│   │   │   ├── ExploreMenu
│   │   │   ├── FoodDisplay
│   │   │   ├── FoodItem
│   │   │   ├── Footer
│   │   │   ├── Header
│   │   │   ├── LoginPopup
│   │   │   └── Navbar   
│   │   ├── context
│   │   │   └── StoreContext.jsx
│   │   ├── index.css
│   │   ├── main.jsx
│   │   └── pages
├── kubernetes
│   ├── 01namespace.yml
│   ├── 02frontend-deployment.yml
│   ├── 03backend-deployment.yml
│   ├── 04admin-deployment.yml
│   ├── 08frontendservice.yml
│   ├── 09backendservice.yml
│   ├── 10admin-service.yml
│   ├── config.yml
│   ├── configMap.yml
│   ├── food-certificate.yml
│   ├── get_helm.sh
│   ├── hpa.yml
│   ├── ingress.yml
│   ├── letsencrypt-clusterissuer.yaml
│   ├── mongodb.yml
│   ├── mongodbpv.yml
│   └── secrets.yml
├── Terraform
│   ├── modules
│   │   ├── bastion
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   ├── variable.tf
│   │   ├── eks
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   ├── variable.tf
│   │   ├── security_group
│   │   │   ├── main.tf
│   │   │  ├── output.tf
│   │   │   ├── variable.tf
│   │   ├── vpc
│   │   │   ├── main.tf
│   │   │   ├── output.tf
│   │   │   ├── variable.tf
├── Jenkinsfile
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `npm test` (coming soon)
5. Commit your changes: `git commit -m 'Add amazing feature'`
6. Push to the branch: `git push origin feature/amazing-feature`
7. Open a Pull Request

## 📫 Contact

For questions or feedback, please open an issue or contact the maintainers:

- Maintainer - [@Md. Afzal hassan Ehsani](https://github.com/iemafzalhassan)
- Project Link: [https://github.com/iemafzalhassan/easyshop](https://github.com/iemafzalhassan/easyshop)

---

# Food Delivery Deployment

## Architecture Overview

tomato is deployed using a GitOps approach with the following components:

1. **Jenkins Pipeline**: Handles CI/CD, infrastructure deployment, and ArgoCD setup
2. **Terraform**: Manages AWS infrastructure (VPC, EKS, IAM)
3. **ArgoCD**: Manages application deployment using GitOps
4. **Kubernetes**: Runs the application and supporting services
5. **Monitoring**: Prometheus and Grafana for observability

## Deployment Flow

1. Jenkins pipeline is triggered by code changes
2. Docker images are built and pushed to Docker Hub
3. Terraform deploys or updates AWS infrastructure
4. ArgoCD is installed on the EKS cluster
5. ArgoCD applications are created to deploy EasyShop and monitoring
6. ArgoCD syncs the applications from the Git repository

## Key Files

- **Jenkinsfile**: Main CI/CD pipeline definition
- **terraform/**: Infrastructure as Code for AWS resources
- **kubernetes/**: Kubernetes manifests for application deployment
- **kubernetes/argocd/**: ArgoCD application definitions
- **scripts/**: Utility scripts for deployment and management

## Important Notes

- ArgoCD installation is managed exclusively by the Jenkins pipeline
- Infrastructure is managed by Terraform
- Application deployment is managed by ArgoCD
- Secrets should be managed using AWS Secrets Manager or Kubernetes secrets

## Local Development

For local development, you can use:

```bash
# Start a local Kubernetes cluster
kind create cluster --name food-cluster

# Deploy the application locally
kubectl apply -f kubernetes/
```