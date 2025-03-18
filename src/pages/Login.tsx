import React, { useState, useEffect } from "react";
import axios from "axios";
import { motion } from "framer-motion";
import { User, Lock, LogIn, ArrowRight, AlertCircle } from "lucide-react";
import { Link } from "react-router-dom";

// Define types
interface LoginResponse {
    token: string;
    user: {
        id: number;
        name: string;
        email: string;
        role: string;
    };
    message: string;
}

const Login: React.FC = () => {
    const [email, setEmail] = useState("siva.frontdev@gmail.com");
    const [password, setPassword] = useState("password");
    const [token, setToken] = useState<string | null>(null);
    const [message, setMessage] = useState("");
    const [isLoading, setIsLoading] = useState(false);
    const [rememberMe, setRememberMe] = useState(false);

    // Background animation elements
    const backgroundShapes = [
        { id: 1, size: 180, x: '10%', y: '20%', duration: 20, delay: 0 },
        { id: 2, size: 150, x: '85%', y: '15%', duration: 25, delay: 0.5 },
        { id: 3, size: 120, x: '70%', y: '70%', duration: 30, delay: 1 },
        { id: 4, size: 200, x: '20%', y: '80%', duration: 22, delay: 1.5 },
    ];

    // Laravel API Base URL
    const API_BASE_URL = "http://127.0.0.1:8000";

    // Setup axios defaults
    useEffect(() => {
        const storedToken = localStorage.getItem("authToken");
        if (storedToken) {
            setToken(storedToken);
            axios.defaults.headers.common['Authorization'] = `Bearer ${storedToken}`;
        }
    }, []);

    // Function to handle redirection with token
    const redirectWithToken = (token: string) => {
        // Encode the token to make it URL-safe
        const encodedToken = encodeURIComponent(token);
        window.location.href = `${API_BASE_URL}/auto-login?token=${encodedToken}`;
    };

    // Handle Login
    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setIsLoading(true);
        setMessage("");

        try {
            const response = await axios.post<LoginResponse>(`${API_BASE_URL}/api/login`, {
                email,
                password,
                remember: rememberMe ? 1 : 0,
            });

            const { token: userToken, user } = response.data;
            
            // Set token in state and localStorage
            setToken(userToken);
            localStorage.setItem("authToken", userToken);
            localStorage.setItem("user", JSON.stringify(user));
            
            // Set axios default header
            axios.defaults.headers.common['Authorization'] = `Bearer ${userToken}`;
            
            setMessage("Login successful! Redirecting...");
            
            // Redirect to dashboard with token
            redirectWithToken(userToken);
        } catch (error) {
            if (axios.isAxiosError(error) && error.response) {
                setMessage(error.response.data.message || "Login failed! Check credentials.");
            } else {
                setMessage("An unexpected error occurred.");
            }
        } finally {
            setIsLoading(false);
        }
    };

    // Handle Auto-Login (Redirect to Dashboard)
    const handleAutoLogin = async () => {
        if (!token) {
            setMessage("No token found! Please login first.");
            return;
        }

        setIsLoading(true);
        setMessage("");

        try {
            const response = await axios.get(`${API_BASE_URL}/auto-login`, {
                headers: { 
                    Accept: "application/json",
                    Authorization: `Bearer ${token}`
                }
            });

            if (response.status === 200) {
                setMessage("Redirecting to dashboard...");
                // Redirect to dashboard with token
                redirectWithToken(token);
            }
        } catch (error) {
            if (axios.isAxiosError(error) && error.response?.status === 401) {
                // Token is invalid or expired
                localStorage.removeItem("authToken");
                localStorage.removeItem("user");
                setToken(null);
                delete axios.defaults.headers.common['Authorization'];
                setMessage("Session expired. Please login again.");
            } else {
                setMessage("Auto-login failed! Please try logging in again.");
            }
        } finally {
            setIsLoading(false);
        }
    };

    return (
        <div className="min-h-screen flex items-center justify-center bg-gradient-to-b from-primary-50 to-white py-12 px-4 sm:px-6 lg:px-8 relative overflow-hidden">
            {/* Animated Background Elements */}
            <div className="absolute inset-0 overflow-hidden">
                {backgroundShapes.map((shape) => (
                    <motion.div
                        key={shape.id}
                        className="animated-bg-element"
                        style={{
                            width: shape.size,
                            height: shape.size,
                            left: shape.x,
                            top: shape.y,
                            zIndex: 0,
                        }}
                        initial={{ scale: 0.8, opacity: 0 }}
                        animate={{ 
                            scale: [0.8, 1.2, 0.8],
                            opacity: [0.6, 0.9, 0.6],
                            x: [0, 30, 0],
                            y: [0, -30, 0],
                        }}
                        transition={{
                            duration: shape.duration,
                            repeat: Infinity,
                            delay: shape.delay,
                            ease: "easeInOut",
                        }}
                    />
                ))}
            </div>

            <div className="max-w-md w-full space-y-8 relative z-10">
                <motion.div
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5 }}
                >
                    <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
                        Welcome Back
                    </h2>
                    <p className="mt-2 text-center text-sm text-gray-600">
                        Sign in to your account to continue
                    </p>
                </motion.div>

                <motion.div 
                    className="glass-effect rounded-xl p-8 shadow-xl"
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5, delay: 0.2 }}
                >
                    <form className="space-y-6" onSubmit={handleLogin}>
                        <div>
                            <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                                Email Address
                            </label>
                            <div className="mt-1 relative rounded-md shadow-sm">
                                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <User className="h-5 w-5 text-gray-400" />
                                </div>
                                <input
                                    id="email"
                                    name="email"
                                    type="email"
                                    autoComplete="email"
                                    required
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                    className="input-primary pl-10 w-full"
                                    placeholder="you@example.com"
                                />
                            </div>
                        </div>

                        <div>
                            <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                                Password
                            </label>
                            <div className="mt-1 relative rounded-md shadow-sm">
                                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <Lock className="h-5 w-5 text-gray-400" />
                                </div>
                                <input
                                    id="password"
                                    name="password"
                                    type="password"
                                    autoComplete="current-password"
                                    required
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    className="input-primary pl-10 w-full"
                                    placeholder="••••••••"
                                />
                            </div>
                        </div>

                        <div className="flex items-center justify-between">
                            <div className="flex items-center">
                                <input
                                    id="remember-me"
                                    name="remember-me"
                                    type="checkbox"
                                    checked={rememberMe}
                                    onChange={(e) => setRememberMe(e.target.checked)}
                                    className="h-4 w-4 text-primary-600 focus:ring-primary-500 border-gray-300 rounded"
                                />
                                <label htmlFor="remember-me" className="ml-2 block text-sm text-gray-700">
                                    Remember me
                                </label>
                            </div>

                            <div className="text-sm">
                                <a href="#" className="font-medium text-primary-600 hover:text-primary-500">
                                    Forgot your password?
                                </a>
                            </div>
                        </div>

                        {message && (
                            <motion.div
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                className={`rounded-md p-3 ${
                                    message.includes("successful") || message.includes("Redirecting")
                                        ? "bg-green-50 text-green-700"
                                        : "bg-red-50 text-red-700"
                                }`}
                            >
                                <div className="flex">
                                    <div className="flex-shrink-0">
                                        <AlertCircle className="h-5 w-5" />
                                    </div>
                                    <div className="ml-3">
                                        <p className="text-sm font-medium">{message}</p>
                                    </div>
                                </div>
                            </motion.div>
                        )}

                        <div className="flex flex-col space-y-4">
                            <motion.button
                                whileHover={{ scale: 1.02 }}
                                whileTap={{ scale: 0.98 }}
                                type="submit"
                                disabled={isLoading}
                                className="btn-primary w-full flex justify-center items-center"
                            >
                                {isLoading ? (
                                    <div className="animate-spin rounded-full h-5 w-5 border-t-2 border-b-2 border-white mr-2"></div>
                                ) : (
                                    <LogIn className="h-5 w-5 mr-2" />
                                )}
                                {isLoading ? "Signing in..." : "Sign in"}
                            </motion.button>

                            {token && (
                                <motion.button
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    type="button"
                                    onClick={handleAutoLogin}
                                    disabled={isLoading}
                                    className="btn-secondary w-full flex justify-center items-center"
                                >
                                    {isLoading ? (
                                        <div className="animate-spin rounded-full h-5 w-5 border-t-2 border-b-2 border-white mr-2"></div>
                                    ) : (
                                        <ArrowRight className="h-5 w-5 mr-2" />
                                    )}
                                    Continue to Dashboard
                                </motion.button>
                            )}
                        </div>
                    </form>
                </motion.div>

                <motion.p 
                    className="mt-6 text-center text-sm text-gray-600"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.5 }}
                >
                    Don't have an account?{" "}
                    <Link to="/register" className="font-medium text-primary-600 hover:text-primary-500">
                        Sign up now
                    </Link>
                </motion.p>
            </div>
        </div>
    );
};

export default Login;
