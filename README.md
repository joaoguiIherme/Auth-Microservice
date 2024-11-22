---

# Auth Microservice

The **Auth Microservice** is a part of a multi-service architecture designed to handle user authentication. It provides endpoints for user registration, login, and token validation, ensuring secure access control across all services in the ecosystem. Built with Ruby on Rails, it is fully containerized using Docker.

---

## Features

- **User Registration**:
  - Allows new users to register with their credentials.
- **Secure Authentication**:
  - Token-based authentication using JSON Web Tokens (JWT).
- **Token Validation**:
  - Validates user tokens for secure inter-service communication.
- **Dockerized Deployment**:
  - Easy setup and deployment using Docker Compose.

---

## Architecture

The **Auth Microservice** serves as the authentication gateway for the larger application ecosystem. It generates and validates JWTs for secure communication between services and protects endpoints from unauthorized access.

---

## Prerequisites

Before setting up the Auth Microservice, ensure you have:

- [Docker](https://www.docker.com/get-started) installed (Version 20.10 or higher).
- [Docker Compose](https://docs.docker.com/compose/) installed (Version 2.x or higher).
- PostgreSQL (via Docker).
- Access to other repositories in the ecosystem:
  - [Main App](https://github.com/joaoguiIherme/Main-Tasks-App)
  - [Notifications Service](https://github.com/joaoguiIherme/Notifications-Microservice)
  - [Scraping Service](https://github.com/joaoguiIherme/Scraping-Microservice)

---

## Installation

### 1. Clone the Repository

Clone this repository into your workspace:
```bash
git clone https://github.com/joaoguiIherme/Auth-Microservice.git
cd Auth-Microservice
```

### 2. File Structure Adjustment

Ensure this microservice is placed in the same directory as the other services. The recommended directory structure is as follows:

```plaintext
Main-Root Dir/
├── auth_service/ (this repository)
├── main_app/
├── notifications_service/
├── scraping_service/
└── docker-compose.yml
```

Ensure the `docker-compose.yml` file is located in the root directory for multi-service orchestration.

### 3. Build and Start Services

Use Docker Compose to build and run all services:
```bash
docker-compose up --build
```

### 4. Access the Auth Service

The Auth Microservice runs on [http://localhost:4000](http://localhost:4000).

---

## API Endpoints

The following endpoints are exposed by the Auth Microservice:

### POST `/auth/register`
- **Description**: Registers a new user.
- **Request Body**:
  - `name` (String): User's full name.
  - `email` (String): User's email address.
  - `password` (String): User's password.
  - `password_confirmation` (String): Confirmation of the password.
- **Response**:
  - `201 Created`: User successfully registered.
  - `422 Unprocessable Entity`: Validation errors.

### POST `/auth/login`
- **Description**: Logs in a user and generates a JWT.
- **Request Body**:
  - `email` (String): User's email address.
  - `password` (String): User's password.
- **Response**:
  - `200 OK`: JWT token returned.
  - `401 Unauthorized`: Invalid credentials.

### GET `/auth/validate`
- **Description**: Validates the provided JWT.
- **Headers**:
  - `Authorization`: Bearer token.
- **Response**:
  - `200 OK`: Token is valid.
  - `401 Unauthorized`: Token is invalid or expired.

---

## Configuration

### Environment Variables

This service relies on environment variables, which are defined in the `docker-compose.yml` file:

- `DATABASE_URL`: Connection string for the PostgreSQL database.

### Network Configuration

The service uses the `app_network` Docker network to communicate with other services. Ensure that the service names in your code (e.g., `main_app`, `notifications_service`) match those defined in `docker-compose.yml`.

---

## Testing

Run the following commands to test the Auth Microservice:

### 1. Access the Container

```bash
docker exec -it auth_service bash
```

### 2. Run Tests

Run RSpec tests to validate functionality:
```bash
bundle exec rspec
```

---

## Troubleshooting

### Common Issues

1. **Database Connection Issues**:
   - Ensure the `db` service is running and the `DATABASE_URL` is correctly set.

2. **Token Validation Errors**:
   - Verify that the `Authorization` header is correctly formatted (`Bearer <token>`).

3. **Host Authorization Errors**:
   - Add `config.hosts << "auth_service"` in `config/application.rb` if needed.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push to your fork.
4. Submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.

---

## Acknowledgments

This microservice is part of a larger architecture demonstrating the power of microservices with Docker and Ruby on Rails.

--- 

If you need further adjustments or specific details added, feel free to ask!
