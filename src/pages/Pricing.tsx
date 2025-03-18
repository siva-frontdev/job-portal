import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Check, X, CreditCard, Zap, Users, Shield } from 'lucide-react';

const Pricing = () => {
  const [billingCycle, setBillingCycle] = useState<'monthly' | 'annual'>('monthly');
  
  const pricingPlans = [
    {
      name: 'Basic',
      description: 'Perfect for individuals and small teams',
      price: billingCycle === 'monthly' ? 29 : 290,
      features: [
        'Post up to 5 jobs',
        'Basic candidate filtering',
        'Email notifications',
        'Standard support',
      ],
      notIncluded: [
        'Advanced analytics',
        'Featured job listings',
        'Dedicated account manager',
      ],
      icon: <CreditCard className="h-10 w-10 text-primary-500" />,
      color: 'from-primary-400 to-primary-600',
    },
    {
      name: 'Pro',
      description: 'Ideal for growing businesses',
      price: billingCycle === 'monthly' ? 79 : 790,
      features: [
        'Post up to 20 jobs',
        'Advanced candidate filtering',
        'Email notifications',
        'Priority support',
        'Advanced analytics',
        'Featured job listings',
      ],
      notIncluded: [
        'Dedicated account manager',
      ],
      icon: <Zap className="h-10 w-10 text-secondary-500" />,
      color: 'from-secondary-400 to-secondary-600',
      popular: true,
    },
    {
      name: 'Enterprise',
      description: 'For large organizations with complex needs',
      price: billingCycle === 'monthly' ? 199 : 1990,
      features: [
        'Unlimited job postings',
        'Advanced candidate filtering',
        'Email notifications',
        'Premium support',
        'Advanced analytics',
        'Featured job listings',
        'Dedicated account manager',
      ],
      notIncluded: [],
      icon: <Users className="h-10 w-10 text-indigo-500" />,
      color: 'from-indigo-400 to-indigo-600',
    },
  ];

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1,
      },
    },
  };

  const itemVariants = {
    hidden: { opacity: 0, y: 20 },
    visible: {
      opacity: 1,
      y: 0,
      transition: {
        type: 'spring',
        stiffness: 100,
        damping: 15,
      },
    },
  };

  return (
    <div className="pt-24 pb-16 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto">
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="text-center mb-16"
      >
        <h1 className="text-4xl md:text-5xl font-bold mb-4 gradient-text">Pricing Plans</h1>
        <p className="text-xl text-gray-600 max-w-3xl mx-auto">
          Choose the perfect plan for your recruitment needs
        </p>
        
        <motion.div 
          className="mt-8 inline-flex p-1 bg-gray-100 rounded-full"
          whileHover={{ scale: 1.02 }}
          whileTap={{ scale: 0.98 }}
        >
          <button
            className={`px-6 py-2 rounded-full text-sm font-medium transition-all ${
              billingCycle === 'monthly'
                ? 'bg-white shadow-md text-gray-800'
                : 'text-gray-600 hover:text-gray-800'
            }`}
            onClick={() => setBillingCycle('monthly')}
          >
            Monthly
          </button>
          <button
            className={`px-6 py-2 rounded-full text-sm font-medium transition-all ${
              billingCycle === 'annual'
                ? 'bg-white shadow-md text-gray-800'
                : 'text-gray-600 hover:text-gray-800'
            }`}
            onClick={() => setBillingCycle('annual')}
          >
            Annual <span className="text-green-500 font-semibold">Save 20%</span>
          </button>
        </motion.div>
      </motion.div>

      <motion.div
        variants={containerVariants}
        initial="hidden"
        animate="visible"
        className="grid grid-cols-1 md:grid-cols-3 gap-8"
      >
        {pricingPlans.map((plan, index) => (
          <motion.div
            key={plan.name}
            variants={itemVariants}
            whileHover={{ 
              y: -10,
              transition: { type: 'spring', stiffness: 300, damping: 20 }
            }}
            className={`relative rounded-2xl overflow-hidden bg-white shadow-xl border border-gray-100 ${
              plan.popular ? 'md:scale-105 z-10' : ''
            }`}
          >
            {plan.popular && (
              <div className="absolute top-0 right-0">
                <div className="bg-gradient-to-r from-secondary-500 to-secondary-600 text-white text-xs font-bold px-3 py-1 transform rotate-0 origin-top-right">
                  MOST POPULAR
                </div>
              </div>
            )}
            
            <div className={`h-2 bg-gradient-to-r ${plan.color}`}></div>
            
            <div className="p-6">
              <div className="flex items-center mb-4">
                <motion.div
                  initial={{ rotate: 0 }}
                  whileHover={{ rotate: 15 }}
                  transition={{ type: 'spring', stiffness: 300, damping: 10 }}
                >
                  {plan.icon}
                </motion.div>
                <h3 className="ml-3 text-2xl font-bold">{plan.name}</h3>
              </div>
              
              <p className="text-gray-600 mb-6">{plan.description}</p>
              
              <div className="mb-6">
                <span className="text-5xl font-bold">${plan.price}</span>
                <span className="text-gray-500 ml-2">/{billingCycle === 'monthly' ? 'month' : 'year'}</span>
              </div>
              
              <motion.button
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className={`w-full py-3 px-4 rounded-lg font-medium text-white mb-6 bg-gradient-to-r ${plan.color}`}
              >
                Get Started
              </motion.button>
              
              <div className="space-y-3">
                <p className="font-medium text-gray-800">Includes:</p>
                {plan.features.map((feature) => (
                  <div key={feature} className="flex items-start">
                    <Check className="h-5 w-5 text-green-500 mr-3 flex-shrink-0 mt-0.5" />
                    <span>{feature}</span>
                  </div>
                ))}
                
                {plan.notIncluded.length > 0 && (
                  <>
                    <p className="font-medium text-gray-800 mt-4">Not included:</p>
                    {plan.notIncluded.map((feature) => (
                      <div key={feature} className="flex items-start text-gray-500">
                        <X className="h-5 w-5 text-gray-400 mr-3 flex-shrink-0 mt-0.5" />
                        <span>{feature}</span>
                      </div>
                    ))}
                  </>
                )}
              </div>
            </div>
          </motion.div>
        ))}
      </motion.div>
      
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.6, duration: 0.5 }}
        className="mt-16 bg-gradient-to-r from-indigo-50 to-cyan-50 rounded-2xl p-8 md:p-12 shadow-lg"
      >
        <div className="flex flex-col md:flex-row items-center justify-between">
          <div className="mb-6 md:mb-0">
            <h3 className="text-2xl font-bold mb-2">Need a custom solution?</h3>
            <p className="text-gray-600 max-w-xl">
              Contact our sales team for a tailored plan that meets your specific requirements
            </p>
          </div>
          <motion.button
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            className="btn-primary flex items-center"
          >
            <Shield className="h-5 w-5 mr-2" />
            Contact Sales
          </motion.button>
        </div>
      </motion.div>
    </div>
  );
};

export default Pricing; 