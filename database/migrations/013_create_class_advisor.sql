/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 013_create_class_advisor.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-22
Description   : creates the `class_advisor` table for all staff members (teacher, admin, manager, etc).
		        this is the thirteenth table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS class_advisor(
    id SERIAL PRIMARY KEY,
    staff_id INTEGER NOT NULL,
    section_id INTEGER NOT NULL,
    academic_session_id INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_class_advisor_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_class_advisor_section FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
    CONSTRAINT fk_class_advisor_academic_session FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
    CONSTRAINT unique_class_advisor UNIQUE (staff_id,section_id,academic_session_id,semester)
);

CREATE INDEX idx_class_advisor_staff_id ON class_advisor(staff_id);
CREATE INDEX idx_class_advisor_section_id ON class_advisor(section_id);
CREATE INDEX idx_class_advisor_academic_session_id ON class_advisor(academic_session_id);
CREATE INDEX idx_class_advisor_semester ON class_advisor(semester);
CREATE INDEX idx_class_advisor_is_active ON class_advisor(is_active);


COMMENT ON TABLE class_advisor IS 'class advisor assignment for a section and semester';
COMMENT ON COLUMN class_advisor.staff_id IS 'references staff.id(The advisor)'; 
COMMENT ON COLUMN class_advisor.section_id IS 'references section.id'; 
COMMENT ON COLUMN class_advisor.academic_session_id IS ''; 
COMMENT ON COLUMN class_advisor.semester IS 'semester no. (1 to 8)'; 
COMMENT ON COLUMN class_advisor.is_active IS 'weather this assignment is currently active or not'; 
COMMENT ON COLUMN class_advisor.assigned_at IS 'TIMESTAMP when the assignment was created'; 