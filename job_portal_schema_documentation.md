# Job Portal Database Schema Documentation

## Overview

This document provides a comprehensive overview of the database schema for the
Job Portal application. The database is designed to support a full-featured job
portal with functionality for employers, job seekers, job listings,
applications, and various supporting features.

## Core Entities

### Users

The `users` table is the central entity that stores information about all users
of the system, including job seekers, employers, and administrators.

### Jobs/Openings

The `openings` table stores job listings with details such as title,
description, requirements, and other job-related information.

### Categories

The `categories` table provides a hierarchical categorization system for jobs,
blog posts, and other content.

### Locations

The `locations` table stores geographical information for jobs and users, with a
hierarchical structure (country, state, city).

## Entity Relationships

### User-Related Relationships

- **User to Openings**: Employers (users) can create multiple job openings
  (`user_id` in `openings` table)
- **User to Bookmarks**: Users can bookmark jobs (`jobbookmarks` table) and
  candidates (`candidatebookmarks` table)
- **User to Portfolios**: Users can have multiple portfolio items (`portfolios`
  table)
- **User to Categories**: Users can be associated with multiple categories
  (`usercategories` table)
- **User to Locations**: Users can be associated with locations (`userlocations`
  table)
- **User to Qualifications**: Users can have educational qualifications
  (`user_education_qualifications` table)
- **User to Reviews**: Users can receive and give reviews (`company_reviews` and
  `candidate_reviews` tables)
- **User to AI Templates**: Users can use AI templates (`ai_template_user`
  table)
- **User to AI Generates**: Users can generate content using AI (`ai_generates`
  table)
- **User to Orders**: Users can purchase subscription plans (`orders` table)
- **User to Roles/Permissions**: Users have roles and permissions
  (`model_has_roles` and `model_has_permissions` tables)

### Job-Related Relationships

- **Openings to Categories**: Jobs belong to categories (`category_opening`
  table)
- **Openings to Locations**: Jobs are associated with locations
  (`location_opening` table)
- **Openings to Bookmarks**: Jobs can be bookmarked by users (`jobbookmarks`
  table)
- **Openings to Visitors**: Job views are tracked (`visitors` table)

### Content-Related Relationships

- **Posts to Categories**: Blog posts belong to categories (`postcategories`
  table)
- **Posts to Metadata**: Posts have additional metadata (`postmetas` table)
- **Categories to Metadata**: Categories have additional metadata
  (`categorymetas` table)

### Communication-Related Relationships

- **Conversations to Users**: Users participate in conversations
  (`conversation_user` table)
- **Conversations to Replies**: Conversations contain replies (`replies` table)
- **Support Tickets**: Users can create support tickets (`supports` table) with
  logs (`supportlogs` table)

### Payment and Subscription-Related Relationships

- **Users to Plans**: Users subscribe to plans (`orders` table)
- **Plans to Features**: Plans have specific features and limitations (stored in
  `data` JSON field)
- **Payment Gateways**: Various payment methods are supported (`gateways` table)
- **Credit Logs**: Tracks credit usage for AI features (`credit_logs` table)

### AI-Related Relationships

- **AI Templates**: Pre-defined templates for AI content generation
  (`ai_templates` table)
- **AI Generates**: Content generated using AI (`ai_generates` table)
- **Description Templates**: Templates for job and company descriptions
  (`description_templates` table)

## Key Tables and Their Purposes

### User Management

- `users`: Stores all user information
- `model_has_roles`: Associates users with roles
- `model_has_permissions`: Associates users with permissions
- `roles`: Defines user roles
- `permissions`: Defines permissions
- `kyc_requests`: Stores KYC (Know Your Customer) verification requests
- `kyc_methods`: Defines KYC verification methods

### Job Management

- `openings`: Stores job listings
- `category_opening`: Maps jobs to categories
- `location_opening`: Maps jobs to locations
- `expert_levels`: Defines experience levels for jobs
- `qualifications`: Defines educational qualifications

### Content Management

- `posts`: Stores blog posts and other content
- `categories`: Hierarchical categorization system
- `postcategories`: Maps posts to categories
- `postmetas`: Stores additional metadata for posts
- `categorymetas`: Stores additional metadata for categories
- `menus`: Stores navigation menus

### Location Management

- `locations`: Hierarchical location system (country, state, city)

### Bookmarking and Tracking

- `jobbookmarks`: Tracks jobs bookmarked by users
- `candidatebookmarks`: Tracks candidates bookmarked by employers
- `visitors`: Tracks job listing views
- `profile_visitors`: Tracks profile views

### Communication

- `conversations`: Stores conversations between users
- `replies`: Stores messages within conversations
- `conversation_user`: Maps users to conversations
- `supports`: Stores support tickets
- `supportlogs`: Stores support ticket activity

### Payment and Subscription

- `plans`: Defines subscription plans
- `orders`: Tracks plan purchases
- `gateways`: Defines payment gateways
- `credit_logs`: Tracks credit usage

### AI Features

- `ai_templates`: Stores AI content generation templates
- `ai_generates`: Stores AI-generated content
- `ai_template_user`: Maps users to AI templates
- `description_templates`: Stores templates for job and company descriptions

### Miscellaneous

- `options`: Stores system settings and configurations
- `notifications`: Stores user notifications
- `failed_jobs`: Tracks failed background jobs
- `jobs`: Stores background processing jobs

## Database Constraints and Indexes

The database uses foreign key constraints to maintain referential integrity
between related tables. Indexes are created on frequently queried columns to
improve performance.

## Data Types and Special Fields

- Many tables include JSON fields (stored as text with JSON validation) for
  flexible data storage
- Timestamps are used to track creation and modification times
- Soft deletes are implemented in some tables using `deleted_at` timestamps

## Conclusion

The Job Portal database schema is designed to support a comprehensive job
marketplace with features for both employers and job seekers. The schema allows
for efficient searching, matching, and management of jobs, candidates, and
related content.
