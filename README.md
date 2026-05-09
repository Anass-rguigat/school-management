# School Management System

This project is a comprehensive Java-based School Management System built using Java Servlets, JSP, and MySQL. It follows the DAO (Data Access Object) design pattern for robust database interaction and clean separation of concerns.

## Project Structure Overview

### Root Directory
- **`pom.xml`**: Maven configuration file containing project dependencies (Servlets, JSP, JSTL, MySQL Connector, Commons FileUpload) and build plugins.
- **`schema.sql`**: SQL script for initializing the database schema, including tables for Users, Students, Books, Borrowings, Documents, and Logs.
- **`README.md`**: Project documentation (this file).
- **`.gitignore`**: Specifies files and directories to be ignored by Git (e.g., `target/`, `.idea/`, `.vscode/`).
- **`src/`**: Main source code directory.
- **`school-management/`**: A mirrored sub-directory containing the same project structure.

---

## Source Code (`src/main/java`)

### Controllers (`controller/`)
These Servlets handle HTTP requests, process user input, and manage navigation between views.
- **`ArchiveServlet.java`**: Manages archiving and unarchiving of records (Students, Books, Documents).
- **`BookServlet.java`**: Handles CRUD operations for the library's book collection.
- **`BorrowServlet.java`**: Manages the borrowing process (assigning books to students).
- **`DashboardServlet.java`**: Provides summary statistics and overview for the admin dashboard.
- **`DocumentServlet.java`**: Manages document uploads, downloads, and metadata.
- **`LoginServlet.java`**: Handles user authentication and session management.
- **`LogServlet.java`**: Manages the display and filtering of system activity logs.
- **`StudentServlet.java`**: Handles CRUD operations for student records.
- **`UserServlet.java`**: Manages system users and their roles (Admin, Manager, User).

### Data Access Objects (`dao/` & `dao/impl/`)
This layer handles all direct interactions with the MySQL database.
- **`BookDAO.java` / `BookDAOImpl.java`**: Interface and implementation for Book database operations.
- **`BorrowDAO.java` / `BorrowDAOImpl.java`**: Interface and implementation for Borrowing records.
- **`DocumentDAO.java` / `DocumentDAOImpl.java`**: Interface and implementation for Document storage and retrieval.
- **`LogDAO.java` / `LogDAOImpl.java`**: Interface and implementation for system audit logs.
- **`StudentDAO.java` / `StudentDAOImpl.java`**: Interface and implementation for Student records.
- **`UserDAO.java` / `UserDAOImpl.java`**: Interface and implementation for User management and authentication.

### Models (`model/`)
Plain Old Java Objects (POJOs) representing the system's data entities.
- **`Book.java`**: Represents a library book.
- **`Borrow.java`**: Represents a borrowing transaction.
- **`Document.java`**: Represents an uploaded document.
- **`Log.java`**: Represents a system activity log entry.
- **`Student.java`**: Represents a student record.
- **`User.java`**: Represents a system user.

### Security & Middleware (`filter/` & `listener/`)
- **`AuthFilter.java`**: Restricts access to authenticated users only.
- **`RoleFilter.java`**: Handles granular permission checks based on user roles.
- **`LoggingFilter.java`**: Intercepts requests to log user activities for audit purposes.
- **`ActiveSessionListener.java`**: Monitors session creation and destruction to track active users.

### Utilities (`util/`)
- **`DBConnection.java`**: Singleton utility for managing the MySQL database connection pool.
- **`LoggerUtil.java`**: Helper class for standardized logging across the application.

---

## Web Application (`src/main/webapp`)

### Frontend Views (`views/`)
- **`dashboard.jsp`**: Main administrative interface showing key metrics.
- **`login.jsp`**: Authentication portal for the system.
- **`403.jsp` / `404.jsp`**: Error handling pages for Access Denied and Not Found.
- **`books/`**: JSPs for listing, adding, editing, and archiving books.
- **`students/`**: JSPs for managing student information and history.
- **`borrow/`**: JSPs for tracking book distributions.
- **`documents/`**: JSPs for file management and archiving.
- **`users/`**: JSPs for administrator user management.
- **`logs/`**: JSP for viewing system-wide activity logs.
- **`common/`**: Reusable UI components:
    - **`navbar.jsp`**: Top navigation bar with user info and logout.
    - **`sidebar.jsp`**: Side navigation menu for quick access to modules.

### Configuration & Assets
- **`WEB-INF/web.xml`**: Deployment descriptor defining servlet mappings, filters, and listeners.
- **`css/custom.css`**: Custom styling for the application's modern look and feel.
- **`uploads/`**: Directory where uploaded documents are stored.

---

## How to Run

1. **Database Setup**: Execute `schema.sql` in your MySQL instance.
2. **Configuration**: Update `DBConnection.java` with your database credentials.
3. **Build**: Run `mvn clean install`.
4. **Deploy**: Use `mvn jetty:run` to start the application on `http://localhost:8081`.
