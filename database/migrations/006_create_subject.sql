/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 006_create_subject.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `subject` table for subjects within a course and semester.
		        this is the sixth table in the migration order.
===================================================================
*/


CREATE TABLE IF NOT EXISTS subject(
    id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL,
    credits INTEGER,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_subject_course FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
	CONSTRAINT unique_subject_course_semester_code UNIQUE (course_id, semester, code)
);

CREATE INDEX idx_subject_course_id ON subject(course_id);
CREATE INDEX idx_subject_course_semester ON subject(course_id,semester);
CREATE INDEX idx_subject_is_active ON subject(is_active);

COMMENT ON TABLE subject IS 'subjects taught in a specific course and semester';
COMMENT ON COLUMN subject.course_id IS 'references course_id ';
COMMENT ON COLUMN subject.semester IS 'semester number(1 to 8)';
COMMENT ON COLUMN subject.name IS 'subject name';
COMMENT ON COLUMN subject.code IS 'subject code(unique within course and semester)';
COMMENT ON COLUMN subject.credits IS 'credit hours for the subjects';
COMMENT ON COLUMN subject.is_active IS 'weather the subject is currently offered or not';


