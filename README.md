# My DotNet Container App

This project is a containerized ASP.NET Core web application that works together with a database. The infrastructure is set up so that both the web application and the database run in Docker containers, simplifying deployment and development.

## Project Structure

- **db/**  
  Contains scripts and Docker configuration to initialize and manage the database. For example:  
  - `init.sql` – SQL script to initialize the schema.  
  - `check-db.sh`, `fix-permissions.sh`, and related scripts help manage database permissions and health.  
  - [Dockerfile](db/Dockerfile) for building the database image.

- **web/**  
  Contains the ASP.NET Core application. Key components include:  
  - [Program.cs](web/Program.cs) – Application entry point.  
  - [my-dotnet-container-app.csproj](web/my-dotnet-container-app.csproj) – Project definition including NuGet dependencies (e.g. [`MySql.Data`](web/my-dotnet-container-app.csproj)).  
  - **Controllers/**, **Models/**, **Views/** – MVC components that structure the application.  
  - `appsettings.json` and `appsettings.Development.json` – Application configuration files.  
  - Static assets in [wwwroot/](web/wwwroot) and the auto-generated static web assets files in the `obj/` folder.

- **docker-compose.yml**  
  Orchestrates both the web and database containers for easy local development and deployment.

## Features

- **Containerization:** Both the web application and the database are containerized using Docker.
- **ASP.NET Core MVC:** Implements an MVC pattern with controllers, views, and models.
- **Database Integration:** Scripts in the `db/` folder set up and manage the database.
- **Static Assets & Bundling:** Uses ASP.NET Core’s static web asset pipeline (visible in the `obj/` folder) for managing CSS, JS, and other assets.
- **Docker Compose:** Single configuration file ([docker-compose.yml](docker-compose.yml)) to run all components together.
- **NuGet Package Management:** Leverages several packages such as [`MySql.Data`](web/my-dotnet-container-app.csproj), among others, for enhanced functionality.

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose installed.
- .NET 9.0 SDK installed locally (for development).

### Running the Project

1. **Build and run containers:**  
   Open a terminal in the project root and run:

   ```sh
   docker-compose up --build
   ```

2. **Access the application:**  
   Open a web browser and navigate to `http://localhost:8080` to view the application.
