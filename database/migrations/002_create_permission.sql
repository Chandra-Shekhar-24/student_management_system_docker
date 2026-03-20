/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 002_create_permission.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `permission` table which stores granular permission.
		        this is the second table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS permission (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	description TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM permission;

COMMENT ON TABLE permission IS 'granular permission that can be assigned to roles';
COMMENT ON COLUMN permission.id IS 'auto incrementing primary key';
COMMENT ON COLUMN permission.name IS 'unique permission name e.g., "student.view"';
COMMENT ON COLUMN permission.description IS 'optional';
COMMENT ON COLUMN permission.created_at IS 'UTC timestamp when the permission was created';

SELECT obj_description('permission' :: regclass) AS table_comment; 