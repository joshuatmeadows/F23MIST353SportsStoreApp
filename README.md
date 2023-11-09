# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

Exploring the commit history is crucial for a clear understanding of the project's progression. Each commit is a snapshot of a learning module, complete with explanations and discussions relevant to that phase. To fully grasp the current state of the project, reviewing previous commits is strongly recommended.

---

## Current Commit Changes

### 1. User Authentication

This iteration has focused on integrating user authentication into the application, laying the groundwork for a secure and personalized user experience.

- **Registration and Login**: Implemented following the Microsoft Owin tutorial, this feature allows new users to register and existing users to log into the application. [Adding ASP.NET Identity](https://learn.microsoft.com/en-us/aspnet/identity/overview/getting-started/adding-aspnet-identity-to-an-empty-or-existing-web-forms-project)

- **Signout Mechanism**: A straightforward signout page has been established to enable users to safely log out from the application. The code behind triggers the Owin context's sign-out method and redirects to the homepage.

### 2. Navigation Bar Update

The `Site.Master` file has been updated to dynamically display login and logout options based on the user's authentication status.

- **Logged-In State**: When a user is logged in, the navigation bar will display a 'Logout' option.
  
- **Anonymous State**: For users not logged in, the navigation bar will show a 'Login' option. 

This logic is managed through the `asp:LoginView` control which renders content templates based on the user's login status.

---

## Concepts Explored

- **ASP.NET Identity**: This update primarily integrates ASP.NET Identity for user management, which includes features for authentication and authorization.

- **OWIN Middleware**: The use of Owin as middleware for ASP.NET Identity is highlighted. Owin stands for the Open Web Interface for .NET, which decouples the web server from the application, making it possible to host on different servers.

- **Security Best Practices**: By leveraging Owin and ASP.NET Identity, the application adheres to modern security practices, managing passwords, user data, and authentication tokens effectively.

---

## Moving Forward

Introducing user authentication is a significant milestone that paves the way for personalized user interactions and secure transactions. Thorough testing of the login, registration, and logout features is essential to ensure robust security and a seamless user experience. Let's continue building on this strong foundation.