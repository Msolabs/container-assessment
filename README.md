# MuchTodo Containerization and Kubernetes Deployment

## Project Overview

This project is the Month 2 Assessment for the Cloud Engineering program.

The goal of the assessment is to containerize the MuchTodo backend application and deploy it on Kubernetes using modern DevOps practices.

The application consists of:

* Golang Backend API
* MongoDB Database
* Docker for containerization
* Docker Compose for local development
* Kubernetes for orchestration

---

## Architecture

### Docker Architecture

```text
Client
   |
   v
Backend Container (Port 8080)
   |
   v
MongoDB Container (Port 27017)
```

### Kubernetes Architecture

```text
Client
   |
   v
NodePort Service
   |
   v
Backend Deployment (2 Replicas)
   |
   v
MongoDB Service
   |
   v
MongoDB Deployment (1 Replica)
   |
   v
Persistent Volume Claim
```

---

## Features

* User Registration
* User Authentication (JWT)
* User Profile Endpoint
* Create Todo
* List Todos
* Update Todo
* Delete Todo
* Health Check Endpoint

---

## Technologies Used

* Golang
* MongoDB
* Docker
* Docker Compose
* Kubernetes
* Kind
* Kubectl

---

## Project Structure

```text
container-assessment/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── kubernetes/
│   ├── namespace.yaml
│   ├── mongodb/
│   │   ├── secret.yaml
│   │   ├── configmap.yaml
│   │   ├── pvc.yaml
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   ├── backend/
│   │   ├── secret.yaml
│   │   ├── configmap.yaml
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── ingress.yaml
├── scripts/
│   ├── docker-build.sh
│   ├── docker-run.sh
│   ├── k8s-deploy.sh
│   └── k8s-cleanup.sh
├── evidence/
└── README.md
```

---

## Docker Setup

### Build Docker Image

```bash
docker build -t muchtodo-backend:v1 .
```

### Run with Docker Compose

```bash
docker compose up -d
```

### Verify Running Containers

```bash
docker ps
```

### Test Health Endpoint

```bash
curl http://localhost:8080/health
```

Expected Response:

```json
{
  "cache": "disabled",
  "database": "ok"
}
```

---

## Kubernetes Deployment

### Verify Cluster

```bash
kubectl get nodes
```

### Deploy Namespace

```bash
kubectl apply -f kubernetes/namespace.yaml
```

### Deploy MongoDB

```bash
kubectl apply -f kubernetes/mongodb/
```

### Deploy Backend

```bash
kubectl apply -f kubernetes/backend/
```

### Deploy Ingress

```bash
kubectl apply -f kubernetes/ingress.yaml
```

### Verify Resources

```bash
kubectl get pods -n muchtodo
kubectl get svc -n muchtodo
kubectl get all -n muchtodo
```

---

## Accessing the Application

### Port Forward

```bash
kubectl port-forward svc/muchtodo-backend 8081:8080 -n muchtodo
```

### Health Check

```bash
curl http://127.0.0.1:8081/health
```

---

## API Testing

### Register User

```bash
curl -X POST http://127.0.0.1:8081/auth/register \
-H "Content-Type: application/json" \
-d '{
  "FirstName": "Moshood",
  "LastName": "Owolabi",
  "username": "moshoodowolabi",
  "email": "moshood@example.com",
  "password": "123456"
}'
```

### Login User

```bash
curl -X POST http://127.0.0.1:8081/auth/login \
-H "Content-Type: application/json" \
-d '{
  "username": "moshoodowolabi",
  "password": "123456"
}'
```

### Get User Profile

```bash
curl http://127.0.0.1:8081/users/me \
-H "Authorization: Bearer <TOKEN>"
```

### Create Todo

```bash
curl -X POST http://127.0.0.1:8081/todos/ \
-H "Content-Type: application/json" \
-H "Authorization: Bearer <TOKEN>"
```

### List Todos

```bash
curl http://127.0.0.1:8081/todos/ \
-H "Authorization: Bearer <TOKEN>"
```

---

## Automation Scripts

### Docker Build

```bash
./scripts/docker-build.sh
```

### Docker Run

```bash
./scripts/docker-run.sh
```

### Kubernetes Deploy

```bash
./scripts/k8s-deploy.sh
```

### Kubernetes Cleanup

```bash
./scripts/k8s-cleanup.sh
```

---

## Evidence

The `evidence/` directory contains screenshots showing:

* Docker image build
* Docker Compose deployment
* Health endpoint response
* User registration
* User login
* User profile retrieval
* Todo creation
* Todo listing
* Todo update
* Todo deletion
* Kubernetes cluster creation
* Running pods
* Running services
* Deployment status
* Script execution results

---

## Security Considerations

* Multi-stage Docker build used for smaller image size
* Non-root container user configured
* Secrets stored in Kubernetes Secret resources
* Configuration stored in ConfigMaps
* Health checks configured for Kubernetes deployments

---

## Conclusion

This project demonstrates containerization of a Golang application using Docker and deployment to Kubernetes using Kind. The deployment includes persistent MongoDB storage, service discovery, configuration management, automation scripts, and deployment verification through API testing.
