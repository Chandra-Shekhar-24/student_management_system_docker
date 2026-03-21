/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 008_create_department.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `section` table for academic sections by group.
		        this is the eight table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS section(
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_section_name ON section(name);
CREATE INDEX idx_section_is_active ON section(is_active);

COMMENT ON TABLE section IS 'section by group within a course and semester(A,B,C)';
COMMENT ON COLUMN section.name IS 'section name , unique';
COMMENT ON COLUMN section.is_active IS 'weather the section is curently active or not'
