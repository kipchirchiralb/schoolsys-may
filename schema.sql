-- =====================================================================
-- SCHOOL MANAGEMENT SYSTEM — SIMPLE LEARNING SCHEMA
-- Database : MySQL 8.0+
-- Tables   : 6
-- Relations: 4 foreign keys only
--     student  -> classroom
--     marks    -> student, subject
--     results  -> student
--     messages -> stands alone (public contact form)
-- =====================================================================

DROP DATABASE IF EXISTS school_ms;
CREATE DATABASE school_ms;
USE school_ms;


-- ---------------------------------------------------------------------
-- 1. CLASSROOM
-- ---------------------------------------------------------------------
CREATE TABLE classroom (
    classroom_id   INT AUTO_INCREMENT PRIMARY KEY,
    classroom_name VARCHAR(50) NOT NULL UNIQUE,
    class_teacher  VARCHAR(100),
    capacity       INT DEFAULT 45
);

--  

-- ---------------------------------------------------------------------
-- 2. SUBJECT
-- ---------------------------------------------------------------------
CREATE TABLE subject (
    subject_id   INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(10) NOT NULL UNIQUE,
    subject_name VARCHAR(60) NOT NULL,
    category     VARCHAR(20)
);


-- ---------------------------------------------------------------------
-- 3. STUDENT   (belongs to one classroom)
-- ---------------------------------------------------------------------
CREATE TABLE student (
    student_id       INT AUTO_INCREMENT PRIMARY KEY,
    admission_number VARCHAR(20) NOT NULL UNIQUE,
    student_name     VARCHAR(100) NOT NULL,
    gender           ENUM('Male','Female') NOT NULL,
    date_of_birth    DATE,
    guardian_name    VARCHAR(100),
    guardian_phone   VARCHAR(20),
    classroom_id     INT,

    FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id)
);


-- ---------------------------------------------------------------------
-- 4. MARKS   (one score per student, per subject, per term)
-- ---------------------------------------------------------------------
CREATE TABLE marks (
    mark_id    INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    term       VARCHAR(10) NOT NULL,
    score      DECIMAL(5,2),
    grade      VARCHAR(2),

    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);


-- ---------------------------------------------------------------------
-- 5. RESULTS   (term summary per student)
-- ---------------------------------------------------------------------
CREATE TABLE results (
    result_id     INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    term          VARCHAR(10) NOT NULL,
    total_marks   DECIMAL(7,2),
    average_score DECIMAL(5,2),
    grade         VARCHAR(2),
    position      INT,
    remark        VARCHAR(100),

    FOREIGN KEY (student_id) REFERENCES student(student_id)
);


-- ---------------------------------------------------------------------
-- 6. MESSAGES   (enquiries from the school website)
-- ---------------------------------------------------------------------
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    phone      VARCHAR(20),
    email      VARCHAR(100),
    body       TEXT NOT NULL,
    status     VARCHAR(10) DEFAULT 'New',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =====================================================================
-- SEED DATA
-- =====================================================================

INSERT INTO classroom (classroom_name, class_teacher, capacity) VALUES
('Form 1 East',  'Mr. Kiprop Rono',   45),
('Form 2 West',  'Ms. Chebet Koech',  40),
('Form 3 North', 'Mr. Otieno Ochieng', 38);


INSERT INTO subject (subject_code, subject_name, category) VALUES
('101', 'Mathematics', 'Core'),
('102', 'English',     'Language'),
('103', 'Kiswahili',   'Language'),
('231', 'Biology',     'Science'),
('311', 'History',     'Humanity');


INSERT INTO student
(admission_number, student_name, gender, date_of_birth, guardian_name, guardian_phone, classroom_id) VALUES
('ADM/001', 'Brian Kiptoo',     'Male',   '2011-03-14', 'Joseph Kiptoo',  '0712345001', 1),
('ADM/002', 'Faith Chelagat',   'Female', '2011-07-02', 'Grace Chelagat', '0712345002', 1),
('ADM/003', 'Dennis Otieno',    'Male',   '2010-11-25', 'Peter Otieno',   '0712345003', 2),
('ADM/004', 'Mercy Wanjiku',    'Female', '2010-05-19', 'Alice Wanjiku',  '0712345004', 2),
('ADM/005', 'Kevin Barasa',     'Male',   '2009-09-08', 'Simon Barasa',   '0712345005', 3),
('ADM/006', 'Achieng Odhiambo', 'Female', '2009-12-30', 'Mary Achieng',   '0712345006', 3);


