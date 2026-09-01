USE school_ms;

-- ---------------------------------------------------------------------
-- USERS TABLE
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     ENUM('admin', 'teacher') NOT NULL DEFAULT 'teacher'
);

-- ---------------------------------------------------------------------
-- ADD TEACHER REFERENCE TO CLASSROOM
-- ---------------------------------------------------------------------
ALTER TABLE classroom
    DROP COLUMN class_teacher;
ALTER TABLE classroom
    ADD COLUMN teacher_id INT NULL;

ALTER TABLE classroom
    ADD CONSTRAINT fk_classroom_teacher
    FOREIGN KEY (teacher_id) REFERENCES users(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- Example: a teacher can be assigned to a classroom
-- UPDATE classroom SET teacher_id = 1 WHERE classroom_id = 1;
