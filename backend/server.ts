import express, { Request, Response } from "express";
import mysql from "mysql";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(express.json());
app.use(cors());

// MySQL Connection
const db = mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASS || "",
    database: process.env.DB_NAME || "job_portal",
});

db.connect((err) => {
    if (err) {
        console.error("Database connection failed:", err);
    } else {
        console.log("Connected to MySQL database");
    }
});

// API Endpoint to Fetch Users
app.get("/users", (req: Request, res: Response) => {
    db.query("SELECT * FROM users", (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// API Endpoint to Add User
app.post("/adduser", (req: Request, res: Response) => {
    const { name, email, password, type } = req.body;
    const query = "INSERT INTO users (name, email, password, type) VALUES (?, ?, ?, ?)";
    db.query(query, [name, email, password, type], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: "User added successfully", userId: result.insertId });
    });
});

// API Endpoint to Fetch Job Openings
app.get("/openings", (req: Request, res: Response) => {
    db.query("SELECT * FROM openings", (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// API Endpoint to Fetch Job Opening by ID
app.get("/openings/:id", (req: Request, res: Response) => {
    const id = req.params.id;
    db.query("SELECT * FROM openings WHERE id = ?", [id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ error: "Job opening not found" });
        }
        res.json(results[0]);
    });
});

// API Endpoint to Fetch Job Openings by Category
app.get("/openings/category/:categoryId", (req: Request, res: Response) => {
    const categoryId = req.params.categoryId;
    db.query("SELECT * FROM openings WHERE category_id = ?", [categoryId], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// API Endpoint to Fetch Job Openings by Location
app.get("/openings/location/:locationId", (req: Request, res: Response) => {
    const locationId = req.params.locationId;
    db.query(
        "SELECT o.* FROM openings o JOIN location_opening lo ON o.id = lo.opening_id WHERE lo.location_id = ?",
        [locationId],
        (err, results) => {
            if (err) {
                return res.status(500).json({ error: err.message });
            }
            res.json(results);
        }
    );
});

// API Endpoint to Add Job Opening
app.post("/openings", (req: Request, res: Response) => {
    const { title, description, user_id, category_id, type } = req.body;
    const query = "INSERT INTO openings (title, description, user_id, category_id, type) VALUES (?, ?, ?, ?, ?)";
    db.query(query, [title, description, user_id, category_id, type], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: "Job opening added successfully", openingId: result.insertId });
    });
});

// API Endpoint to Fetch Categories
app.get("/categories", (req: Request, res: Response) => {
    db.query("SELECT * FROM categories", (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// API Endpoint to Fetch Category by ID
app.get("/categories/:id", (req: Request, res: Response) => {
    const id = req.params.id;
    db.query("SELECT * FROM categories WHERE id = ?", [id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ error: "Category not found" });
        }
        res.json(results[0]);
    });
});

// API Endpoint to Fetch Companies (Users who are employers)
// Modified to not rely on 'type' column which might not exist
app.get("/companies", (req: Request, res: Response) => {
    // Assuming all users are potential companies/employers
    db.query("SELECT * FROM users", (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

// API Endpoint to Fetch Company by ID
app.get("/companies/:id", (req: Request, res: Response) => {
    const id = req.params.id;
    db.query("SELECT * FROM users WHERE id = ?", [id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        if (results.length === 0) {
            return res.status(404).json({ error: "Company not found" });
        }
        res.json(results[0]);
    });
});

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
