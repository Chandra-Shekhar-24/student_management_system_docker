/* =================================================
FILE INFORMATION
=================================================
File Name     : 001_create_role.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-20
Description   : creates the `roles` tables which store system roles.
		        this is the first table in the migration order.
=================================================

What is migration?
==================
A database migration is like a version control system for your database
*/

CREATE TABLE IF NOT EXISTS role(
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) UNIQUE NOT NULL CHECK(name IN ('superadmin','admin','teacher','manager','parent','student')),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE role IS 'SYSTEM ROLES(superadmin, admin , teacher, manager,parent, student)';
COMMENT ON COLUMN role.id IS 'auto incrementing primary key';
COMMENT ON COLUMN role.name IS 'unique role name';
COMMENT ON COLUMN role.description IS 'optional description';
COMMENT ON COLUMN role.created_at IS 'UTC time stamp when the role was created';

-- ===============================================================================
-- initial data
-- ============
INSERT INTO role (name, description) VALUES
('superadmin', 'Full System Access'),
('admin', 'Administrative Staff'),
('teacher','Teaching Staff'),
('manager','Limited AdminIstrative Access'),
('student','Default Role For Student'),
('parent','Parent/Guardian Role')
ON CONFLICT (name) DO NOTHING;

SELECT * FROM role;
 
SELECT column_name, data_type, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'role';

SELECT obj_description('role' :: regclass) AS table_comment; 
SELECT column_name , pg_catalog.col_description(('role' :: regclass) :: oid, ordinal_position) AS column_comment
FROM information_schema.columns
WHERE table_name = 'role' 	
ORDER BY ordinal_position;
