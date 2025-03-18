import { useState, useEffect, ChangeEvent } from 'react';
import { motion } from 'framer-motion';
import { MapPin, Clock, DollarSign, Briefcase, Search, Filter, Grid, List, Sliders, ChevronLeft, ChevronRight } from 'lucide-react';
import { useAppContext } from '../config/AppContext';

interface Job {
  id: number;
  title: string;
  description?: string;
  company_name?: string;
  location?: string;
  salary?: string;
  posted_at?: string;
  user_id?: number;
  category_id?: number;
  type?: string;
  [key: string]: any;
}

const Jobs = () => {
  const { jobs, categories, loading, error } = useAppContext();
  const [filteredJobs, setFilteredJobs] = useState<Job[]>([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('');
  const [selectedType, setSelectedType] = useState('');
  const [selectedLocation, setSelectedLocation] = useState('');
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  const [viewMode, setViewMode] = useState<'grid' | 'list'>('grid');
  
  // Pagination states
  const [currentPage, setCurrentPage] = useState(1);
  const jobsPerPage = 12;

  // Apply filters when jobs, searchTerm, or selectedCategory changes
  useEffect(() => {
    if (!jobs) return;
    
    let filtered = [...jobs] as Job[];
    
    // Apply search filter
    if (searchTerm) {
      filtered = filtered.filter(job => 
        job.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        job.description?.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }
    
    // Apply category filter
    if (selectedCategory) {
      filtered = filtered.filter(job => job.category_id === parseInt(selectedCategory));
    }
    
    // Apply job type filter
    if (selectedType) {
      filtered = filtered.filter(job => job.type === selectedType);
    }
    
    // Apply location filter
    if (selectedLocation) {
      filtered = filtered.filter(job => 
        job.location?.toLowerCase().includes(selectedLocation.toLowerCase())
      );
    }
    
    setFilteredJobs(filtered);
  }, [jobs, searchTerm, selectedCategory, selectedType, selectedLocation]);

  // Handle search input change
  const handleSearchChange = (e: ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };
  
  // Handle category filter change
  const handleCategoryChange = (e: ChangeEvent<HTMLSelectElement>) => {
    setSelectedCategory(e.target.value);
  };
  
  // Handle job type filter change
  const handleTypeChange = (e: ChangeEvent<HTMLSelectElement>) => {
    setSelectedType(e.target.value);
  };
  
  // Handle location filter change
  const handleLocationChange = (e: ChangeEvent<HTMLInputElement>) => {
    setSelectedLocation(e.target.value);
  };
  
  // Toggle sidebar
  const toggleSidebar = () => {
    setIsSidebarOpen(!isSidebarOpen);
  };

  // Calculate pagination values
  const indexOfLastJob = currentPage * jobsPerPage;
  const indexOfFirstJob = indexOfLastJob - jobsPerPage;
  const currentJobs = filteredJobs.slice(indexOfFirstJob, indexOfLastJob);
  const totalPages = Math.ceil(filteredJobs.length / jobsPerPage);

  // Handle page change
  const handlePageChange = (pageNumber: number) => {
    setCurrentPage(pageNumber);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  return (
    <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
      <motion.div
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        className="mb-8"
      >
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-4xl font-bold gradient-text mb-4">Available Jobs</h1>
            <p className="text-gray-600">Discover your next career opportunity</p>
          </div>
          <div className="flex items-center gap-3">
            <button 
              onClick={toggleSidebar}
              className="p-2 rounded-lg border border-gray-200 hover:bg-gray-50 transition-colors"
              aria-label="Toggle filters"
            >
              <Sliders size={20} className="text-gray-700" />
            </button>
            <div className="flex items-center bg-white rounded-lg border border-gray-200 p-1">
              <button
                onClick={() => setViewMode('grid')}
                className={`p-2 rounded-md transition-colors ${viewMode === 'grid' ? 'bg-primary-100 text-primary-600' : 'text-gray-500 hover:bg-gray-50'}`}
                aria-label="Grid view"
              >
                <Grid size={18} />
              </button>
              <button
                onClick={() => setViewMode('list')}
                className={`p-2 rounded-md transition-colors ${viewMode === 'list' ? 'bg-primary-100 text-primary-600' : 'text-gray-500 hover:bg-gray-50'}`}
                aria-label="List view"
              >
                <List size={18} />
              </button>
            </div>
          </div>
        </div>
      </motion.div>

      <div className="flex gap-6">
        {/* Sidebar Filters */}
        <motion.div
          initial={{ width: isSidebarOpen ? 'auto' : 0, opacity: isSidebarOpen ? 1 : 0 }}
          animate={{ width: isSidebarOpen ? 'auto' : 0, opacity: isSidebarOpen ? 1 : 0 }}
          transition={{ duration: 0.3 }}
          className={`${isSidebarOpen ? 'w-72' : 'w-0'} overflow-hidden shrink-0`}
        >
          <div className="bg-white rounded-xl shadow-md p-6">
            <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center">
              <Filter className="h-5 w-5 mr-2 text-primary-500" />
              Filters
            </h2>
            
            <div className="space-y-6">
              <div>
                <label htmlFor="search" className="block text-sm font-medium text-gray-700 mb-2">
                  Search
                </label>
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" size={16} />
                  <input
                    type="text"
                    id="search"
                    placeholder="Search jobs..."
                    className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                    value={searchTerm}
                    onChange={handleSearchChange}
                  />
                </div>
              </div>
              
              <div>
                <label htmlFor="category" className="block text-sm font-medium text-gray-700 mb-2">
                  Category
                </label>
                <select
                  id="category"
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  value={selectedCategory}
                  onChange={handleCategoryChange}
                >
                  <option value="">All Categories</option>
                  {categories && categories.map(category => (
                    <option key={category.id} value={category.id}>{category.title}</option>
                  ))}
                </select>
              </div>
              
              <div>
                <label htmlFor="jobType" className="block text-sm font-medium text-gray-700 mb-2">
                  Job Type
                </label>
                <select
                  id="jobType"
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  value={selectedType}
                  onChange={handleTypeChange}
                >
                  <option value="">All Types</option>
                  <option value="full-time">Full-time</option>
                  <option value="part-time">Part-time</option>
                  <option value="contract">Contract</option>
                  <option value="freelance">Freelance</option>
                  <option value="internship">Internship</option>
                </select>
              </div>
              
              <div>
                <label htmlFor="location" className="block text-sm font-medium text-gray-700 mb-2">
                  Location
                </label>
                <input
                  type="text"
                  id="location"
                  placeholder="Filter by location..."
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
                  value={selectedLocation}
                  onChange={handleLocationChange}
                />
              </div>
              
              <button 
                onClick={() => {
                  setSearchTerm('');
                  setSelectedCategory('');
                  setSelectedType('');
                  setSelectedLocation('');
                }}
                className="w-full py-2 text-sm text-primary-600 hover:text-primary-700 hover:underline"
              >
                Clear All Filters
              </button>
            </div>
          </div>
        </motion.div>
        
        {/* Main Content */}
        <div className="flex-1">
          {/* Loading State */}
          {loading.jobs && (
            <div className="flex justify-center items-center py-12">
              <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary-500"></div>
            </div>
          )}

          {/* Error State */}
          {error.jobs && (
            <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-md mb-6">
              <p>Error loading jobs: {error.jobs}</p>
            </div>
          )}

          {/* No Results */}
          {!loading.jobs && filteredJobs && filteredJobs.length === 0 && (
            <div className="text-center py-12 bg-white rounded-xl shadow-md">
              <Briefcase className="mx-auto h-16 w-16 text-gray-400" />
              <h3 className="mt-4 text-lg font-medium text-gray-900">No jobs found</h3>
              <p className="mt-1 text-sm text-gray-500">Try adjusting your search or filter criteria</p>
            </div>
          )}

          {/* Job Listings */}
          <div className={`${viewMode === 'grid' ? 'grid grid-cols-1 md:grid-cols-2 gap-6' : 'grid gap-6'}`}>
            {currentJobs.map((job) => (
              <motion.div
                key={job.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                whileHover={{ scale: 1.02 }}
                className="bg-white rounded-xl p-6 shadow-md hover:shadow-xl transition-all duration-300"
              >
                <div className={`flex ${viewMode === 'list' ? 'items-start' : 'flex-col'} gap-4`}>
                  <div className={`${viewMode === 'list' ? 'w-16 h-16' : 'w-14 h-14 mb-2'} rounded-lg bg-primary-100 flex items-center justify-center shrink-0`}>
                    <Briefcase className={`${viewMode === 'list' ? 'h-8 w-8' : 'h-6 w-6'} text-primary-500`} />
                  </div>
                  <div className="flex-1">
                    <h2 className="text-xl font-semibold text-gray-900">{job.title}</h2>
                    <p className="text-gray-600">
                      {job.company_name || "Company Name"}
                    </p>
                    <div className="mt-4 flex flex-wrap gap-4">
                      <div className="flex items-center text-gray-500">
                        <MapPin className="h-4 w-4 mr-1" />
                        {job.location || "Remote"}
                      </div>
                      <div className="flex items-center text-gray-500">
                        <DollarSign className="h-4 w-4 mr-1" />
                        {job.salary || "Competitive"}
                      </div>
                      <div className="flex items-center text-gray-500">
                        <Clock className="h-4 w-4 mr-1" />
                        {job.posted_at || "Recently"}
                      </div>
                    </div>
                    {job.description && (
                      <p className="mt-3 text-gray-600 line-clamp-2">{job.description}</p>
                    )}
                    <div className={`${viewMode === 'list' ? 'mt-4' : 'mt-6'}`}>
                      <button className="btn-primary w-full sm:w-auto">Apply Now</button>
                    </div>
                  </div>
                  {viewMode === 'list' && (
                    <div className="hidden sm:block">
                      <button className="btn-primary">Apply Now</button>
                    </div>
                  )}
                </div>
              </motion.div>
            ))}
          </div>

          {/* Pagination */}
          {filteredJobs.length > jobsPerPage && (
            <div className="mt-8 flex justify-center">
              <nav className="flex items-center gap-2">
                <button
                  onClick={() => handlePageChange(currentPage - 1)}
                  disabled={currentPage === 1}
                  className={`p-2 rounded-lg border ${
                    currentPage === 1
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronLeft className="h-5 w-5" />
                </button>

                {Array.from({ length: totalPages }, (_, i) => i + 1).map((page) => (
                  <button
                    key={page}
                    onClick={() => handlePageChange(page)}
                    className={`px-4 py-2 rounded-lg border ${
                      currentPage === page
                        ? 'bg-primary-50 text-primary-600 border-primary-200'
                        : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                    }`}
                  >
                    {page}
                  </button>
                ))}

                <button
                  onClick={() => handlePageChange(currentPage + 1)}
                  disabled={currentPage === totalPages}
                  className={`p-2 rounded-lg border ${
                    currentPage === totalPages
                      ? 'text-gray-400 border-gray-200 cursor-not-allowed'
                      : 'text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  <ChevronRight className="h-5 w-5" />
                </button>
              </nav>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Jobs;