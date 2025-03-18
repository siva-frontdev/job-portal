# Job Portal Database Schema Diagram

```
+----------------+       +----------------+       +----------------+
|     USERS      |       |    OPENINGS    |       |   CATEGORIES   |
+----------------+       +----------------+       +----------------+
| id             |<----->| user_id        |<----->| id             |
| name           |       | title          |       | title          |
| email          |       | description    |       | slug           |
| password       |       | category_id    |       | category_id    |
| type           |       | type           |       | type           |
| ...            |       | ...            |       | ...            |
+----------------+       +----------------+       +----------------+
       ^                        ^                        ^
       |                        |                        |
       |                        |                        |
       v                        v                        v
+----------------+       +----------------+       +----------------+
|   PORTFOLIOS   |       |  JOBBOOKMARKS  |       | POSTCATEGORIES |
+----------------+       +----------------+       +----------------+
| id             |       | user_id        |       | post_id        |
| title          |       | opening_id     |       | category_id    |
| preview        |       |                |       |                |
| user_id        |       |                |       |                |
+----------------+       +----------------+       +----------------+

+----------------+       +----------------+       +----------------+
|    LOCATIONS   |       |     PLANS      |       |     POSTS      |
+----------------+       +----------------+       +----------------+
| id             |<----->| id             |<----->| id             |
| name           |       | title          |       | title          |
| slug           |       | price          |       | slug           |
| location_id    |       | days           |       | content        |
| ...            |       | data           |       | ...            |
+----------------+       +----------------+       +----------------+
       ^                        ^                        ^
       |                        |                        |
       |                        |                        |
       v                        v                        v
+----------------+       +----------------+       +----------------+
|LOCATION_OPENING|       |     ORDERS     |       |   POSTMETAS    |
+----------------+       +----------------+       +----------------+
| id             |       | id             |       | id             |
| opening_id     |       | plan_id        |       | post_id        |
| country_id     |       | user_id        |       | key            |
| state_id       |       | gateway_id     |       | value          |
+----------------+       +----------------+       +----------------+

+----------------+       +----------------+       +----------------+
| AI_TEMPLATES   |       | CONVERSATIONS  |       |    GATEWAYS    |
+----------------+       +----------------+       +----------------+
| id             |<----->| id             |<----->| id             |
| title          |       | title          |       | name           |
| description    |       | ...            |       | currency       |
| type           |       |                |       | data           |
| ...            |       |                |       | ...            |
+----------------+       +----------------+       +----------------+
       ^                        ^                        ^
       |                        |                        |
       |                        |                        |
       v                        v                        v
+----------------+       +----------------+       +----------------+
| AI_GENERATES   |       |    REPLIES     |       |  CREDIT_LOGS   |
+----------------+       +----------------+       +----------------+
| id             |       | id             |       | id             |
| user_id        |       | conversation_id|       | user_id        |
| ai_template_id |       | user_id        |       | gateway_id     |
| content        |       | body           |       | amount         |
| ...            |       | ...            |       | ...            |
+----------------+       +----------------+       +----------------+

+----------------+       +----------------+       +----------------+
|  EXPERT_LEVELS |       |CANDIDATE_REVIEWS|      |COMPANY_REVIEWS |
+----------------+       +----------------+       +----------------+
| id             |       | id             |       | id             |
| title          |       | user_id        |       | user_id        |
| ...            |       | company_id     |       | company_id     |
|                |       | rating         |       | rating         |
|                |       | ...            |       | ...            |
+----------------+       +----------------+       +----------------+
```

## Legend

### Primary Entities

- **USERS**: Central entity for all system users (job seekers, employers,
  admins)
- **OPENINGS**: Job listings posted by employers
- **CATEGORIES**: Hierarchical categorization for jobs and content
- **LOCATIONS**: Geographical information (countries, states, cities)
- **PLANS**: Subscription plans for users
- **POSTS**: Blog posts and other content
- **AI_TEMPLATES**: Templates for AI content generation

### Relationship Tables

- **JOBBOOKMARKS**: Links users to jobs they've bookmarked
- **CANDIDATEBOOKMARKS**: Links employers to candidates they've bookmarked
- **LOCATION_OPENING**: Links jobs to their locations
- **POSTCATEGORIES**: Links posts to categories
- **CATEGORY_OPENING**: Links jobs to categories
- **AI_TEMPLATE_USER**: Links users to AI templates they can use
- **CONVERSATION_USER**: Links users to conversations

### Supporting Entities

- **PORTFOLIOS**: Portfolio items for users
- **ORDERS**: Subscription purchases
- **POSTMETAS**: Additional metadata for posts
- **AI_GENERATES**: Content generated using AI
- **CONVERSATIONS**: Messaging between users
- **REPLIES**: Individual messages in conversations
- **GATEWAYS**: Payment methods
- **CREDIT_LOGS**: Tracks credit usage for AI features
- **EXPERT_LEVELS**: Experience levels for jobs
- **CANDIDATE_REVIEWS**: Reviews for candidates
- **COMPANY_REVIEWS**: Reviews for companies

## Key Relationships

1. **User-Job Relationship**:

   - Users (employers) create job openings
   - Users (job seekers) bookmark jobs
   - Users apply to jobs

2. **Categorization System**:

   - Jobs belong to categories
   - Posts belong to categories
   - Categories can have parent categories (hierarchical)

3. **Location System**:

   - Jobs are associated with locations
   - Users are associated with locations
   - Locations can have parent locations (hierarchical)

4. **Subscription System**:

   - Users purchase plans
   - Plans define features and limitations
   - Orders track purchases

5. **AI Content Generation**:

   - Users access AI templates
   - AI templates generate content
   - Credit logs track usage

6. **Communication System**:

   - Users participate in conversations
   - Conversations contain replies
   - Support tickets track issues

7. **Review System**:
   - Users review companies
   - Users review candidates
   - Ratings affect visibility and trust
