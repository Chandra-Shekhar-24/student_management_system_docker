/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 007_create_academic_session.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `academic_session` table for academic years by session.
		        this is the seventh table in the migration order.
===================================================================
*/


CREATE TABLE IF NOT EXISTS academic_session(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_academic_session_name ON academic_session(name);
CREATE INDEX idx_academic_session_is_active ON academic_session(is_active);
CREATE INDEX idx_academic_session_dates ON academic_session(start_date, end_date);

COMMENT ON TABLE academic_session IS 'academic years by session(e.g., 2025-2026)';
COMMENT ON COLUMN academic_session.name IS 'session name , unique';
COMMENT ON COLUMN academic_session.start_date IS 'start date of the session';
COMMENT ON COLUMN academic_session.end_date IS 'end date of the session';
COMMENT ON COLUMN academic_session.is_active IS 'weather this is the current active session or not';