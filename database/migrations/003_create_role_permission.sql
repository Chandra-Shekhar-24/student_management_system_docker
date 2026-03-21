/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 003_create_role_permission.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `role_permission` table which maps roles to permission.
		        this is the third table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS role_permission(
	id SERIAL PRIMARY KEY,
	role_id INTEGER NOT NULL,
	permission_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_role_permission_role FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
	CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE,
	CONSTRAINT unique_role_permission UNIQUE (role_id, permission_id)
);

COMMENT ON TABLE role_permission IS 'maps roles to permissions(many to many)';
COMMENT ON COLUMN role_permission.id IS 'auto incrementing primary key';
COMMENT ON COLUMN role_permission.role_id IS 'foreign key to role.id';
COMMENT ON COLUMN role_permission.permission_id IS 'foreign key to permission.id';
COMMENT ON COLUMN role_permission.created_at IS 'UTC timestamp when the mapping was created';
CREATE INDEX IF NOT EXISTS idx_role_permission_role ON role_permission(role_id);
CREATE INDEX IF NOT EXISTS idx_role_permission_permission ON role_permission(permission_id);