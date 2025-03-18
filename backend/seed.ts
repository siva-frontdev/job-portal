import mysql from "mysql";
import dotenv from "dotenv";

dotenv.config();

// MySQL Connection
const db = mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASS || "",
    database: process.env.DB_NAME || "job_portal",
});

// Connect to database
db.connect((err) => {
    if (err) {
        console.error("Database connection failed:", err);
        process.exit(1);
    }
    console.log("Connected to MySQL database");
    seedDatabase();
});

// Seed database with test data
async function seedDatabase() {
    try {
        // Check if tables exist
        await checkTables();

        // Add test users
        await addTestUsers();

        // Add test categories
        await addTestCategories();

        // Add test job openings
        await addTestJobs();

        console.log("Database seeded successfully!");
        process.exit(0);
    } catch (error) {
        console.error("Error seeding database:", error);
        process.exit(1);
    }
}

// Check if required tables exist
function checkTables() {
    return new Promise((resolve, reject) => {
        const tables = ["users", "categories", "openings"];
        let missingTables: string[] = [];

        // Check each table
        tables.forEach((table) => {
            db.query(`SHOW TABLES LIKE '${table}'`, (err, results) => {
                if (err) {
                    reject(err);
                    return;
                }
                if (results.length === 0) {
                    missingTables.push(table);
                }
            });
        });

        // If any tables are missing, create them
        if (missingTables.length > 0) {
            console.log(`Creating missing tables: ${missingTables.join(", ")}`);
            createTables(missingTables)
                .then(resolve)
                .catch(reject);
        } else {
            resolve(true);
        }
    });
}

// Create required tables
function createTables(tables: string[]) {
    return new Promise((resolve, reject) => {
        // Create users table
        if (tables.includes("users")) {
            db.query(`
                CREATE TABLE users (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(255) NOT NULL,
                    email VARCHAR(255),
                    password VARCHAR(255),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            `, (err) => {
                if (err) {
                    reject(err);
                    return;
                }
                console.log("Users table created");
            });
        }

        // Create categories table
        if (tables.includes("categories")) {
            db.query(`
                CREATE TABLE categories (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    slug VARCHAR(255),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            `, (err) => {
                if (err) {
                    reject(err);
                    return;
                }
                console.log("Categories table created");
            });
        }

        // Create openings table
        if (tables.includes("openings")) {
            db.query(`
                CREATE TABLE openings (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    description TEXT,
                    user_id INT,
                    category_id INT,
                    type VARCHAR(50),
                    location VARCHAR(255),
                    salary VARCHAR(255),
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (user_id) REFERENCES users(id),
                    FOREIGN KEY (category_id) REFERENCES categories(id)
                )
            `, (err) => {
                if (err) {
                    reject(err);
                    return;
                }
                console.log("Openings table created");
            });
        }

        resolve(true);
    });
}

// Add test users
function addTestUsers() {
    return new Promise((resolve, reject) => {
        const users = [
            { name: "TechCorp Inc.", email: "hr@techcorp.com" },
            { name: "Innovate Solutions", email: "careers@innovate.com" },
            { name: "Digital Dynamics", email: "jobs@digitaldynamics.com" },
            { name: "Future Systems", email: "recruiting@futuresystems.com" },
            { name: "Global Tech", email: "hr@globaltech.com" }
        ];

        // Check if users already exist
        db.query("SELECT COUNT(*) as count FROM users", (err, results) => {
            if (err) {
                reject(err);
                return;
            }

            if (results[0].count > 0) {
                console.log("Users already exist, skipping...");
                resolve(true);
                return;
            }

            // Insert users
            let insertedCount = 0;
            users.forEach((user) => {
                db.query("INSERT INTO users (name, email) VALUES (?, ?)", [user.name, user.email], (err) => {
                    if (err) {
                        reject(err);
                        return;
                    }
                    insertedCount++;
                    if (insertedCount === users.length) {
                        console.log(`${insertedCount} users added`);
                        resolve(true);
                    }
                });
            });
        });
    });
}

// Add test categories
function addTestCategories() {
    return new Promise((resolve, reject) => {
        const categories = [
            { title: "Technology", slug: "technology" },
            { title: "Design", slug: "design" },
            { title: "Marketing", slug: "marketing" },
            { title: "Finance", slug: "finance" },
            { title: "Healthcare", slug: "healthcare" },
            { title: "Education", slug: "education" },
            { title: "Customer Service", slug: "customer-service" },
            { title: "Sales", slug: "sales" }
        ];

        // Check if categories already exist
        db.query("SELECT COUNT(*) as count FROM categories", (err, results) => {
            if (err) {
                reject(err);
                return;
            }

            if (results[0].count > 0) {
                console.log("Categories already exist, skipping...");
                resolve(true);
                return;
            }

            // Insert categories
            let insertedCount = 0;
            categories.forEach((category) => {
                db.query("INSERT INTO categories (title, slug) VALUES (?, ?)", [category.title, category.slug], (err) => {
                    if (err) {
                        reject(err);
                        return;
                    }
                    insertedCount++;
                    if (insertedCount === categories.length) {
                        console.log(`${insertedCount} categories added`);
                        resolve(true);
                    }
                });
            });
        });
    });
}

