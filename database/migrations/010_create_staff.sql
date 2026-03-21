/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 010_create_staff.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `staff` table for all staff members (teacher, admin, manager, etc).
		        this is the tenth table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS staff(
    id SERIAL PRIMARY KEY,
    employee_id VARCHAR(20) UNIQUE,
    name VARCHAR(100) NOT NULL,
    age INTEGER,
    gender VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
    blood_group VARCHAR(5) CHECK(blood_group IN ('A+','A-','O+','O-','AB+', 'AB-','B+','B-','Unknown')),
    martial_status VARCHAR(20) CHECK (martial_status IN ('Single','Married','Divorce','Widowed')),
    date_of_birth DATE,
    aadhar_number VARCHAR(12) UNIQUE,
    pan_number VARCHAR(10) UNIQUE,
    pf_number VARCHAR(50),
    uan_number VARCHAR(50),
    address TEXT,
    permanent_address TEXT,
    joining_date DATE,
    relieving_date DATE,
    position VARCHAR(100),
    department_id INTEGER ,
    reporting_to INTEGER,
    salary NUMERIC(12,2),
    emergency_contact_name VARCHAR(100),
    emergency_contact VARCHAR(15),
    work_phone VARCHAR(15),
    qualificaton JSONB,
    bank_details JSONB,
    employee_status VARCHAR(20) DEFAULT 'Permanent' CHECK (employee_status IN ('Permanent','Contract','Intern','Probation')),
    contract_end_date DATE,
    is_teaching BOOLEAN DEFAULT FALSE,
    can_approve_leave BOOLEAN DEFAULT FALSE,
    hostel_id INTEGER ,
    avatar_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
	CONSTRAINT fk_staff_department FOREIGN KEY (department_id) REFERENCES department(id) ON DELETE CASCADE,
	CONSTRAINT fk_staff_reporting_to FOREIGN KEY (reporting_to) REFERENCES staff(id) ON DELETE CASCADE
);

CREATE INDEX idx_staff_employee_id ON staff(employee_id);
CREATE INDEX idx_staff_department_id ON staff(department_id);
CREATE INDEX idx_staff_deleted_at ON staff(deleted_at) WHERE deleted_at IS NULL;

COMMENT ON TABLE staff IS 'all staff members(teachers,manager, admins). authentication handle by users table';
COMMENT ON COLUMN staff.employee_id IS 'unique employee identifier';
COMMENT ON COLUMN staff.name IS 'full name of staff member';
COMMENT ON COLUMN staff.department_id IS 'references department.id';
COMMENT ON COLUMN staff.reporting_to IS 'self reference (manager/supervisior of this staff member)';
COMMENT ON COLUMN staff.salary IS 'monthly salary';
COMMENT ON COLUMN staff.qualificaton IS 'JSON array of qualifications'[{degree,institution ,year}];
COMMENT ON COLUMN staff.bank_details IS 'JSON object:{account_no,IFSC, bank_name}';
COMMENT ON COLUMN staff.employee_status IS 'current employment status';
COMMENT ON COLUMN staff.is_teaching IS 'true if this staff member is a teaching faculty';
COMMENT ON COLUMN staff.can_approve_leave IS 'weather this staff can approve leave applications';
COMMENT ON COLUMN staff.hostel_id IS 'hostel id if staff is a warden, references hostel.id (foreign key add later)';
COMMENT ON COLUMN staff.deleted_at IS 'soft delete timestamp';



