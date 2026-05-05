# 🎓 School Management System

A professional, feature-rich web application for managing students, books, documents, and system audit logs. Built with a "Premium" aesthetic and robust backend architecture.

## 🌟 Key Features

-   **🔐 Secure Authentication**: Role-based access control (Admin/Staff) with secure session management.
-   **👥 Student Management**: Full CRUD operations for student records with advanced filtering.
-   **📚 Library Management**: Track books, availability, and archival status.
-   **📄 Document Management**: Professional document upload system with live previews (Images/PDFs) and secure downloads.
-   **📦 Soft-Delete Archive**: Advanced archival system for Students, Books, and Documents, allowing for data recovery without permanent deletion.
-   **📜 System Audit Logs**: Comprehensive logging of every system action (Login, Logout, Create, Update, Delete) with detailed activity modals.
-   **💎 Premium UI**: Modern, responsive interface using Bootstrap 5, glassmorphism effects, and professional micro-animations.

---

## 🛠️ Technology Stack

-   **Backend**: Java Servlets (Java 8+)
-   **Frontend**: JSP, JSTL, HTML5, Vanilla CSS
-   **Styling**: Bootstrap 5, Bootstrap Icons
-   **Build Tool**: Apache Maven
-   **Web Server**: Eclipse Jetty (9.4+)
-   **Database**: MySQL (MariaDB)

---

## 📋 Prerequisites

Before running the project, ensure you have the following installed:

1.  **JDK 1.8** or higher.
2.  **Apache Maven** (for dependency management and running the server).
3.  **MySQL/XAMPP** (to host the database).
4.  **Git** (optional, for cloning).

---

## 🚀 Getting Started (From Scratch)

### 1. Clone the Project

```bash
git clone https://github.com/your-username/school-management-system.git
cd school-management-system
```

### 2. Database Setup

1.  Open your MySQL terminal or phpMyAdmin.
2.  Execute the script provided in `schema.sql`:
    ```bash
    mysql -u root -p < schema.sql
    ```
    *Note: This will create the database `school_management_abdsamad`, all required tables, and default admin/user accounts.*

### 3. Configuration

Ensure the database connection details in `src/main/java/util/DBConnection.java` match your MySQL setup (default is `root` with no password).

### 4. Build & Run

Open your terminal in the project root directory and run:

```bash
# Clean and install dependencies
mvn clean install

# Start the Jetty development server
mvn jetty:run
```

The application will be available at: **[http://localhost:8081](http://localhost:8081)**

---

## 📂 Project Structure

-   `src/main/java/controller`: Servlets handling business logic and routing.
-   `src/main/java/dao`: Data Access Objects for database interaction.
-   `src/main/java/model`: POJO classes representing system entities.
-   `src/main/java/util`: Utilities (Database connection, Logging, File management).
-   `src/main/webapp/views`: JSP files for the user interface.
-   `src/main/webapp/uploads`: Storage directory for uploaded documents.

---

## 🛡️ Security & Auditing

The system enforces strict security checks. Only users with the **ADMIN** role can perform deletions and manage users. Every interaction is recorded in the **Audit Logs**, which can be reviewed by administrators to track system activity in real-time.

---

## 📄 License

Developed for School Management. All rights reserved.
