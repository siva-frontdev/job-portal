# Job Portal Application

A modern job portal application built with React, TypeScript, Express, and
MySQL.

## Project Structure

- **Frontend**: React with TypeScript, Tailwind CSS, and Framer Motion
- **Backend**: Express.js with TypeScript and MySQL

## Prerequisites

- Node.js (v14 or higher)
- MySQL Server
- npm or yarn

## Setup Instructions

### Database Setup

1. Create a MySQL database named `job_portal`
2. Import the database schema from `job_portal.sql`

```bash
mysql -u root -p job_portal < job_portal.sql
```

3. Alternatively, you can use the seed script to create tables and populate them
   with test data:

```bash
cd backend
npm run seed
```

### Backend Setup

1. Navigate to the backend directory:

```bash
cd backend
```

2. Install dependencies:

```bash
npm install
```

3. Configure the database connection in `.env` file:

```
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASS=your_password
DB_NAME=job_portal
```

4. Start the backend server:

```bash
npm run dev
```

The backend server will run on http://localhost:5000

### Frontend Setup

1. Open a new terminal and navigate to the project root directory

2. Install dependencies:

```bash
npm install
```

3. Start the frontend development server:

```bash
npm run dev
```

The frontend will run on http://localhost:5173

## Features

- User authentication (job seekers and employers)
- Job listings with search and filter functionality
- Company profiles
- Job applications
- User profiles with portfolios
- Categories and locations for jobs
- Subscription plans
- AI-powered features

### Job Posting Feature

The application includes a job posting feature that allows employers to post new
job listings. To use this feature:

1. Navigate to the Jobs page
2. Click the "Post a Job" button in the top-right corner
3. Fill out the job details form:
   - Job Title
   - Job Description
   - Company/Employer
   - Category
   - Job Type
   - Location
   - Salary Range
4. Click "Post Job" to submit the job listing

The new job listing will be added to the database and displayed in the job
listings.

## API Endpoints

### Users

- GET `/users` - Get all users
- POST `/adduser` - Add a new user

### Jobs

- GET `/openings` - Get all job openings
- GET `/openings/:id` - Get job opening by ID
- GET `/openings/category/:categoryId` - Get job openings by category
- GET `/openings/location/:locationId` - Get job openings by location
- POST `/openings` - Add a new job opening

### Categories

- GET `/categories` - Get all categories
- GET `/categories/:id` - Get category by ID

### Companies

- GET `/companies` - Get all companies (users with type 'employer')
- GET `/companies/:id` - Get company by ID

## License

MIT
"# job-portal" 
"# job-portal" 
