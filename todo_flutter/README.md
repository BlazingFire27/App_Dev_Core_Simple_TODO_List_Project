# SIMPLE TO DO LIST APP FRONTEND USING FLUTTER DART

 - The Frontend part of Simple To Do List App.
 - This uses flutter dart framework.

## About Flutter & Dart

 - Flutter is Google’s UI toolkit for building natively compiled apps for mobile, web, and desktop from a single codebase.
 - Dart is the programming language used by Flutter. It’s strongly typed, easy to read, and hot reload makes development fast.

## Features Implemented
User Authentication:
 - Login and registration forms with validation.
 - Error messages for invalid input or failed login/register.
 - User session is kept until logout.

Task Management:
 - Add new tasks with title, description, and status.
 - Edit existing tasks.
 - Change task status (pending/completed) via dropdown.
 - View all tasks in a scrollable list.
 - Logout button clears user session and state.

User Interface:
 - Centralized, bold titles.
 - Mild yellow app bars, light green login/register backgrounds, dark main background.
 - Floating effect for task cards.
 - Responsive layout with consistent spacing.

## How Features Are Implemented
 - Provider is used for state management (AuthProvider, TaskProvider).
 - Task list uses ListView.builder and Card widgets.
 - API calls are made via a separate ApiService class.

## NOTE 1
MY FIRST FRONTEND IMPLEMENTATION WHICH IS CONNECTED TO BACKEND

## NOTE 2
THANKING THE APP DEV CORE TEAM FOR RESOURCES TO LEARN FROM AND THANKING GPT FOR ERROR FINDING and HANDLING
