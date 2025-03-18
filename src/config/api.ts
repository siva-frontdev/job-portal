// API configuration and service functions
const API_BASE_URL = 'http://localhost:5000';

// Generic fetch function with error handling
async function fetchFromAPI(endpoint: string, options: RequestInit = {}) {
  try {
    const response = await fetch(`${API_BASE_URL}${endpoint}`, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `API error: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error('API request failed:', error);
    throw error;
  }
}

// User related API calls
export const userAPI = {
  getAll: () => fetchFromAPI('/users'),
  add: (name: string) => fetchFromAPI('/adduser', {
    method: 'POST',
    body: JSON.stringify({ name }),
  }),
};

// Job openings related API calls
export const jobAPI = {
  getAll: () => fetchFromAPI('/openings'),
  getById: (id: number) => fetchFromAPI(`/openings/${id}`),
  getByCategory: (categoryId: number) => fetchFromAPI(`/openings/category/${categoryId}`),
  getByLocation: (locationId: number) => fetchFromAPI(`/openings/location/${locationId}`),
  add: (jobData: any) => fetchFromAPI('/openings', {
    method: 'POST',
    body: JSON.stringify(jobData),
  }),
};

// Categories related API calls
export const categoryAPI = {
  getAll: () => fetchFromAPI('/categories'),
  getById: (id: number) => fetchFromAPI(`/categories/${id}`),
};

// Companies related API calls
export const companyAPI = {
  getAll: () => fetchFromAPI('/companies'),
  getById: (id: number) => fetchFromAPI(`/companies/${id}`),
};

// Export all API services
export default {
  userAPI,
  jobAPI,
  categoryAPI,
  companyAPI,
}; 