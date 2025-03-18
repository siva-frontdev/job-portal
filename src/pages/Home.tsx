import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { 
  Search, Briefcase, Building2, Trophy, ChevronRight, Star, Clock, MapPin, 
  Zap, Users, CheckCircle, TrendingUp, Award, BookOpen, Target, Rocket,
  DollarSign, Globe, Bookmark, ThumbsUp, ChevronLeft
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { useAppContext } from '../config/AppContext';

// Define interfaces for the components
interface FeaturedJob {
  id: number;
  title: string;
  company: string;
  company_logo?: string;
  location: string;
  type: string;
  posted_at: string;
  salary: string;
  tags: string[];
}

// Define a local Company interface that extends the one from AppContext
interface CompanyWithDetails {
  id: number;
  name: string;
  logo?: string;
  industry: string;
  total_jobs: number;
  [key: string]: any;
}

interface JobCategory {
  id: number;
  title: string;
  icon: string;
  job_count: number;
}

interface JobStat {
  total_jobs: number;
  total_companies: number;
  total_placements: number;
  active_users: number;
}

// Animation variants
const fadeIn = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.5 }
};

const staggerContainer = {
  animate: {
    transition: {
      staggerChildren: 0.1
    }
  }
};

const Home = () => {
  const { jobs, categories, companies, loading, error } = useAppContext();
  const [featuredJobs, setFeaturedJobs] = useState<FeaturedJob[]>([]);
  const [topCompanies, setTopCompanies] = useState<CompanyWithDetails[]>([]);
  const [jobCategories, setJobCategories] = useState<JobCategory[]>([]);
  const [jobStats, setJobStats] = useState<JobStat>({
    total_jobs: 0,
    total_companies: 0,
    total_placements: 0,
    active_users: 0
  });
  const [searchQuery, setSearchQuery] = useState('');
  const [locationQuery, setLocationQuery] = useState('');
  const [popularSearches, setPopularSearches] = useState<string[]>([]);
  const [currentJobPage, setCurrentJobPage] = useState(1);
  const [currentCategoryPage, setCurrentCategoryPage] = useState(1);
  const [currentCompanyPage, setCurrentCompanyPage] = useState(1);
  
  // Pagination settings
  const jobsPerPage = 12;
  const categoriesPerPage = 8;
  const companiesPerPage = 12;

  // Background animation elements
  const backgroundShapes = [
    { id: 1, size: 180, x: '10%', y: '20%', duration: 20, delay: 0 },
    { id: 2, size: 150, x: '85%', y: '15%', duration: 25, delay: 0.5 },
    { id: 3, size: 120, x: '70%', y: '70%', duration: 30, delay: 1 },
    { id: 4, size: 200, x: '20%', y: '80%', duration: 22, delay: 1.5 },
    { id: 5, size: 140, x: '40%', y: '30%', duration: 28, delay: 2 },
    { id: 6, size: 160, x: '60%', y: '60%', duration: 18, delay: 2.5 },
  ];

  const particleCount = 30;
  const particles = Array.from({ length: particleCount }, (_, i) => ({
    id: i,
    size: Math.random() * 10 + 5,
    x: `${Math.random() * 100}%`,
    y: `${Math.random() * 100}%`,
    duration: Math.random() * 20 + 10,
    delay: Math.random() * 5,
  }));

  useEffect(() => {
    if (!jobs || !categories || !companies) return;

    // Set featured jobs
    const featured = jobs.map(job => ({
      id: job.id,
      title: job.title || 'Untitled Position',
      company: job.company_name || 'Company Name',
      company_logo: job.company_logo || '',
      location: job.location || 'Remote',
      type: job.type || 'Full-time',
      posted_at: job.posted_at || 'Recently',
      salary: job.salary || 'Competitive',
      tags: job.skills || []
    }));
    setFeaturedJobs(featured);

    // Set top companies with proper sorting and mapping to our local interface
    const sortedCompanies = [...companies]
      .sort((a, b) => {
        const aJobs = jobs.filter(job => job.company_id === a.id).length;
        const bJobs = jobs.filter(job => job.company_id === b.id).length;
        return bJobs - aJobs;
      })
      .map(company => ({
        id: company.id,
        name: company.name,
        logo: company.logo || '',
        industry: company.industry || 'Technology',
        total_jobs: jobs.filter(job => job.company_id === company.id).length
      }));
    
    setTopCompanies(sortedCompanies);

    // Set job categories with accurate counts
    const categoriesWithCount = categories.map(cat => ({
      id: cat.id,
      title: cat.title || 'Uncategorized',
      icon: cat.icon || 'Briefcase',
      job_count: jobs.filter(job => job.category_id === cat.id).length
    }));
    setJobCategories(categoriesWithCount);

    // Update job statistics
    setJobStats({
      total_jobs: jobs.length,
      total_companies: companies.length,
      total_placements: jobs.filter(job => job.is_filled).length,
      active_users: Math.floor(jobs.length * 2.5) // Estimate active users based on job count
    });

    // Set popular searches based on job titles and categories
    const searchTerms = new Set([
      ...jobs.map(job => job.title || '').filter(Boolean),
      ...categories.map(cat => cat.title || '').filter(Boolean)
    ]);
    setPopularSearches(Array.from(searchTerms).slice(0, 8));

  }, [jobs, categories, companies]);

  // Calculate pagination values for jobs
  const indexOfLastJob = currentJobPage * jobsPerPage;
  const indexOfFirstJob = indexOfLastJob - jobsPerPage;
  const currentFeaturedJobs = featuredJobs.slice(indexOfFirstJob, indexOfLastJob);
  const totalJobPages = Math.ceil(featuredJobs.length / jobsPerPage);

  // Calculate pagination values for categories
  const indexOfLastCategory = currentCategoryPage * categoriesPerPage;
  const indexOfFirstCategory = indexOfLastCategory - categoriesPerPage;
  const currentCategories = jobCategories.slice(indexOfFirstCategory, indexOfLastCategory);
  const totalCategoryPages = Math.ceil(jobCategories.length / categoriesPerPage);

  // Calculate pagination values for companies
  const indexOfLastCompany = currentCompanyPage * companiesPerPage;
  const indexOfFirstCompany = indexOfLastCompany - companiesPerPage;
  const currentCompanies = topCompanies.slice(indexOfFirstCompany, indexOfLastCompany);
  const totalCompanyPages = Math.ceil(topCompanies.length / companiesPerPage);

  // Handle page changes
  const handleJobPageChange = (pageNumber: number) => {
    setCurrentJobPage(pageNumber);
    const featuredSection = document.getElementById('featured-jobs');
    if (featuredSection) {
      featuredSection.scrollIntoView({ behavior: 'smooth' });
    }
  };

  const handleCategoryPageChange = (pageNumber: number) => {
    setCurrentCategoryPage(pageNumber);
    const categorySection = document.getElementById('job-categories');
    if (categorySection) {
      categorySection.scrollIntoView({ behavior: 'smooth' });
    }
  };

  const handleCompanyPageChange = (pageNumber: number) => {
    setCurrentCompanyPage(pageNumber);
    const companySection = document.getElementById('top-companies');
    if (companySection) {
      companySection.scrollIntoView({ behavior: 'smooth' });
    }
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (searchQuery || locationQuery) {
      // Navigate to jobs page with search params
      window.location.href = `/jobs?q=${searchQuery}&location=${locationQuery}`;
    }
  };

  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="relative overflow-hidden section-padding bg-gradient-to-b from-primary-50 to-white">
        {/* Animated Background Elements */}
        <div className="absolute inset-0 overflow-hidden">
          {/* Floating Shapes */}
          {backgroundShapes.map((shape) => (
            <motion.div
              key={shape.id}
              className="animated-bg-element"
              style={{
                width: shape.size,
                height: shape.size,
                left: shape.x,
                top: shape.y,
                zIndex: 1,
              }}
              initial={{ scale: 0.8, opacity: 0 }}
              animate={{ 
                scale: [0.8, 1.2, 0.8],
                opacity: [0.6, 0.9, 0.6],
                x: [0, 30, 0],
                y: [0, -30, 0],
              }}
              transition={{
                duration: shape.duration,
                repeat: Infinity,
                delay: shape.delay,
                ease: "easeInOut",
              }}
            />
          ))}
          
          {/* Particles */}
          {particles.map((particle) => (
            <motion.div
              key={particle.id}
              className="absolute rounded-full"
              style={{
                width: particle.size,
                height: particle.size,
                left: particle.x,
                top: particle.y,
                zIndex: 1,
                background: 'linear-gradient(135deg, rgba(54, 170, 245, 0.4), rgba(139, 92, 246, 0.4))',
                boxShadow: '0 0 15px rgba(54, 170, 245, 0.5)'
              }}
              initial={{ opacity: 0 }}
              animate={{ 
                opacity: [0, 1, 0],
                y: [0, -150],
                x: [0, Math.random() * 60 - 30],
              }}
              transition={{
                duration: particle.duration,
                repeat: Infinity,
                delay: particle.delay,
                ease: "linear",
              }}
            />
          ))}
        </div>

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24 relative z-10">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center max-w-4xl mx-auto"
          >
            <motion.h1 
              className="text-5xl md:text-6xl font-bold mb-6 gradient-text leading-tight"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.2 }}
            >
              Your Dream Career Starts Here
            </motion.h1>
            <motion.p 
              className="text-xl text-gray-600 mb-12"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.3 }}
            >
              {jobStats.total_jobs.toLocaleString()}+ jobs from {jobStats.total_companies.toLocaleString()}+ companies. 
              Find the perfect role for your next career move.
            </motion.p>
            
            {/* Search Bar */}
            <motion.form 
              className="max-w-3xl mx-auto"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.4 }}
              onSubmit={handleSearch}
            >
              <div className="flex flex-col md:flex-row items-center glass-effect rounded-xl shadow-xl p-3 md:p-2">
                <div className="flex items-center w-full md:w-auto mb-3 md:mb-0">
                  <Search className="h-5 w-5 text-gray-400 mx-3" />
                  <input
                    type="text"
                    placeholder="Job title, keywords, or company"
                    className="flex-1 p-2 outline-none w-full bg-transparent"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                  />
                </div>
                <div className="flex items-center w-full md:w-auto mb-3 md:mb-0 md:border-l border-gray-200">
                  <MapPin className="h-5 w-5 text-gray-400 mx-3" />
                  <input
                    type="text"
                    placeholder="Location"
                    className="flex-1 p-2 outline-none w-full bg-transparent"
                    value={locationQuery}
                    onChange={(e) => setLocationQuery(e.target.value)}
                  />
                </div>
                <button type="submit" className="btn-primary w-full md:w-auto">
                  Search Jobs
                </button>
              </div>
            </motion.form>
            
            {/* Popular Searches */}
            <motion.div 
              className="mt-6 text-sm text-gray-500"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.6 }}
            >
              <span>Popular: </span>
              {popularSearches.map((term, index) => (
                <Link 
                  key={index}
                  to={`/jobs?q=${term}`}
                  className="inline-block mx-2 px-3 py-1 rounded-full glass-effect hover:bg-opacity-80 transition-colors"
                >
                  {term}
                </Link>
              ))}
            </motion.div>
          </motion.div>
        </div>
      </section>
      
      {/* Stats Section */}
      <section className="bg-white py-16 border-t border-gray-100">
        <motion.div
          initial={{ opacity: 0 }}
          whileInView={{ opacity: 1 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8"
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <motion.div 
              className="card-gradient bg-white rounded-xl p-8 text-center card-hover"
              whileHover={{ y: -5 }}
              transition={{ type: "spring", stiffness: 300 }}
            >
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary-50 text-primary-600 mb-6">
                <Briefcase className="h-8 w-8" />
              </div>
              <h3 className="text-3xl font-bold mb-2">{jobStats.total_jobs.toLocaleString()}+</h3>
              <p className="text-gray-600">Active Job Listings</p>
            </motion.div>
            <motion.div 
              className="card-gradient bg-white rounded-xl p-8 text-center card-hover"
              whileHover={{ y: -5 }}
              transition={{ type: "spring", stiffness: 300 }}
            >
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-secondary-50 text-secondary-600 mb-6">
                <Building2 className="h-8 w-8" />
              </div>
              <h3 className="text-3xl font-bold mb-2">{jobStats.total_companies.toLocaleString()}+</h3>
              <p className="text-gray-600">Companies Hiring</p>
            </motion.div>
            <motion.div 
              className="card-gradient bg-white rounded-xl p-8 text-center card-hover"
              whileHover={{ y: -5 }}
              transition={{ type: "spring", stiffness: 300 }}
            >
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-primary-50 text-primary-600 mb-6">
                <Trophy className="h-8 w-8" />
              </div>
              <h3 className="text-3xl font-bold mb-2">{jobStats.total_placements.toLocaleString()}+</h3>
              <p className="text-gray-600">Successful Placements</p>
            </motion.div>
            <motion.div 
              className="card-gradient bg-white rounded-xl p-8 text-center card-hover"
              whileHover={{ y: -5 }}
              transition={{ type: "spring", stiffness: 300 }}
            >
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-secondary-50 text-secondary-600 mb-6">
                <Users className="h-8 w-8" />
              </div>
              <h3 className="text-3xl font-bold mb-2">{jobStats.active_users.toLocaleString()}+</h3>
              <p className="text-gray-600">Active Users</p>
            </motion.div>
          </div>
        </motion.div>
      </section>

      {/* Job Categories Section */}
      <section id="job-categories" className="section-padding bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div 
            className="text-center mb-12"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Popular Job Categories</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Explore opportunities across different industries and domains
            </p>
          </motion.div>
          
          {loading.categories ? (
            <div className="text-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500 mx-auto"></div>
            </div>
          ) : error.categories ? (
            <div className="text-center py-12 text-red-600">
              {error.categories}
            </div>
          ) : currentCategories.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-gray-600">No categories available</p>
            </div>
          ) : (
            <motion.div 
              className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6"
              variants={staggerContainer}
              initial="initial"
              whileInView="animate"
              viewport={{ once: true }}
            >
              {currentCategories.map((category) => (
                <motion.div
                  key={category.id}
                  variants={fadeIn}
                  whileHover={{ y: -5 }}
                  className="bg-white rounded-xl p-6 shadow-sm hover:shadow-md transition-shadow"
                >
                  <Link to={`/jobs?category=${category.id}`} className="block">
                    <div className="flex items-start">
                      <div className="w-12 h-12 rounded-lg bg-primary-50 flex items-center justify-center">
                        <Briefcase className="h-6 w-6 text-primary-600" />
                      </div>
                      <div className="ml-4">
                        <h3 className="font-semibold text-lg mb-1">{category.title}</h3>
                        <p className="text-gray-600 text-sm">{category.job_count} jobs available</p>
                      </div>
                    </div>
                  </Link>
                </motion.div>
              ))}
            </motion.div>
          )}
          
          {/* Category Pagination */}
          {jobCategories.length > categoriesPerPage && (
            <motion.div 
              className="mt-8 flex justify-center"
              initial={{ opacity: 0 }}
              whileInView={{ opacity: 1 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
            >
              <nav className="flex items-center gap-2">
                <button
                  onClick={() => handleCategoryPageChange(currentCategoryPage - 1)}
                  disabled={currentCategoryPage === 1}
                  className={`p-2 rounded-lg border ${
                    currentCategoryPage === 1
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronLeft className="h-5 w-5" />
                </button>

                {Array.from({ length: totalCategoryPages }, (_, i) => i + 1).map((page) => (
                  <button
                    key={page}
                    onClick={() => handleCategoryPageChange(page)}
                    className={`px-4 py-2 rounded-lg border ${
                      currentCategoryPage === page
                        ? 'bg-primary-50 text-primary-600 border-primary-200'
                        : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                    }`}
                  >
                    {page}
                  </button>
                ))}

                <button
                  onClick={() => handleCategoryPageChange(currentCategoryPage + 1)}
                  disabled={currentCategoryPage === totalCategoryPages}
                  className={`p-2 rounded-lg border ${
                    currentCategoryPage === totalCategoryPages
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronRight className="h-5 w-5" />
                </button>
              </nav>
            </motion.div>
          )}
          
          <motion.div 
            className="text-center mt-12"
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
          >
            <Link to="/jobs" className="btn-secondary inline-flex items-center">
              Browse All Categories
              <ChevronRight className="ml-2 h-4 w-4" />
            </Link>
          </motion.div>
        </div>
      </section>
      
      {/* Featured Jobs Section */}
      <section id="featured-jobs" className="section-padding">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div 
            className="text-center mb-12"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Featured Jobs</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Discover opportunities from top companies that are hiring right now
            </p>
          </motion.div>
          
          {loading.jobs ? (
            <div className="text-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500 mx-auto"></div>
            </div>
          ) : error.jobs ? (
            <div className="text-center py-12 text-red-600">
              {error.jobs}
            </div>
          ) : currentFeaturedJobs.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-gray-600">No featured jobs available</p>
            </div>
          ) : (
            <motion.div 
              className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"
              variants={staggerContainer}
              initial="initial"
              whileInView="animate"
              viewport={{ once: true }}
            >
              {currentFeaturedJobs.map((job) => (
                <FeaturedJobCard key={job.id} job={job} />
              ))}
            </motion.div>
          )}
          
          {/* Pagination */}
          {featuredJobs.length > jobsPerPage && (
            <motion.div 
              className="mt-8 flex justify-center"
              initial={{ opacity: 0 }}
              whileInView={{ opacity: 1 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
            >
              <nav className="flex items-center gap-2">
                <button
                  onClick={() => handleJobPageChange(currentJobPage - 1)}
                  disabled={currentJobPage === 1}
                  className={`p-2 rounded-lg border ${
                    currentJobPage === 1
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronLeft className="h-5 w-5" />
                </button>

                {Array.from({ length: totalJobPages }, (_, i) => i + 1).map((page) => (
                  <button
                    key={page}
                    onClick={() => handleJobPageChange(page)}
                    className={`px-4 py-2 rounded-lg border ${
                      currentJobPage === page
                        ? 'bg-primary-50 text-primary-600 border-primary-200'
                        : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                    }`}
                  >
                    {page}
                  </button>
                ))}

                <button
                  onClick={() => handleJobPageChange(currentJobPage + 1)}
                  disabled={currentJobPage === totalJobPages}
                  className={`p-2 rounded-lg border ${
                    currentJobPage === totalJobPages
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronRight className="h-5 w-5" />
                </button>
              </nav>
            </motion.div>
          )}
          
          <motion.div 
            className="text-center mt-12"
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
          >
            <Link to="/jobs" className="btn-secondary inline-flex items-center">
              View All Jobs
              <ChevronRight className="ml-2 h-4 w-4" />
            </Link>
          </motion.div>
        </div>
      </section>
      
      {/* Top Companies Section */}
      <section id="top-companies" className="bg-gray-50 section-padding">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div 
            className="text-center mb-12"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Top Companies Hiring</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Connect with industry leaders and find your next career opportunity
            </p>
          </motion.div>
          
          {loading.companies ? (
            <div className="text-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500 mx-auto"></div>
            </div>
          ) : error.companies ? (
            <div className="text-center py-12 text-red-600">
              {error.companies}
            </div>
          ) : currentCompanies.length === 0 ? (
            <div className="text-center py-12">
              <p className="text-gray-600">No companies available</p>
            </div>
          ) : (
            <motion.div 
              className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6"
              variants={staggerContainer}
              initial="initial"
              whileInView="animate"
              viewport={{ once: true }}
            >
              {currentCompanies.map((company) => (
                <motion.div
                  key={company.id}
                  className="bg-white rounded-xl p-6 flex items-center justify-center card-hover"
                  variants={fadeIn}
                  whileHover={{ y: -5 }}
                  transition={{ type: "spring", stiffness: 300 }}
                >
                  <Link to={`/companies/${company.id}`} className="text-center">
                    <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-3">
                      {company.logo ? (
                        <img 
                          src={company.logo} 
                          alt={company.name} 
                          className="w-12 h-12 object-contain"
                        />
                      ) : (
                        <span className="text-xl font-bold">{company.name.charAt(0)}</span>
                      )}
                    </div>
                    <p className="font-medium">{company.name}</p>
                    <p className="text-sm text-gray-500">{company.total_jobs} jobs</p>
                  </Link>
                </motion.div>
              ))}
            </motion.div>
          )}

          {/* Company Pagination */}
          {topCompanies.length > companiesPerPage && (
            <motion.div 
              className="mt-8 flex justify-center"
              initial={{ opacity: 0 }}
              whileInView={{ opacity: 1 }}
              viewport={{ once: true }}
              transition={{ delay: 0.2 }}
            >
              <nav className="flex items-center gap-2">
                <button
                  onClick={() => handleCompanyPageChange(currentCompanyPage - 1)}
                  disabled={currentCompanyPage === 1}
                  className={`p-2 rounded-lg border ${
                    currentCompanyPage === 1
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronLeft className="h-5 w-5" />
                </button>

                {Array.from({ length: totalCompanyPages }, (_, i) => i + 1).map((page) => (
                  <button
                    key={page}
                    onClick={() => handleCompanyPageChange(page)}
                    className={`px-4 py-2 rounded-lg border ${
                      currentCompanyPage === page
                        ? 'bg-primary-50 text-primary-600 border-primary-200'
                        : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                    }`}
                  >
                    {page}
                  </button>
                ))}

                <button
                  onClick={() => handleCompanyPageChange(currentCompanyPage + 1)}
                  disabled={currentCompanyPage === totalCompanyPages}
                  className={`p-2 rounded-lg border ${
                    currentCompanyPage === totalCompanyPages
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronRight className="h-5 w-5" />
                </button>
              </nav>
            </motion.div>
          )}
          
          <motion.div 
            className="text-center mt-12"
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            viewport={{ once: true }}
            transition={{ delay: 0.2 }}
          >
            <Link to="/companies" className="btn-secondary inline-flex items-center">
              View All Companies
              <ChevronRight className="ml-2 h-4 w-4" />
            </Link>
          </motion.div>
        </div>
      </section>
      
      {/* Features Section */}
      <section className="section-padding">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div 
            className="text-center mb-16"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Why Choose JobPortal</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              We're dedicated to helping you find the perfect job match
            </p>
          </motion.div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <FeatureCard 
              icon={<Zap className="h-6 w-6" />}
              title="Smart Job Matching"
              description="Our AI-powered system connects you with the most relevant opportunities based on your skills and preferences."
            />
            <FeatureCard 
              icon={<Globe className="h-6 w-6" />}
              title="Remote Opportunities"
              description="Access thousands of remote job opportunities from companies worldwide."
            />
            <FeatureCard 
              icon={<Bookmark className="h-6 w-6" />}
              title="Job Alerts"
              description="Get notified instantly when new jobs matching your preferences are posted."
            />
            <FeatureCard 
              icon={<ThumbsUp className="h-6 w-6" />}
              title="Verified Companies"
              description="All companies and job listings are verified to ensure quality and legitimacy."
            />
          </div>
        </div>
      </section>
      
      {/* CTA Section */}
      <section className="section-padding bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div 
            className="bg-gradient-to-r from-primary-600 to-secondary-600 rounded-2xl overflow-hidden"
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
          >
            <div className="px-6 py-12 md:p-12 text-center md:text-left md:flex md:items-center md:justify-between">
              <div className="md:w-2/3 mb-8 md:mb-0">
                <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
                  Ready to take the next step in your career?
                </h2>
                <p className="text-white text-opacity-90 text-lg">
                  Join thousands of professionals who've found their dream jobs through JobPortal
                </p>
              </div>
              <div className="flex flex-col sm:flex-row gap-4">
                <Link to="/jobs" className="btn-white">
                  Search Jobs
                </Link>
                <Link to="/companies" className="btn-outline-white">
                  Browse Companies
                </Link>
              </div>
            </div>
          </motion.div>
        </div>
      </section>
    </div>
  );
};

// Featured Job Card Component
const FeaturedJobCard = ({ job }: { job: FeaturedJob }) => {
  return (
    <motion.div 
      className="card-gradient bg-white rounded-xl overflow-hidden border border-gray-100"
      variants={fadeIn}
      whileHover={{ y: -5 }}
      transition={{ type: "spring", stiffness: 300 }}
    >
      <div className="p-6">
        <div className="flex items-start justify-between mb-4">
          <div className="flex items-center">
            <div className="w-12 h-12 bg-gray-100 rounded-md flex items-center justify-center mr-4">
              {job.company_logo ? (
                <img 
                  src={job.company_logo} 
                  alt={job.company} 
                  className="w-8 h-8 object-contain"
                />
              ) : (
                <span className="text-lg font-bold">{job.company.charAt(0)}</span>
              )}
            </div>
            <div>
              <h3 className="font-semibold text-lg">{job.title}</h3>
              <p className="text-gray-600 text-sm">{job.company}</p>
            </div>
          </div>
          <div>
            <span className="inline-block px-3 py-1 bg-primary-50 text-primary-600 rounded-full text-xs font-medium">
              {job.type}
            </span>
          </div>
        </div>
        
        <div className="space-y-2 mb-4">
          <div className="flex items-center text-gray-500 text-sm">
            <MapPin className="h-4 w-4 mr-2" />
            <span>{job.location}</span>
          </div>
          <div className="flex items-center text-gray-500 text-sm">
            <Clock className="h-4 w-4 mr-2" />
            <span>{job.posted_at}</span>
          </div>
          <div className="flex items-center text-gray-500 text-sm">
            <DollarSign className="h-4 w-4 mr-2" />
            <span>{job.salary}</span>
          </div>
        </div>
        
        <div className="pt-4 border-t border-gray-100 flex justify-between items-center">
          <div className="flex flex-wrap gap-2">
            {job.tags.slice(0, 3).map((tag, i) => (
              <span key={i} className="inline-block px-2 py-1 bg-gray-100 rounded-md text-xs">
                {tag}
              </span>
            ))}
          </div>
          <Link 
            to={`/jobs/${job.id}`} 
            className="text-primary-600 hover:text-primary-700 font-medium text-sm flex items-center"
          >
            View Job
            <ChevronRight className="ml-1 h-4 w-4" />
          </Link>
        </div>
      </div>
    </motion.div>
  );
};

// Feature Card Component
const FeatureCard = ({ icon, title, description }: { icon: React.ReactNode, title: string, description: string }) => {
  return (
    <motion.div 
      className="bg-white rounded-xl p-8 card-hover"
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5 }}
      whileHover={{ y: -5 }}
    >
      <div className="inline-flex items-center justify-center w-12 h-12 rounded-lg bg-primary-50 text-primary-600 mb-5">
        {icon}
      </div>
      <h3 className="text-xl font-bold mb-3">{title}</h3>
      <p className="text-gray-600">{description}</p>
    </motion.div>
  );
};

export default Home;