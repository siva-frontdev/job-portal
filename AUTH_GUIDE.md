# Authentication Implementation Guide

## Overview

This guide explains how to implement and use the authentication system that combines API token-based authentication with web session authentication.

## Endpoints

### 1. API Authentication Endpoints

#### Login

-   **URL:** `/api/login`
-   **Method:** `POST`
-   **Body Parameters:**
    ```json
    {
        "email": "user@example.com",
        "password": "password",
        "remember": 0
    }
    ```
-   **Success Response:**
    ```json
    {
        "token": "your_access_token_here",
        "user": {
            "id": 1,
            "name": "User Name",
            "email": "user@example.com",
            "role": "user"
        },
        "message": "Login successful"
    }
    ```
-   **Error Response:**
    ```json
    {
        "errors": {
            "email": ["The provided credentials are incorrect."]
        }
    }
    ```

#### Logout

-   **URL:** `/api/logout`
-   **Method:** `POST`
-   **Headers:**
    ```
    Authorization: Bearer your_token_here
    ```
-   **Success Response:**
    ```json
    {
        "message": "Logged out successfully"
    }
    ```

### 2. Web Authentication Endpoints

#### Auto Login

-   **URL:** `/auto-login`
-   **Method:** `GET`
-   **Query Parameters:** `?token=your_token_here`
-   **Success:** Redirects to appropriate dashboard based on user role
-   **Error:** Redirects to login page with error message

## Implementation Steps

### 1. Frontend Setup (Vue.js)

1. **Initialize Authentication State:**

```javascript
// resources/js/stores/auth.js
import { defineStore } from "pinia";

export const useAuthStore = defineStore("auth", {
    state: () => ({
        token: localStorage.getItem("auth_token"),
        user: JSON.parse(localStorage.getItem("user") || "null"),
    }),

    actions: {
        setAuth(token, user) {
            this.token = token;
            this.user = user;
            localStorage.setItem("auth_token", token);
            localStorage.setItem("user", JSON.stringify(user));
        },

        clearAuth() {
            this.token = null;
            this.user = null;
            localStorage.removeItem("auth_token");
            localStorage.removeItem("user");
        },
    },
});
```

2. **Setup Axios Interceptors:**

```javascript
// resources/js/utils/axios.js
import axios from "axios";

const setupAxiosInterceptors = () => {
    axios.interceptors.request.use((config) => {
        const token = localStorage.getItem("auth_token");
        if (token) {
            config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
    });

    axios.interceptors.response.use(
        (response) => response,
        (error) => {
            if (error.response?.status === 401) {
                localStorage.removeItem("auth_token");
                localStorage.removeItem("user");
                window.location.href = "/login";
            }
            return Promise.reject(error);
        }
    );
};

export default setupAxiosInterceptors;
```

### 2. Backend Setup

1. **Update User Model:**

```php
// app/Models/User.php
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens;
    // ...
}
```

2. **Create Authentication Service:**

```php
// app/Services/AuthService.php
namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\Auth;

class AuthService
{
    public function attemptLogin($credentials)
    {
        if (!Auth::attempt($credentials)) {
            return false;
        }

        $user = Auth::user();
        $token = $user->createToken('auth-token')->plainTextToken;

        return [
            'user' => $user,
            'token' => $token
        ];
    }

    public function logout($user)
    {
        $user->currentAccessToken()->delete();
        Auth::logout();
    }
}
```

## Usage Examples

### 1. Login Implementation

```javascript
// In your login component
const handleLogin = async () => {
    try {
        const response = await axios.post("/api/login", {
            email: form.email,
            password: form.password,
            remember: form.remember,
        });

        if (response.data.token) {
            // Store authentication data
            authStore.setAuth(response.data.token, response.data.user);

            // Redirect to auto-login
            window.location.href = `/auto-login?token=${response.data.token}`;
        }
    } catch (error) {
        handleError(error);
    }
};
```

### 2. Protected Route Access

```javascript
// In your dashboard or protected component
const fetchDashboardData = async () => {
    try {
        const response = await axios.get("/api/dashboard-data");
        // Handle response
    } catch (error) {
        // Handle error
    }
};
```

### 3. Logout Implementation

```javascript
const handleLogout = async () => {
    try {
        await axios.post("/api/logout");
        authStore.clearAuth();
        window.location.href = "/login";
    } catch (error) {
        console.error("Logout failed:", error);
    }
};
```

## Security Considerations

1. **Token Storage:**

    - Store tokens in localStorage only for development
    - Use secure HTTP-only cookies in production
    - Consider implementing refresh tokens for better security

2. **CSRF Protection:**

    - Ensure CSRF token is included in requests
    - Use Laravel's built-in CSRF protection

3. **Token Expiration:**

    - Set appropriate token expiration times
    - Implement token refresh mechanism for long sessions

4. **Error Handling:**
    - Always validate input on both frontend and backend
    - Implement proper error handling and user feedback

## Best Practices

1. **State Management:**

    - Use a state management solution (Pinia/Vuex) for auth state
    - Keep authentication logic centralized

2. **API Requests:**

    - Use interceptors for token management
    - Handle 401 responses globally

3. **Route Protection:**

    - Implement navigation guards in Vue Router
    - Use middleware for API route protection

4. **Testing:**
    - Write tests for authentication flows
    - Test both success and failure scenarios

## Troubleshooting

Common issues and solutions:

1. **Token Not Being Sent:**

    - Check axios interceptor configuration
    - Verify token storage implementation

2. **Session Not Persisting:**

    - Verify session configuration
    - Check cookie settings

3. **CORS Issues:**

    - Configure CORS middleware properly
    - Check API domain settings

4. **Invalid Token Errors:**
    - Verify token format
    - Check token expiration
    - Ensure proper token storage
