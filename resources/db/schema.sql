-- Create database
CREATE DATABASE IF NOT EXISTS rfid_attendance;
USE rfid_attendance;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    rfid_uid VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('student', 'teacher', 'admin')),
    status VARCHAR(10) NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    photo_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students Table
CREATE TABLE IF NOT EXISTS students (
    user_id INT PRIMARY KEY,
    grade VARCHAR(20) NOT NULL,
    section VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Attendance Table
CREATE TABLE IF NOT EXISTS attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    date DATE NOT NULL,
    time_in TIME,
    time_out TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (user_id, date)
);

-- Create indexes for better performance
CREATE INDEX idx_users_rfid ON users(rfid_uid);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_attendance_date ON attendance(date);
CREATE INDEX idx_attendance_user ON attendance(user_id);