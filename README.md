# Backend Module

## What is a Backend?

A backend (or "server-side") application handles tasks like:
- Storing and retrieving data from databases
- User authentication and authorization
- Business logic processing
- API endpoints that client applications can communicate with

## Features

- User registration with unique user IDs
- Secure login and authentication
- Health check endpoint for monitoring
- Password hashing for security

## Prerequisites
- Node.js (v14+ recommended)
- MongoDB instance

## Project Structure Before Creation of Task Related Files

```
/
├── index.js                 # Application entry point - starts the server
├── src/                     # Source code directory
│   ├── app.js               # Express setup - configures the web server
│   ├── routes/              # API route definitions - maps URLs to controllers
│   │   ├── auth.route.js    # Authentication routes (login, register)
│   │   └── healthcheck.route.js # Health check routes for monitoring
│   ├── controllers/         # Request handlers - business logic for each route
│   │   ├── login.controller.js     # Handles user login
│   │   ├── register.controller.js  # Handles user registration
│   │   └── healthcheck.controller.js # Handles health checks
│   ├── models/              # Database schemas - defines data structure
│   │   └── User.js          # User model - defines user properties
│   └── db/
│       └── connectDB.js     # Database connection - connects to MongoDB
└── .env                     # Environment variables (not in repository)
```

### Key Files Explained

- **index.js**: The starting point of the application. It loads environment variables, connects to the database, and starts the server.

- **app.js**: Creates and configures the Express application, setting up middleware for parsing requests.

- **routes/auth.route.js**: Defines the URLs for authentication operations and connects them to controller functions.

- **controllers/login.controller.js**: Contains the logic for authenticating users, comparing passwords, and updating login state.

- **models/User.js**: Defines the structure of user data in the database using Mongoose schema.

## Understanding HTTP Methods

This API uses these HTTP methods:
- **GET**: Retrieve data (like health check)
- **POST**: Create or update data (like register, login)

HTTP status codes in responses:
- **200**: Success (OK)
- **201**: Created successfully
- **400**: Bad request (client error)
- **404**: Not found
- **500**: Server error

## Security Considerations

- **Password Hashing**: Passwords are never stored as plain text. We use bcrypt which:
  - Adds random "salt" to make each hash unique
  - Uses one-way encryption that can't be reversed

- **Input Validation**: All user inputs are checked to:
  - Prevent malicious data
  - Ensure required fields are provided
  - Reject invalid formats

- **JWT Authentication**: JSON Web Tokens (JWT) are used to securely identify users after login. They:
  - Contain user information and a signature
  - Are sent in the Authorization header for protected routes
  - Allow stateless authentication (no session storage needed)

- **Environment Variables**: Sensitive information like database credentials are kept in .env files that aren't committed to repositories.

## Common Issues and Troubleshooting

### Connection Errors
If you see "Error connecting to MongoDB", check:
- Is MongoDB running?
- Is your MONGODB_URI correct in the .env file?
- Do you have network access to the database?

### "Module not found" Errors
Run `npm install` to make sure all dependencies are installed.

### Server Won't Start
- Check if another application is using the same port
- Verify that your .env file exists with the correct variables

## Development

To run in development mode with nodemon (automatically restarts when code changes):

```bash
npm run dev
```

## Core Assignment: Simple To-Do List

### Assignment Overview

The Backend for this Assignment

### Backend Requirements

Building on the existing authentication system, implement the following features:

1. **Task Management**
   - Create new tasks with title, description, and status
   - View all tasks for the logged-in user
   - Update existing tasks (mark as completed or modify details)

### Files We Need to Create

#### 1. Created the Task Model
**File path:** `src/models/Task.js`

Created a Task model that includes:
- userId (to connect tasks to a specific user)
- title (short title of the task)
- description (detailed description of what needs to be done)
- status (e.g., "pending", "completed")
- createdAt (when the task was created)

#### 2. Created the Task Controller
**File path:** `src/controllers/task.controller.js`

Created a task controller with these functions:
- `createTask`: Add a new task to the database
- `getTasks`: Retrieve all tasks for a specific user
- `updateTask`: Update an existing task by its ID (change description or mark as complete)

#### 3. Created the Task Routes
**File path:** `src/routes/task.route.js`

Created routes that define these API endpoints:
- `POST /api/task/create`: Create a new task
- `GET /api/task/all`: Fetch all tasks for a user
- `PUT /api/task/update`: Update a task by ID

#### 4. Updated the Main Entry File
**Files modified:** `index.js`

Added new task routes to the main application by importing your task router and adding the appropriate `app.use()` statement.

### Final Backend Structure

Final project structure Backend looks like this:

```
/
├── index.js                 # Application entry point - starts the server
├── src/                     # Source code directory
│   ├── app.js               # Express application setup - configures the web server
│   ├── routes/              # API route definitions - maps URLs to controllers
│   │   ├── auth.route.js    # Authentication routes (login, register)
│   │   ├── healthcheck.route.js # Health check routes for monitoring
│   │   └── task.route.js    # Task management routes (create, get, update)
│   ├── controllers/         # Request handlers - business logic for each route
│   │   ├── login.controller.js     # Handles user login
│   │   ├── register.controller.js  # Handles user registration
│   │   ├── healthcheck.controller.js # Handles health checks
│   │   └── task.controller.js      # Handles task management
│   ├── models/              # Database schemas - defines data structure
│   │   ├── User.js          # User model - defines user properties
│   │   └── Task.js          # Task model - defines task properties
│   └── db/
│       └── connectDB.js     # Database connection - connects to MongoDB
└── .env                     # Environment variables (not in repository)
```

After Backend is done, Frontend is done in [Frontend (todo_flutter folder)](./todo_flutter/)

## NOTE 1
Thank You Arjav Patel brother for the predesigned Module 4 which can be found at= [https://github.com/arjav1528/Module-4](https://github.com/arjav1528/Module-4)

## NOTE 2
Thank you Team DevSoc for structured and very well designed and resourceful Core Assignments
