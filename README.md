# Blog Application API



## Overview

This is a Ruby on Rails application that provides a RESTful API for managing blog posts and user authentication. The application allows users to create, read, update, and delete blog posts, as well as sign up, sign in, and manage their profiles.

## Setup Instructions

Follow these steps to set up the project on your local machine after $ write command in your terminal

1. Clone the repository: $git clone https://github.com/Namfah01/Ruby_on_Rails_CRUD_API.git

2. Install dependencies: $bundle install

3. Set up the database: $rails db:create, $rails db:migrate

4. Start the server: $rails server

5. Run all Tests: $rspec

## Table of Contents

1. [Authentication](#authentication)
2. [Blog Posts API](#blog-posts-api)
3. [User Authentication API](#user-authentication-api)

## Authentication

All blog post-related endpoints require user authentication unless specified otherwise. Make sure to include the appropriate authentication headers with your requests.

## Blog Posts API

### 1. List All Blog Posts

- **URL:** `/blog_posts`
- **Method:** GET
- **Description:** Retrieves a list of all blog posts.
- **Response:**
  - Status Code: 200 OK

### 2. Show a Specific Blog Post

- **URL:** `/blog_posts/:id`
- **Method:** GET
- **Description:** Retrieves details of a specific blog post.
- **Response:**
  - Status Code: 302 Found (Redirect)
- **Note:**
  - If the blog post doesn't exist, it redirects to the root path.

### 3. New Blog Post Form

- **URL:** `/blog_posts/new`
- **Method:** GET
- **Description:** Renders the form to create a new blog post.
- **Response:**
  - Status Code: 200 OK
  - Body: Includes 'New Blog Post' text

### 4. Create a New Blog Post

- **URL:** `/blog_posts`
- **Method:** POST
- **Description:** Creates a new blog post.
- **Parameters:**
  - `title` (string): The title of the blog post
  - `body` (text): The content of the blog post
- **Responses:**
  - Success:
    - Status Code: 302 Found (Redirect to the newly created post)
  - Failure (Invalid parameters):
    - Status Code: 422 Unprocessable Entity

### 5. Edit Blog Post Form

- **URL:** `/blog_posts/:id/edit`
- **Method:** GET
- **Description:** Renders the form to edit an existing blog post.
- **Response:**
  - Status Code: 302 Found (Redirect to root path)

### 6. Update a Blog Post

- **URL:** `/blog_posts/:id`
- **Method:** PATCH
- **Description:** Updates an existing blog post.
- **Parameters:**
  - `title` (string): The updated title of the blog post
  - `body` (text): The updated content of the blog post
- **Response:**
  - Status Code: 302 Found (Redirect to root path)

### 7. Delete a Blog Post

- **URL:** `/blog_posts/:id`
- **Method:** DELETE
- **Description:** Deletes a specific blog post.
- **Response:**
  - Status Code: 302 Found (Redirect to root path)

## User Authentication API

### 1. Sign In Page

- **URL:** `/users/sign_in`
- **Method:** GET
- **Description:** Renders the sign-in page for users.
- **Response:**
  - Status Code: 200 OK

### 2. Sign In

- **URL:** `/users/sign_in`
- **Method:** POST
- **Description:** Authenticates a user and creates a new session.
- **Parameters:**
  - `email` (string): User's email address
  - `password` (string): User's password
- **Responses:**
  - Success:
    - Status Code: 302 Found (Redirect to root path)
    - Body: Includes "Signed in successfully" message
  - Failure:
    - Status Code: 422 Unprocessable Entity
    - Body: Includes "Invalid Email or password" message

### 3. Sign Out

- **URL:** `/users/sign_out`
- **Method:** DELETE
- **Description:** Ends the user's current session.
- **Response:**
  - Status Code: 302 Found (Redirect to root path)
  - Body: Includes "Signed out successfully" message

### 4. Sign Up Page

- **URL:** `/users/sign_up`
- **Method:** GET
- **Description:** Renders the sign-up page for new users.
- **Response:**
  - Status Code: 200 OK

### 5. Create New User (Sign Up)

- **URL:** `/users`
- **Method:** POST
- **Description:** Creates a new user account.
- **Parameters:**
  - `email` (string): User's email address
  - `password` (string): User's chosen password
- **Responses:**
  - Success:
    - Status Code: 302 Found (Redirect to root path)
  - Failure:
    - Status Code: 422 Unprocessable Entity

### 6. Edit Profile Page

- **URL:** `/users/edit`
- **Method:** GET
- **Description:** Renders the page for editing user profile.
- **Authentication:** Required
- **Response:**
  - Status Code: 200 OK

### 7. Update User Profile

- **URL:** `/users`
- **Method:** PUT
- **Description:** Updates the user's profile information.
- **Authentication:** Required
- **Parameters:**
  - `email` (string): User's new email address
  - `current_password` (string): User's current password for verification
- **Responses:**
  - Success:
    - Status Code: 302 Found (Redirect to root path)
  - Failure:
    - Status Code: 422 Unprocessable Entity

## Notes

- All redirects (status code 302) are to the root path unless specified otherwise.
- The API uses session-based authentication.
- For protected routes (like profile editing and blog post management), ensure the user is signed in before making requests.
- Password validations and email format validations are handled server-side.
- After successful sign-in or sign-up, users are redirected to the root path.
- Error messages for invalid credentials or failed operations are included in the response body.
- When creating or updating a blog post, ensure both `title` and `body` are non-empty strings.
