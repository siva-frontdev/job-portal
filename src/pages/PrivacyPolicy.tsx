import React from 'react';
import { motion } from 'framer-motion';
import { Shield, Lock, UserCheck, Eye, FileText, Bell, Settings, HelpCircle } from 'lucide-react';

const PrivacyPolicy = () => {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <section className="bg-gradient-to-b from-primary-50 to-white py-16 md:py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="text-center"
          >
            <h1 className="text-4xl md:text-5xl font-bold mb-6">Privacy Policy</h1>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              We are committed to protecting your privacy and ensuring the security of your personal information.
            </p>
          </motion.div>
        </div>
      </section>

      {/* Main Content */}
      <section className="py-12 md:py-16">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="bg-white rounded-2xl shadow-sm p-8 md:p-12 space-y-12"
          >
            {/* Last Updated */}
            <div className="text-gray-500 text-sm">
              Last Updated: {new Date().toLocaleDateString()}
            </div>

            {/* Introduction */}
            <section>
              <h2 className="text-2xl font-bold mb-4">Introduction</h2>
              <p className="text-gray-600">
                This Privacy Policy explains how JobPortal ("we", "our", or "us") collects, uses, and protects your personal information when you use our website and services.
              </p>
            </section>

            {/* Information We Collect */}
            <section>
              <div className="flex items-center mb-4">
                <Shield className="h-6 w-6 text-primary-600 mr-2" />
                <h2 className="text-2xl font-bold">Information We Collect</h2>
              </div>
              <div className="space-y-4 text-gray-600">
                <p>We collect information that you provide directly to us, including:</p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Name and contact information</li>
                  <li>Professional experience and qualifications</li>
                  <li>Resume and cover letters</li>
                  <li>Job preferences and search history</li>
                  <li>Account credentials</li>
                </ul>
              </div>
            </section>

            {/* How We Use Your Information */}
            <section>
              <div className="flex items-center mb-4">
                <Lock className="h-6 w-6 text-primary-600 mr-2" />
                <h2 className="text-2xl font-bold">How We Use Your Information</h2>
              </div>
              <div className="space-y-4 text-gray-600">
                <p>We use your information to:</p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Provide and improve our services</li>
                  <li>Match you with relevant job opportunities</li>
                  <li>Communicate with you about your account and updates</li>
                  <li>Ensure the security of our platform</li>
                  <li>Comply with legal obligations</li>
                </ul>
              </div>
            </section>

            {/* Data Security */}
            <section>
              <div className="flex items-center mb-4">
                <UserCheck className="h-6 w-6 text-primary-600 mr-2" />
                <h2 className="text-2xl font-bold">Data Security</h2>
              </div>
              <p className="text-gray-600">
                We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.
              </p>
            </section>

            {/* Your Rights */}
            <section>
              <div className="flex items-center mb-4">
                <Eye className="h-6 w-6 text-primary-600 mr-2" />
                <h2 className="text-2xl font-bold">Your Rights</h2>
              </div>
              <div className="space-y-4 text-gray-600">
                <p>You have the right to:</p>
                <ul className="list-disc pl-6 space-y-2">
                  <li>Access your personal information</li>
                  <li>Correct inaccurate information</li>
                  <li>Request deletion of your information</li>
                  <li>Object to processing of your information</li>
                  <li>Withdraw consent</li>
                </ul>
              </div>
            </section>

            {/* Contact Us */}
            <section>
              <div className="flex items-center mb-4">
                <HelpCircle className="h-6 w-6 text-primary-600 mr-2" />
                <h2 className="text-2xl font-bold">Contact Us</h2>
              </div>
              <p className="text-gray-600">
                If you have any questions about this Privacy Policy, please contact us at:
                <br />
                Email: privacy@jobportal.com
                <br />
                Address: 123 Privacy Street, Security City, 12345
              </p>
            </section>
          </motion.div>
        </div>
      </section>
    </div>
  );
};

export default PrivacyPolicy; 