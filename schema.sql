CREATE DATABASE IF NOT EXISTS school_management_abdsamad;
USE school_management_abdsamad;

-- USERS Table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'USER') NOT NULL,
    active BOOLEAN DEFAULT TRUE
);

-- STUDENTS Table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    field VARCHAR(100),
    deleted BOOLEAN DEFAULT FALSE
);

-- BOOKS Table
CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    deleted BOOLEAN DEFAULT FALSE
);

-- DOCUMENTS Table
CREATE TABLE IF NOT EXISTS documents (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    student_id INT,
    deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- BORROW Table
CREATE TABLE IF NOT EXISTS borrow (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    book_id INT,
    borrow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

-- LOGS Table
CREATE TABLE IF NOT EXISTS logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    action VARCHAR(50),
    module VARCHAR(50),
    url VARCHAR(255),
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Default Admin Account (password: admin123)
INSERT INTO users (username, password, role, active) VALUES ('admin', 'admin123', 'ADMIN', TRUE);
-- Default User Account (password: user123)
INSERT INTO users (username, password, role, active) VALUES ('user', 'user123', 'USER', TRUE);
