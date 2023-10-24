# SportsStore Ecommerce Web App

Welcome to the "SportsStore" ecommerce web application project. This repository will serve as a step-by-step guide on how to build web applications using the ASP.NET framework. Each commit will represent the progress made during each class.

## Initial Setup

### 1. ASP.NET Web App Template

We've initialized this project using the ASP.NET Web App template in Visual Studio. This will serve as our base upon which we'll be building our ecommerce store. As we progress through the lessons, we will be making changes, adding features, and refining this template into a full-fledged web application.

### 2. `AdditionalFiles` Folder

Inside the `AdditionalFiles` folder, you'll find two essential SQL scripts:

1. **[SportsStoreBackup.sql](AdditionalFiles/SportsStoreBackup.sql)**: This script is responsible for setting up the necessary tables, constraints, and relations for our 'SportsStoreDB' database. Before we proceed with the development of our application, ensure that you have run this script to set up the required database schema.

2. **[DataforSportsStoreDB.sql](AdditionalFiles/DataforSportsStoreDB.sql)**: After setting up the database schema using the previous script, this script will populate the 'SportsStoreDB' with initial data. This is essential for us to have some baseline data to work with during our initial development and testing phases.

## Getting Started

### Pre-requisites

- Visual Studio installed on your machine.
- SQL Server Management Studio (SSMS) for interacting with SQL Server.
  
### Steps:

1. **Clone the Repository**: 

    a. Open Visual Studio.
    
    b. Go to `File` > `Clone Repository`.
    
    c. Enter the repository URL and select the desired local path.
    
    d. Click `Clone`.

2. **Setting Up the Database**:

    a. Open SQL Server Management Studio (SSMS).
    
    b. Connect to your local SQL Server instance.
    
    c. Go to `File` > `Open` > `File`, and then navigate to the `SportsStoreBackup.sql` script located inside the `AdditionalFiles` folder in your project directory. Select the script and click `Open`.
    
    d. Execute the script to set up the 'SportsStoreDB' database schema.
    
    e. Similarly, open and execute the `DataforSportsStoreDB.sql` script to populate the database with initial data.

3. **Run the Web App**:

    a. Go back to Visual Studio.
    
    b. In the Solution Explorer, right-click on the solution and select `Restore NuGet Packages` to ensure all required packages are installed.
    
    c. Press `F5` or click the `Start` button to run the application.

4. Open a web browser, which will automatically navigate to the running application, typically at `https://localhost:443xx` (the exact port number will be displayed in Visual Studio).

## Moving Forward

Ensure you keep your local repository up-to-date with the changes made during each class. This will allow you to follow along, practice, and experiment with the features we introduce in real-time. If you encounter issues, consult the commit history and README updates for clarifications.

Happy coding!