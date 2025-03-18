import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit';
import axios from 'axios';

// Define types
interface User {
  id: number;
  name: string;
  email: string;
  role: string;
}

interface AuthState {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
}

// API Base URL
const API_BASE_URL = 'http://127.0.0.1:8000';

// Initial state
const initialState: AuthState = {
  user: JSON.parse(localStorage.getItem('user') || 'null'),
  token: localStorage.getItem('authToken'),
  isAuthenticated: !!localStorage.getItem('authToken'),
  loading: false,
  error: null,
};

// Async thunks
export const register = createAsyncThunk(
  'auth/register',
  async (userData: { name: string; email: string; password: string; password_confirmation: string }, { rejectWithValue }) => {
    try {
      const response = await axios.post(`${API_BASE_URL}/api/register`, userData);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.data) {
        return rejectWithValue(error.response.data);
      }
      return rejectWithValue({ message: 'Registration failed' });
    }
  }
);

export const login = createAsyncThunk(
  'auth/login',
  async (credentials: { email: string; password: string; remember?: number }, { rejectWithValue }) => {
    try {
      const response = await axios.post(`${API_BASE_URL}/api/login`, credentials);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.data) {
        return rejectWithValue(error.response.data);
      }
      return rejectWithValue({ message: 'Login failed' });
    }
  }
);

export const logout = createAsyncThunk(
  'auth/logout',
  async (_, { getState, rejectWithValue }) => {
    try {
      const { auth } = getState() as { auth: AuthState };
      await axios.post(
        `${API_BASE_URL}/api/logout`,
        {},
        {
          headers: {
            Authorization: `Bearer ${auth.token}`,
          },
        }
      );
      return null;
    } catch (error: any) {
      if (error.response && error.response.data) {
        return rejectWithValue(error.response.data);
      }
      return rejectWithValue({ message: 'Logout failed' });
    }
  }
);

export const checkToken = createAsyncThunk(
  'auth/checkToken',
  async (_, { getState, rejectWithValue }) => {
    try {
      const { auth } = getState() as { auth: AuthState };
      if (!auth.token) return rejectWithValue({ message: 'No token found' });
      
      const response = await axios.get(`${API_BASE_URL}/api/check-token`, {
        headers: {
          Authorization: `Bearer ${auth.token}`,
        },
      });
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.data) {
        return rejectWithValue(error.response.data);
      }
      return rejectWithValue({ message: 'Token validation failed' });
    }
  }
);

// Create slice
const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    },
  },
  extraReducers: (builder) => {
    // Register
    builder.addCase(register.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(register.fulfilled, (state, action: PayloadAction<{ token: string; user: User }>) => {
      state.loading = false;
      state.isAuthenticated = true;
      state.token = action.payload.token;
      state.user = action.payload.user;
      
      // Save to localStorage
      localStorage.setItem('authToken', action.payload.token);
      localStorage.setItem('user', JSON.stringify(action.payload.user));
      
      // Set axios default header
      axios.defaults.headers.common['Authorization'] = `Bearer ${action.payload.token}`;
    });
    builder.addCase(register.rejected, (state, action) => {
      state.loading = false;
      state.error = action.payload ? (action.payload as any).message : 'Registration failed';
    });
    
    // Login
    builder.addCase(login.pending, (state) => {
      state.loading = true;
      state.error = null;
    });
    builder.addCase(login.fulfilled, (state, action: PayloadAction<{ token: string; user: User }>) => {
      state.loading = false;
      state.isAuthenticated = true;
      state.token = action.payload.token;
      state.user = action.payload.user;
      
      // Save to localStorage
      localStorage.setItem('authToken', action.payload.token);
      localStorage.setItem('user', JSON.stringify(action.payload.user));
      
      // Set axios default header
      axios.defaults.headers.common['Authorization'] = `Bearer ${action.payload.token}`;
    });
    builder.addCase(login.rejected, (state, action) => {
      state.loading = false;
      state.error = action.payload ? (action.payload as any).message : 'Login failed';
    });
    
    // Logout
    builder.addCase(logout.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(logout.fulfilled, (state) => {
      state.loading = false;
      state.isAuthenticated = false;
      state.token = null;
      state.user = null;
      
      // Remove from localStorage
      localStorage.removeItem('authToken');
      localStorage.removeItem('user');
      
      // Remove axios default header
      delete axios.defaults.headers.common['Authorization'];
    });
    builder.addCase(logout.rejected, (state) => {
      state.loading = false;
      // Even if the API call fails, we'll still log out the user locally
      state.isAuthenticated = false;
      state.token = null;
      state.user = null;
      
      // Remove from localStorage
      localStorage.removeItem('authToken');
      localStorage.removeItem('user');
      
      // Remove axios default header
      delete axios.defaults.headers.common['Authorization'];
    });
    
    // Check Token
    builder.addCase(checkToken.pending, (state) => {
      state.loading = true;
    });
    builder.addCase(checkToken.fulfilled, (state, action: PayloadAction<{ valid: boolean; user: User }>) => {
      state.loading = false;
      if (action.payload.valid) {
        state.isAuthenticated = true;
        state.user = action.payload.user;
      } else {
        state.isAuthenticated = false;
        state.token = null;
        state.user = null;
        
        // Remove from localStorage
        localStorage.removeItem('authToken');
        localStorage.removeItem('user');
        
        // Remove axios default header
        delete axios.defaults.headers.common['Authorization'];
      }
    });
    builder.addCase(checkToken.rejected, (state) => {
      state.loading = false;
      state.isAuthenticated = false;
      state.token = null;
      state.user = null;
      
      // Remove from localStorage
      localStorage.removeItem('authToken');
      localStorage.removeItem('user');
      
      // Remove axios default header
      delete axios.defaults.headers.common['Authorization'];
    });
  },
});

export const { clearError } = authSlice.actions;
export default authSlice.reducer; 