import React, { useState, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { Briefcase, Building2, User, Menu, X, Search, CreditCard, Mail, Home, Info, Book, UserPlus } from 'lucide-react';

const Navbar = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const location = useLocation();
  
  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 10);
    };
    
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);
  
  const isActive = (path: string) => location.pathname === path;

  const navLinks = [
    { path: '/', label: 'Home', icon: <Home className="h-5 w-5 mr-1" /> },
    { path: '/jobs', label: 'Jobs', icon: <Briefcase className="h-5 w-5 mr-1" /> },
    { path: '/pricing', label: 'Pricing', icon: <CreditCard className="h-5 w-5 mr-1" /> },
    { path: '/about', label: 'About', icon: <Info className="h-5 w-5 mr-1" /> },
    { path: '/blog', label: 'Blog', icon: <Book className="h-5 w-5 mr-1" /> },
    { path: '/contact', label: 'Contact', icon: <Mail className="h-5 w-5 mr-1" />},
    { path: '/login', label: 'Login', icon: <User className="h-5 w-5 mr-1" />},
    { path: '/register', label: 'Register', icon: <UserPlus className="h-5 w-5 mr-1" />}
  ];

  return (
    <>
      <motion.nav 
        initial={{ y: -100 }}
        animate={{ y: 0 }}
        className={`fixed w-full z-50 border-b glass-effect transition-all duration-300 ${
          isScrolled ? 'border-gray-200 shadow-lg' : 'border-transparent'
        }`}
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <Link to="/" className="flex items-center">
                <motion.div 
                  whileHover={{ rotate: 10 }}
                  transition={{ type: "spring", stiffness: 400, damping: 10 }}
                >
                  <Briefcase className="h-8 w-8 text-primary-600" />
                </motion.div>
                <span className="ml-2 text-xl font-bold gradient-text">JobPortal</span>
              </Link>
            </div>
            
            {/* Desktop Navigation */}
            <div className="hidden md:flex items-center space-x-1">
              <div className="relative mx-4">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <Search className="h-4 w-4 text-gray-400" />
                </div>
                <motion.input
                  whileFocus={{ width: '300px', boxShadow: '0 0 0 3px rgba(99, 102, 241, 0.2)' }}
                  transition={{ type: "spring", stiffness: 300, damping: 20 }}
                  type="text"
                  placeholder="Search jobs..."
                  className="pl-10 pr-4 py-2 w-64 rounded-full text-sm border border-gray-200 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                />
              </div>
              
              {navLinks.map((link) => (
                <NavLink 
                  key={link.path} 
                  to={link.path} 
                  isActive={isActive(link.path)}
                >
                  {link.icon}
                  {link.label}
                </NavLink>
              ))}
            </div>
            
            {/* Mobile menu button */}
            <div className="md:hidden flex items-center">
              <motion.button
                whileTap={{ scale: 0.9 }}
                onClick={() => setIsMenuOpen(!isMenuOpen)}
                className="inline-flex items-center justify-center p-2 rounded-md text-gray-700 hover:text-primary-600 focus:outline-none"
              >
                {isMenuOpen ? (
                  <X className="h-6 w-6" />
                ) : (
                  <Menu className="h-6 w-6" />
                )}
              </motion.button>
            </div>
          </div>
        </div>
      </motion.nav>
      
      {/* Mobile menu */}
      <AnimatePresence>
        {isMenuOpen && (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: 'auto' }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ type: "spring", stiffness: 300, damping: 30 }}
            className="md:hidden fixed top-16 inset-x-0 z-50 glass-effect border-b border-gray-200"
          >
            <div className="px-2 pt-2 pb-3 space-y-1">
              {navLinks.map((link) => (
                <MobileNavLink 
                  key={link.path} 
                  to={link.path} 
                  isActive={isActive(link.path)}
                  onClick={() => setIsMenuOpen(false)}
                >
                  {link.icon}
                  {link.label}
                </MobileNavLink>
              ))}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
};

// Desktop Navigation Link
const NavLink = ({ 
  to, 
  children, 
  isActive 
}: { 
  to: string; 
  children: React.ReactNode; 
  isActive: boolean 
}) => {
  return (
    <Link 
      to={to} 
      className={`relative flex items-center px-3 py-2 rounded-md text-sm font-medium transition-colors ${
        isActive 
          ? 'text-primary-600 bg-primary-50' 
          : 'text-gray-700 hover:text-primary-600 hover:bg-gray-50'
      }`}
    >
      {children}
      {isActive && (
        <motion.div
          layoutId="navbar-indicator"
          className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary-600"
          transition={{ type: "spring", stiffness: 500, damping: 30 }}
        />
      )}
    </Link>
  );
};

// Mobile Navigation Link
const MobileNavLink = ({ 
  to, 
  children, 
  isActive,
  onClick
}: { 
  to: string; 
  children: React.ReactNode; 
  isActive: boolean;
  onClick: () => void;
}) => {
  return (
    <motion.div
      whileHover={{ x: 5 }}
      whileTap={{ scale: 0.98 }}
    >
      <Link
        to={to}
        onClick={onClick}
        className={`flex items-center px-3 py-3 rounded-md text-base font-medium ${
          isActive
            ? 'text-primary-600 bg-primary-50'
            : 'text-gray-700 hover:text-primary-600 hover:bg-gray-50'
        }`}
      >
        {children}
      </Link>
    </motion.div>
  );
};

export default Navbar;