// Add test job openings
function addTestJobs() {
    return new Promise((resolve, reject) => {
        // Check if jobs already exist
        db.query("SELECT COUNT(*) as count FROM openings", (err, results) => {
            if (err) {
                reject(err);
                return;
            }

            if (results[0].count > 0) {
                console.log("Jobs already exist, skipping...");
                resolve(true);
                return;
            }

            // Get user IDs
            db.query("SELECT id FROM users", (err, users) => {
                if (err) {
                    reject(err);
                    return;
                }

                // Get category IDs
                db.query("SELECT id, title FROM categories", (err, categories) => {
                    if (err) {
                        reject(err);
                        return;
                    }

                    const jobs = [
                        {
                            title: "Senior React Developer",
                            description: "We are looking for a Senior React Developer to join our team. You will be responsible for developing and implementing user interface components using React.js concepts and workflows.",
                            user_id: users[0].id,
                            category_id: categories.find((c: any) => c.title === "Technology").id,
                            type: "full-time",
                            location: "San Francisco, CA",
                            salary: "$120,000 - $150,000"
                        },
                        {
                            title: "UX/UI Designer",
                            description: "We're seeking a talented UX/UI Designer to create amazing user experiences. The ideal candidate should have a keen eye for clean and artful design, possess superior UI skills and be able to translate high-level requirements into interaction flows and artifacts.",
                            user_id: users[1].id,
                            category_id: categories.find((c: any) => c.title === "Design").id,
                            type: "full-time",
                            location: "New York, NY",
                            salary: "$90,000 - $120,000"
                        },
                        {
                            title: "Marketing Manager",
                            description: "We are looking for a Marketing Manager to promote our company's products and services. You will lead marketing campaigns from ideation to execution and analyze their results.",
                            user_id: users[2].id,
                            category_id: categories.find((c: any) => c.title === "Marketing").id,
                            type: "full-time",
                            location: "Chicago, IL",
                            salary: "$80,000 - $100,000"
                        },
                        {
                            title: "Financial Analyst",
                            description: "We are seeking a Financial Analyst to join our team. You will support our financial planning and analysis efforts, including budgeting, forecasting, and reporting.",
                            user_id: users[3].id,
                            category_id: categories.find((c: any) => c.title === "Finance").id,
                            type: "full-time",
                            location: "Boston, MA",
                            salary: "$75,000 - $95,000"
                        },
                        {
                            title: "Node.js Backend Developer",
                            description: "We're looking for a Node.js Backend Developer to build robust and scalable server-side applications. You will work with our frontend team to integrate user-facing elements with server-side logic.",
                            user_id: users[0].id,
                            category_id: categories.find((c: any) => c.title === "Technology").id,
                            type: "full-time",
                            location: "Remote",
                            salary: "$100,000 - $130,000"
                        },
                        {
                            title: "Customer Support Specialist",
                            description: "We are seeking a Customer Support Specialist to serve as a liaison between our customers and our company. You will answer customer queries, resolve issues, and ensure customer satisfaction.",
                            user_id: users[4].id,
                            category_id: categories.find((c: any) => c.title === "Customer Service").id,
                            type: "full-time",
                            location: "Austin, TX",
                            salary: "$45,000 - $55,000"
                        },
                        {
                            title: "Sales Representative",
                            description: "We're looking for a Sales Representative to actively seek out and engage customer prospects. You will provide complete and appropriate solutions for every customer in order to boost top-line revenue growth.",
                            user_id: users[1].id,
                            category_id: categories.find((c: any) => c.title === "Sales").id,
                            type: "full-time",
                            location: "Denver, CO",
                            salary: "$60,000 - $80,000 + Commission"
                        },
                        {
                            title: "Part-time Graphic Designer",
                            description: "We are seeking a creative Graphic Designer to join our team on a part-time basis. You will create visual concepts to communicate ideas that inspire, inform, and captivate consumers.",
                            user_id: users[2].id,
                            category_id: categories.find((c: any) => c.title === "Design").id,
                            type: "part-time",
                            location: "Remote",
                            salary: "$30 - $40 per hour"
                        }
                    ];

                    // Insert jobs
                    let insertedCount = 0;
                    jobs.forEach((job) => {
                        db.query(
                            "INSERT INTO openings (title, description, user_id, category_id, type, location, salary) VALUES (?, ?, ?, ?, ?, ?, ?)",
                            [job.title, job.description, job.user_id, job.category_id, job.type, job.location, job.salary],
                            (err) => {
                                if (err) {
                                    reject(err);
                                    return;
                                }
                                insertedCount++;
                                if (insertedCount === jobs.length) {
                                    console.log(`${insertedCount} jobs added`);
                                    resolve(true);
                                }
                            }
                        );
                    });
                });
            });
        });
    });
} 