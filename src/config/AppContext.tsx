import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { userAPI, jobAPI, categoryAPI, companyAPI } from './api';

// Define types for our context data
interface User {
  id: number;
  name: string;
  email?: string;
  type?: string;
  [key: string]: any;
}

interface Job {
  id: number;
  title: string;
  description?: string;
  user_id?: number;
  category_id?: number;
  type?: string;
  [key: string]: any;
}

interface Category {
  id: number;
  title: string;
  slug?: string;
  [key: string]: any;
}

interface Company {
  id: number;
  name: string;
  [key: string]: any;
}

interface AppContextType {
  users: User[];
  jobs: Job[];
  categories: Category[];
  companies: Company[];
  loading: {
    users: boolean;
    jobs: boolean;
    categories: boolean;
    companies: boolean;
  };
  error: {
    users: string | null;
    jobs: string | null;
    categories: string | null;
    companies: string | null;
  };
  refreshData: () => void;
}

// Create the context
const AppContext = createContext<AppContextType | undefined>(undefined);

// Create a provider component
export const AppProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  // State for data
  const [users, setUsers] = useState<User[]>([]);
  const [jobs, setJobs] = useState<Job[]>([]);
  const [categories, setCategories] = useState<Category[]>([]);
  const [companies, setCompanies] = useState<Company[]>([]);

  // State for loading status
  const [loading, setLoading] = useState({
    users: false,
    jobs: false,
    categories: false,
    companies: false,
  });

  // State for errors
  const [error, setError] = useState({
    users: null,
    jobs: null,
    categories: null,
    companies: null,
  });

  // Function to fetch all data
  const fetchAllData = async () => {
    // Fetch users
    setLoading(prev => ({ ...prev, users: true }));
    try {
      const userData = await userAPI.getAll();
      setUsers(userData);
      setError(prev => ({ ...prev, users: null }));
    } catch (err) {
      setError(prev => ({ ...prev, users: err instanceof Error ? err.message : 'Unknown error' }));
    } finally {
      setLoading(prev => ({ ...prev, users: false }));
    }

    // Fetch jobs
    setLoading(prev => ({ ...prev, jobs: true }));
    try {
      const jobData = await jobAPI.getAll();
      setJobs(jobData);
      setError(prev => ({ ...prev, jobs: null }));
    } catch (err) {
      setError(prev => ({ ...prev, jobs: err instanceof Error ? err.message : 'Unknown error' }));
    } finally {
      setLoading(prev => ({ ...prev, jobs: false }));
    }

    // Fetch categories
    setLoading(prev => ({ ...prev, categories: true }));
    try {
      const categoryData = await categoryAPI.getAll();
      setCategories(categoryData);
      setError(prev => ({ ...prev, categories: null }));
    } catch (err) {
      setError(prev => ({ ...prev, categories: err instanceof Error ? err.message : 'Unknown error' }));
    } finally {
      setLoading(prev => ({ ...prev, categories: false }));
    }

    // Fetch companies
    setLoading(prev => ({ ...prev, companies: true }));
    try {
      const companyData = await companyAPI.getAll();
      setCompanies(companyData);
      setError(prev => ({ ...prev, companies: null }));
    } catch (err) {
      setError(prev => ({ ...prev, companies: err instanceof Error ? err.message : 'Unknown error' }));
    } finally {
      setLoading(prev => ({ ...prev, companies: false }));
    }
  };

  // Fetch data on component mount
  useEffect(() => {
    fetchAllData();
  }, []);

  // Context value
  const contextValue: AppContextType = {
    users,
    jobs,
    categories,
    companies,
    loading,
    error,
    refreshData: fetchAllData,
  };

  return <AppContext.Provider value={contextValue}>{children}</AppContext.Provider>;
};

// Custom hook to use the context
export const useAppContext = () => {
  const context = useContext(AppContext);
  if (context === undefined) {
    throw new Error('useAppContext must be used within an AppProvider');
  }
  return context;
};

export default AppContext; 