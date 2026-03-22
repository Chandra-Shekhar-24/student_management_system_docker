/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 012_create_staff_section.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `staff_section` table for the faculty section allotment.
		        this is the twelvefth table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS staff_section(
    id SERIAL PRIMARY KEY,
    staff_id INTEGER NOT NULL,
    section_id INTEGER NOT NULL,
    academic_session_id INTEGER NOT NULL,
    semester INTEGER NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_staff_section_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
	CONSTRAINT fk_staff_section_section_id FOREIGN KEY (section_id) REFERENCES section(id) ON DELETE CASCADE,
	CONSTRAINT fk_staff_section_academic_session_id FOREIGN KEY (academic_session_id) REFERENCES academic_session(id) ON DELETE CASCADE,
	CONSTRAINT unique_staff_section UNIQUE (staff_id, academic_session_id,section_id, semester)
);

CREATE INDEX idx_staff_section_staff_id ON staff_section(staff_id);
CREATE INDEX idx_staff_section_section_id ON staff_section(section_id);
CREATE INDEX idx_staff_section_academic_session_id ON staff_section(academic_session_id);
CREATE INDEX idx_staff_section_semester ON staff_section(semester);


COMMENT ON TABLE staff_section IS 'faculty section allotment for a given session and semester';
COMMENT ON COLUMN staff_section.staff_id IS 'references staff.id(the faculty member)';
COMMENT ON COLUMN staff_section.section_id IS 'references section.id';
COMMENT ON COLUMN staff_section.academic_session_id IS 'references academic session.id';
COMMENT ON COLUMN staff_section.semester IS 'semester no.(1 to 8)';
COMMENT ON COLUMN staff_section.assigned_at IS 'timestamp when the allotment was created';