INSERT INTO marks (student_id, subject_id, term, score, grade) VALUES
-- Brian Kiptoo
(1, 1, 'Term 2', 78, 'A-'), (1, 2, 'Term 2', 65, 'B'),  (1, 3, 'Term 2', 70, 'B+'),
(1, 4, 'Term 2', 82, 'A'),  (1, 5, 'Term 2', 60, 'B-'),
-- Faith Chelagat
(2, 1, 'Term 2', 88, 'A'),  (2, 2, 'Term 2', 74, 'B+'), (2, 3, 'Term 2', 80, 'A'),
(2, 4, 'Term 2', 91, 'A'),  (2, 5, 'Term 2', 69, 'B'),
-- Dennis Otieno
(3, 1, 'Term 2', 55, 'C+'), (3, 2, 'Term 2', 62, 'B-'), (3, 3, 'Term 2', 58, 'C+'),
(3, 4, 'Term 2', 60, 'B-'), (3, 5, 'Term 2', 51, 'C'),
-- Mercy Wanjiku
(4, 1, 'Term 2', 92, 'A'),  (4, 2, 'Term 2', 85, 'A'),  (4, 3, 'Term 2', 79, 'A-'),
(4, 4, 'Term 2', 88, 'A'),  (4, 5, 'Term 2', 90, 'A'),
-- Kevin Barasa
(5, 1, 'Term 2', 41, 'D+'), (5, 2, 'Term 2', 53, 'C'),  (5, 3, 'Term 2', 47, 'C-'),
(5, 4, 'Term 2', 38, 'D'),  (5, 5, 'Term 2', 44, 'D+'),
-- Achieng Odhiambo
(6, 1, 'Term 2', 67, 'B'),  (6, 2, 'Term 2', 71, 'B+'), (6, 3, 'Term 2', 64, 'B-'),
(6, 4, 'Term 2', 73, 'B+'), (6, 5, 'Term 2', 58, 'C+');


INSERT INTO results (student_id, term, total_marks, average_score, grade, position, remark) VALUES
(1, 'Term 2', 355, 71.00, 'B+', 3, 'Good work, aim higher next term'),
(2, 'Term 2', 402, 80.40, 'A',  2, 'Very good performance'),
(3, 'Term 2', 286, 57.20, 'C+', 5, 'Fair, needs more effort'),
(4, 'Term 2', 434, 86.80, 'A',  1, 'Excellent performance, keep it up'),
(5, 'Term 2', 223, 44.60, 'D+', 6, 'Below average, seek extra help'),
(6, 'Term 2', 333, 66.60, 'B',  4, 'Steady improvement, well done');


INSERT INTO messages (name, phone, email, body, status) VALUES
('Joseph Kiptoo',  '0712345001', 'jkiptoo@example.com',
 'Kindly share the Term 2 closing date and the fee balance for my son.', 'New'),
('Alice Wanjiku',  '0712345004', 'awanjiku@example.com',
 'I would like to book an appointment with the class teacher.', 'Read'),
('Samuel Kimutai', '0722445566', 'skimutai@example.com',
 'What are the admission requirements for Form 1 next year?', 'Replied'),
('Mary Achieng',   '0712345006', 'machieng@example.com',
 'Please confirm the date for the parents meeting.', 'New');


-- =====================================================================
-- SAMPLE QUERIES FOR PRACTICE
-- =====================================================================

-- a) List students with their classroom
-- SELECT s.student_name, c.classroom_name
-- FROM student s
-- JOIN classroom c ON c.classroom_id = s.classroom_id;

-- b) Show one student's mark sheet
-- SELECT s.student_name, sub.subject_name, m.score, m.grade
-- FROM marks m
-- JOIN student s  ON s.student_id  = m.student_id
-- JOIN subject sub ON sub.subject_id = m.subject_id
-- WHERE s.admission_number = 'ADM/001';

-- c) Class ranking for Term 2
-- SELECT r.position, s.student_name, r.average_score, r.grade
-- FROM results r
-- JOIN student s ON s.student_id = r.student_id
-- WHERE r.term = 'Term 2'
-- ORDER BY r.position;