import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Users, MapPin, Briefcase, Search, Filter, ChevronLeft, ChevronRight } from 'lucide-react';

const Companies = () => {
  const [currentPage, setCurrentPage] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedIndustry, setSelectedIndustry] = useState('All');
  const companiesPerPage = 8;

  const companies = [
    {
      id: 1,
      name: "TechCorp Solutions",
      industry: "Information Technology",
      location: "San Francisco, CA",
      employees: "1000-5000",
      openings: 25,
      logo: "https://images.unsplash.com/photo-1549924231-f129b911e442?w=128&h=128&fit=crop",
      description: "Leading provider of enterprise software solutions",
      founded: "2010"
    },
    {
      id: 2,
      name: "Global Finance Group",
      industry: "Financial Services",
      location: "New York, NY",
      employees: "5000-10000",
      openings: 42,
      logo: "https://images.unsplash.com/photo-1552664730-d307ca884978?w=128&h=128&fit=crop",
      description: "International financial services and investment banking",
      founded: "1995"
    },
    {
      id: 3,
      name: "HealthCare Plus",
      industry: "Healthcare & Medical",
      location: "Boston, MA",
      employees: "2000-5000",
      openings: 18,
      logo: "https://images.unsplash.com/photo-1550831107-1553da8c8464?w=128&h=128&fit=crop",
      description: "Innovative healthcare solutions and medical research",
      founded: "2005"
    },
    {
      id: 4,
      name: "EcoEnergy Innovations",
      industry: "Renewable Energy",
      location: "Austin, TX",
      employees: "500-1000",
      openings: 15,
      logo: "https://images.unsplash.com/photo-1561489413-985b06da5bee?w=128&h=128&fit=crop",
      description: "Sustainable energy solutions for a greener future",
      founded: "2015"
    },
    {
      id: 5,
      name: "Digital Marketing Pro",
      industry: "Marketing & Advertising",
      location: "Los Angeles, CA",
      employees: "100-500",
      openings: 12,
      logo: "https://images.unsplash.com/photo-1571844307-851c6d86f3f3?w=128&h=128&fit=crop",
      description: "Digital marketing strategies for modern businesses",
      founded: "2018"
    },
    {
      id: 6,
      name: "CloudNet Systems",
      industry: "Cloud Computing",
      location: "Seattle, WA",
      employees: "1000-5000",
      openings: 30,
      logo: "https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=128&h=128&fit=crop",
      description: "Cloud infrastructure and computing solutions",
      founded: "2012"
    },
    {
      id: 7,
      name: "FoodTech Delivery",
      industry: "Food & Technology",
      location: "Chicago, IL",
      employees: "500-1000",
      openings: 22,
      logo: "https://images.unsplash.com/photo-1567361808960-dec9cb578182?w=128&h=128&fit=crop",
      description: "Innovative food delivery technology platform",
      founded: "2017"
    },
    {
      id: 8,
      name: "AI Research Labs",
      industry: "Artificial Intelligence",
      location: "Cambridge, MA",
      employees: "100-500",
      openings: 8,
      logo: "https://images.unsplash.com/photo-1573164713-985b06da5bee?w=128&h=128&fit=crop",
      description: "Cutting-edge AI research and development",
      founded: "2019"
    },
    {
      id: 9,
      name: "Retail Solutions Inc",
      industry: "Retail Technology",
      location: "Atlanta, GA",
      employees: "1000-2000",
      openings: 16,
      logo: "https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=128&h=128&fit=crop",
      description: "Modern retail technology solutions",
      founded: "2014"
    },
    {
      id: 10,
      name: "BioTech Research",
      industry: "Biotechnology",
      location: "San Diego, CA",
      employees: "500-1000",
      openings: 20,
      logo: "https://images.unsplash.com/photo-1563986768609-322da13575f3?w=128&h=128&fit=crop",
      description: "Advanced biotechnology research and development",
      founded: "2008"
    },
    {
      id: 11,
      name: "Smart Home Tech",
      industry: "Information Technology",
      location: "Portland, OR",
      employees: "200-500",
      openings: 14,
      logo: "https://images.unsplash.com/photo-1558402529-d2638a7023e9?w=128&h=128&fit=crop",
      description: "Smart home automation solutions",
      founded: "2016"
    },
    {
      id: 12,
      name: "Quantum Computing Co",
      industry: "Information Technology",
      location: "Boulder, CO",
      employees: "100-500",
      openings: 10,
      logo: "https://images.unsplash.com/photo-1573164713988-8665fc963095?w=128&h=128&fit=crop",
      description: "Quantum computing research and development",
      founded: "2020"
    }
  ];

  // Get unique industries for filter
  const industries = ['All', ...new Set(companies.map(company => company.industry))];

  // Filter companies based on search and industry
  const filteredCompanies = companies.filter(company => {
    const matchesSearch = company.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         company.location.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         company.description.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesIndustry = selectedIndustry === 'All' || company.industry === selectedIndustry;
    return matchesSearch && matchesIndustry;
  });

  // Pagination logic
  const indexOfLastCompany = currentPage * companiesPerPage;
  const indexOfFirstCompany = indexOfLastCompany - companiesPerPage;
  const currentCompanies = filteredCompanies.slice(indexOfFirstCompany, indexOfLastCompany);
  const totalPages = Math.ceil(filteredCompanies.length / companiesPerPage);

  // Reset to first page when filters change
  useEffect(() => {
    setCurrentPage(1);
  }, [searchQuery, selectedIndustry]);

  return (
    <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
      <motion.div
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        className="mb-12"
      >
        <h1 className="text-4xl font-bold gradient-text mb-4">Top Companies</h1>
        <p className="text-gray-600">Explore opportunities with leading companies</p>
      </motion.div>

      {/* Search and Filter Section */}
      <div className="mb-8 space-y-4 md:space-y-0 md:flex md:items-center md:justify-between">
        <div className="relative flex-1 max-w-xl">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
          <input
            type="text"
            placeholder="Search companies by name, location, or description..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="pl-10 pr-4 py-2 w-full rounded-lg border border-gray-200 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
          />
        </div>
        
        <div className="flex items-center space-x-4">
          <Filter className="text-gray-400 h-5 w-5" />
          <select
            value={selectedIndustry}
            onChange={(e) => setSelectedIndustry(e.target.value)}
            className="rounded-lg border border-gray-200 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
          >
            {industries.map(industry => (
              <option key={industry} value={industry}>
                {industry}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Results Summary */}
      <div className="mb-6 text-gray-600">
        Showing {currentCompanies.length} of {filteredCompanies.length} companies
      </div>

      {/* Companies Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {currentCompanies.map((company) => (
          <motion.div
            key={company.id}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            whileHover={{ scale: 1.03 }}
            className="bg-white rounded-xl p-6 shadow-md hover:shadow-xl transition-all duration-300"
          >
            <div className="flex items-center gap-4 mb-4">
              <img
                src={company.logo}
                alt={company.name}
                className="w-16 h-16 rounded-lg object-cover"
              />
              <div>
                <h2 className="text-xl font-semibold text-gray-900">{company.name}</h2>
                <p className="text-gray-600">{company.industry}</p>
              </div>
            </div>
            
            <p className="text-gray-600 mb-4">{company.description}</p>
            
            <div className="space-y-3">
              <div className="flex items-center text-gray-500">
                <MapPin className="h-4 w-4 mr-2" />
                {company.location}
              </div>
              <div className="flex items-center text-gray-500">
                <Users className="h-4 w-4 mr-2" />
                {company.employees} employees
              </div>
              <div className="flex items-center text-gray-500">
                <Briefcase className="h-4 w-4 mr-2" />
                {company.openings} open positions
              </div>
            </div>
            
            <button className="w-full btn-primary mt-6">
              View Company
            </button>
          </motion.div>
        ))}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="mt-8 flex items-center justify-center space-x-4">
          <button
            onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
            disabled={currentPage === 1}
            className="p-2 rounded-lg border border-gray-200 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
          >
            <ChevronLeft className="h-5 w-5" />
          </button>
          
          <div className="flex items-center space-x-2">
            {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
              <button
                key={page}
                onClick={() => setCurrentPage(page)}
                className={`px-4 py-2 rounded-lg ${
                  currentPage === page
                    ? 'bg-primary-500 text-white'
                    : 'text-gray-600 hover:bg-gray-50'
                }`}
              >
                {page}
              </button>
            ))}
          </div>

          <button
            onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
            disabled={currentPage === totalPages}
            className="p-2 rounded-lg border border-gray-200 disabled:opacity-50 disabled:cursor-not-allowed hover:bg-gray-50"
          >
            <ChevronRight className="h-5 w-5" />
          </button>
        </div>
      )}
    </div>
  );
};

export default Companies;