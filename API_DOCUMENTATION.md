# Laravel Authentication API Documentation

This document provides details about the authentication API endpoints for the Jobi Job Board application.

## Base URL

```
http://127.0.0.1:8000
```

For production, replace with your domain.

## Authentication

The API uses Laravel Sanctum for token-based authentication. After successful login or registration, you'll receive a token that should be included in subsequent requests as a Bearer token in the Authorization header.

Example:
```
Authorization: Bearer 1|abcdefghijklmnopqrstuvwxyz123456
```

## Endpoints

### Register

Creates a new user account and returns an authentication token.

- **URL**: `/api/register`
- **Method**: `POST`
- **Auth required**: No

**Request Body:**

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

**Success Response:**

- **Code**: 200 OK
- **Content**:

```json
{
  "token": "1|abcdefghijklmnopqrstuvwxyz123456",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  },
  "message": "Registration successful"
}
```

**Error Response:**

- **Code**: 422 Unprocessable Entity
- **Content**:

```json
{
  "message": "The given data was invalid.",
  "errors": {
    "email": [
      "The email has already been taken."
    ],
    "password": [
      "The password confirmation does not match."
    ]
  }
}
```

### Login

Authenticates a user and returns a token.

- **URL**: `/api/login`
- **Method**: `POST`
- **Auth required**: No

**Request Body:**

```json
{
  "email": "john@example.com",
  "password": "password123",
  "remember": 0
}
```

**Success Response:**

- **Code**: 200 OK
- **Content**:

```json
{
  "token": "1|abcdefghijklmnopqrstuvwxyz123456",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  },
  "message": "Login successful"
}
```

**Error Response:**

- **Code**: 422 Unprocessable Entity
- **Content**:

```json
{
  "message": "The given data was invalid.",
  "errors": {
    "email": [
      "The provided credentials are incorrect."
    ]
  }
}
```

### Logout

Invalidates the current user's token.

- **URL**: `/api/logout`
- **Method**: `POST`
- **Auth required**: Yes (Bearer Token)

**Success Response:**

- **Code**: 200 OK
- **Content**:

```json
{
  "message": "Logged out successfully"
}
```

**Error Response:**

- **Code**: 401 Unauthorized
- **Content**:

```json
{
  "message": "Unauthenticated."
}
```

### Get User

Retrieves the authenticated user's information.

- **URL**: `/api/user`
- **Method**: `GET`
- **Auth required**: Yes (Bearer Token)

**Success Response:**

- **Code**: 200 OK
- **Content**:

```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  }
}
```

**Error Response:**

- **Code**: 401 Unauthorized
- **Content**:

```json
{
  "message": "Unauthenticated."
}
```

### Check Token

Verifies if the current token is valid.

- **URL**: `/api/check-token`
- **Method**: `GET`
- **Auth required**: Yes (Bearer Token)

**Success Response:**

- **Code**: 200 OK
- **Content**:

```json
{
  "valid": true,
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user",
    "created_at": "2023-01-01T00:00:00.000000Z",
    "updated_at": "2023-01-01T00:00:00.000000Z"
  }
}
```

**Error Response:**

- **Code**: 401 Unauthorized
- **Content**:

```json
{
  "message": "Unauthenticated."
}
```

### Auto Login

Redirects the authenticated user to their appropriate dashboard based on their role.

- **URL**: `/api/simple-auto-login`
- **Method**: `GET`
- **Auth required**: Yes (Bearer Token)

**Success Response:**

- **Code**: 302 Found
- **Redirects to**:
  - Admin users: `/admin/dashboard`
  - Employer users: `/employer/dashboard`
  - Regular users: `/user/dashboard`

**Error Response:**

- **Code**: 401 Unauthorized
- **Content**:

```json
{
  "message": "Unauthenticated."
}
```

## Error Codes

- `401 Unauthorized`: Authentication is required and has failed or has not been provided.
- `422 Unprocessable Entity`: The request was well-formed but was unable to be followed due to semantic errors.
- `500 Internal Server Error`: The server encountered an unexpected condition that prevented it from fulfilling the request.

## Testing with cURL

### Register

```bash
curl -X POST "http://127.0.0.1:8000/api/register" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }'
```

### Login

```bash
curl -X POST "http://127.0.0.1:8000/api/login" \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "password123",
    "remember": 0
  }'
```

### Logout

```bash
curl -X POST "http://127.0.0.1:8000/api/logout" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Get User

```bash
curl "http://127.0.0.1:8000/api/user" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Check Token

```bash
curl "http://127.0.0.1:8000/api/check-token" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Auto Login

```bash
curl -L "http://127.0.0.1:8000/api/simple-auto-login" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

Replace `YOUR_TOKEN` with the token received from login or register.

## Using with JavaScript/Axios

### Register

```javascript
axios.post('http://127.0.0.1:8000/api/register', {
  name: 'Test User',
  email: 'test@example.com',
  password: 'password123',
  password_confirmation: 'password123'
})
.then(response => {
  // Store token
  localStorage.setItem('authToken', response.data.token);
  // Set default Authorization header
  axios.defaults.headers.common['Authorization'] = `Bearer ${response.data.token}`;
})
.catch(error => {
  console.error('Registration error:', error.response.data);
});
```

### Login

```javascript
axios.post('http://127.0.0.1:8000/api/login', {
  email: 'test@example.com',
  password: 'password123',
  remember: 0
})
.then(response => {
  // Store token
  localStorage.setItem('authToken', response.data.token);
  // Set default Authorization header
  axios.defaults.headers.common['Authorization'] = `Bearer ${response.data.token}`;
})
.catch(error => {
  console.error('Login error:', error.response.data);
});
```

### Logout

```javascript
axios.post('http://127.0.0.1:8000/api/logout')
.then(response => {
  // Clear token
  localStorage.removeItem('authToken');
  delete axios.defaults.headers.common['Authorization'];
})
.catch(error => {
  console.error('Logout error:', error.response.data);
});
```

### Auto Login

```javascript
// Redirect to dashboard
window.location.href = 'http://127.0.0.1:8000/api/simple-auto-login';
```