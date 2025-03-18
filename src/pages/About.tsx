import React from 'react';
import { motion } from 'framer-motion';
import { Users, Target, Award, Heart, ChevronRight, Globe, Shield, Zap } from 'lucide-react';
import { Link } from 'react-router-dom';

const fadeIn = {
  initial: { opacity: 0, y: 20 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.5 }
};

const About = () => {
  return (
    <div className="pt-24">
      {/* Hero Section */}
      <section className="relative overflow-hidden bg-gradient-to-b from-primary-50 to-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center max-w-4xl mx-auto"
          >
            <h1 className="text-5xl md:text-6xl font-bold mb-6 gradient-text">
              Connecting Talent with Opportunity
            </h1>
            <p className="text-xl text-gray-600 mb-8">
              We're on a mission to revolutionize the way people find and secure their dream jobs.
              Our platform brings together job seekers and employers in a seamless, efficient way.
            </p>
          </motion.div>
        </div>
      </section>

      {/* Mission Section */}
      <section className="py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center"
          >
            <div>
              <h2 className="text-3xl md:text-4xl font-bold mb-6">Our Mission</h2>
              <p className="text-lg text-gray-600 mb-6">
                At JobPortal, we believe that finding the right job should be straightforward and stress-free. 
                Our platform is designed to make the job search process more efficient, transparent, and successful for both job seekers and employers.
              </p>
              <p className="text-lg text-gray-600">
                We're committed to providing innovative tools and resources that help connect talented individuals 
                with companies that value their skills and potential.
              </p>
            </div>
            <div className="grid grid-cols-2 gap-6">
              <StatsCard number="1M+" label="Active Users" />
              <StatsCard number="50K+" label="Companies" />
              <StatsCard number="200K+" label="Jobs Posted" />
              <StatsCard number="500K+" label="Successful Hires" />
            </div>
          </motion.div>
        </div>
      </section>

      {/* Values Section */}
      <section className="py-16 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="text-center mb-16"
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-6">Our Core Values</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              These principles guide everything we do and help us create the best possible experience for our users.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <ValueCard
              icon={<Globe className="h-8 w-8" />}
              title="Global Reach"
              description="Connecting talent with opportunities worldwide, breaking geographical barriers."
            />
            <ValueCard
              icon={<Shield className="h-8 w-8" />}
              title="Trust & Security"
              description="Maintaining the highest standards of privacy and data protection for our users."
            />
            <ValueCard
              icon={<Zap className="h-8 w-8" />}
              title="Innovation"
              description="Continuously improving our platform with cutting-edge technology and features."
            />
            <ValueCard
              icon={<Heart className="h-8 w-8" />}
              title="User-Centric"
              description="Putting our users' needs first in everything we design and build."
            />
          </div>
        </div>
      </section>

      {/* Team Section */}
      <section className="py-16 md:py-24">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="text-center mb-16"
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-6">Meet Our Leadership</h2>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Our team of dedicated professionals is committed to transforming the job search experience.
            </p>
          </motion.div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <TeamMemberCard
              name="John Smith"
              role="Chief Executive Officer"
              image="/team/ceo.jpg"
              bio="With over 15 years of experience in tech and recruitment, John leads our mission to revolutionize job search."
            />
            <TeamMemberCard
              name="Sarah Johnson"
              role="Chief Technology Officer"
              image="/team/cto.jpg"
              bio="Sarah brings 12 years of engineering leadership experience, driving our platform's innovation and growth."
            />
            <TeamMemberCard
              name="Michael Chen"
              role="Chief Product Officer"
              image="/team/cpo.jpg"
              bio="Michael's 10 years in product management helps shape our user-centric approach to feature development."
            />
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16 bg-gradient-to-r from-primary-600 to-secondary-600">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.5 }}
            className="text-center text-white"
          >
            <h2 className="text-3xl md:text-4xl font-bold mb-6">Ready to Start Your Journey?</h2>
            <p className="text-xl mb-8 text-white text-opacity-90">
              Join millions of professionals who've found their dream jobs through JobPortal
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Link to="/jobs" className="btn-white">
                Browse Jobs
              </Link>
              <Link to="/contact" className="btn-outline-white">
                Contact Us
              </Link>
            </div>
          </motion.div>
        </div>
      </section>
    </div>
  );
};

const StatsCard = ({ number, label }: { number: string; label: string }) => {
  return (
    <motion.div
      whileHover={{ y: -5 }}
      className="bg-white rounded-xl p-6 text-center shadow-sm"
    >
      <h3 className="text-3xl font-bold text-primary-600 mb-2">{number}</h3>
      <p className="text-gray-600">{label}</p>
    </motion.div>
  );
};

const ValueCard = ({ icon, title, description }: { icon: React.ReactNode; title: string; description: string }) => {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5 }}
      whileHover={{ y: -5 }}
      className="bg-white rounded-xl p-8 shadow-sm"
    >
      <div className="inline-flex items-center justify-center w-12 h-12 rounded-lg bg-primary-50 text-primary-600 mb-6">
        {icon}
      </div>
      <h3 className="text-xl font-bold mb-3">{title}</h3>
      <p className="text-gray-600">{description}</p>
    </motion.div>
  );
};

const TeamMemberCard = ({ name, role, image, bio }: { name: string; role: string; image: string; bio: string }) => {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.5 }}
      whileHover={{ y: -5 }}
      className="bg-white rounded-xl overflow-hidden shadow-sm"
    >
      <div className="aspect-w-4 aspect-h-3 bg-gray-100">
        <img src={image} alt={name} className="object-cover" onError={(e) => {
          const target = e.target as HTMLImageElement;
          target.src = 'https://via.placeholder.com/400x300?text=Team+Member';
        }} />
      </div>
      <div className="p-6">
        <h3 className="text-xl font-bold mb-1">{name}</h3>
        <p className="text-primary-600 mb-4">{role}</p>
        <p className="text-gray-600">{bio}</p>
      </div>
    </motion.div>
  );
};

export default About; 