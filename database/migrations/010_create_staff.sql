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



SELECT * FROM staff;
SELECT * FROM department;
TRUNCATE TABLE staff RESTART IDENTITY CASCADE;
TRUNCATE TABLE department RESTART IDENTITY CASCADE;

  






-- Insert 20 random staff records
INSERT INTO staff (
    employee_id, name, age, gender, blood_group, martial_status, date_of_birth,
    aadhar_number, pan_number, pf_number, uan_number, address, permanent_address,
    joining_date, relieving_date, position, department_id, reporting_to, salary,
    emergency_contact_name, emergency_contact, work_phone, qualificaton, bank_details,
    employee_status, contract_end_date, is_teaching, can_approve_leave, hostel_id,
    avatar_url, created_at, updated_at, deleted_at
) VALUES
('EMP001', 'Rajesh Kumar', 45, 'Male', 'A+', 'Married', '1979-05-15', 
 '123456789012', 'ABC1234567', 'PF001234', 'UAN123456', '123 Main St, Mumbai', '456 Village Rd, Bihar', 
 '2010-06-01', NULL, 'Senior Teacher', 1, NULL, 75000.00,
 'Sunita Kumar', '9876543210', '9876543210', '{"degree":"M.Sc","specialization":"Mathematics","year":2005}', '{"bank":"SBI","account":"12345678901","ifsc":"SBIN001234"}',
 'Permanent', NULL, TRUE, TRUE, NULL,
 'https://example.com/avatars/rajesh.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP002', 'Priya Sharma', 38, 'Female', 'O+', 'Married', '1986-03-22',
 '234567890123', 'DEF2345678', 'PF002345', 'UAN234567', '789 Park Ave, Delhi', '789 Park Ave, Delhi',
 '2012-08-15', NULL, 'English Teacher', 1, 1, 65000.00,
 'Amit Sharma', '8765432109', '8765432109', '{"degree":"MA","specialization":"English Literature","year":2008}', '{"bank":"HDFC","account":"23456789012","ifsc":"HDFC001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/priya.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP003', 'Amit Verma', 42, 'Male', 'B+', 'Married', '1982-11-10',
 '345678901234', 'GHI3456789', 'PF003456', 'UAN345678', '456 Lake Rd, Bangalore', '123 Old City, UP',
 '2011-03-20', NULL, 'Physics Teacher', 1, 1, 72000.00,
 'Neha Verma', '7654321098', '7654321098', '{"degree":"M.Sc","specialization":"Physics","year":2006}', '{"bank":"ICICI","account":"34567890123","ifsc":"ICICI001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/amit.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP004', 'Deepa Nair', 35, 'Female', 'A-', 'Single', '1989-07-18',
 '456789012345', 'JKL4567890', 'PF004567', 'UAN456789', '321 Hill St, Chennai', '321 Hill St, Chennai',
 '2014-01-10', NULL, 'Chemistry Teacher', 1, 2, 68000.00,
 'Suresh Nair', '6543210987', '6543210987', '{"degree":"M.Sc","specialization":"Chemistry","year":2010}', '{"bank":"Axis","account":"45678901234","ifsc":"UTIB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/deepa.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP005', 'Vikram Singh', 50, 'Male', 'O-', 'Married', '1974-12-05',
 '567890123456', 'MNO5678901', 'PF005678', 'UAN567890', '789 Royal Rd, Jaipur', '456 Village Rd, Rajasthan',
 '2008-09-01', NULL, 'Principal', 3, NULL, 120000.00,
 'Meena Singh', '5432109876', '5432109876', '{"degree":"PhD","specialization":"Education Administration","year":2003}', '{"bank":"SBI","account":"56789012345","ifsc":"SBIN009876"}',
 'Permanent', NULL, FALSE, TRUE, NULL,
 'https://example.com/avatars/vikram.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP006', 'Neha Gupta', 29, 'Female', 'AB+', 'Single', '1995-03-12',
 '678901234567', 'PQR6789012', 'PF006789', 'UAN678901', '234 Garden Rd, Pune', '234 Garden Rd, Pune',
 '2018-06-20', NULL, 'Computer Teacher', 1, 2, 55000.00,
 'Raj Gupta', '4321098765', '4321098765', '{"degree":"MCA","specialization":"Computer Science","year":2016}', '{"bank":"Kotak","account":"67890123456","ifsc":"KKBK001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/neha.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP007', 'Arjun Reddy', 33, 'Male', 'B-', 'Married', '1991-08-25',
 '789012345678', 'STU7890123', 'PF007890', 'UAN789012', '567 Lakeview Rd, Hyderabad', '567 Lakeview Rd, Hyderabad',
 '2015-02-15', NULL, 'Sports Teacher', 1, 3, 58000.00,
 'Lakshmi Reddy', '3210987654', '3210987654', '{"degree":"BPEd","specialization":"Physical Education","year":2012}', '{"bank":"Canara","account":"78901234567","ifsc":"CNRB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/arjun.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP008', 'Sneha Patil', 27, 'Female', 'O+', 'Single', '1997-11-03',
 '890123456789', 'VWX8901234', 'PF008901', 'UAN890123', '890 Park St, Nashik', '890 Park St, Nashik',
 '2019-07-01', NULL, 'Art Teacher', 1, 3, 48000.00,
 'Anil Patil', '2109876543', '2109876543', '{"degree":"BFA","specialization":"Fine Arts","year":2018}', '{"bank":"BOB","account":"89012345678","ifsc":"BARB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/sneha.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP009', 'Karthik Iyer', 41, 'Male', 'A+', 'Married', '1983-04-17',
 '901234567890', 'YZA9012345', 'PF009012', 'UAN901234', '123 Temple Rd, Coimbatore', '123 Temple Rd, Coimbatore',
 '2012-11-10', NULL, 'Mathematics Teacher', 1, 2, 70000.00,
 'Divya Iyer', '1098765432', '1098765432', '{"degree":"M.Sc","specialization":"Mathematics","year":2007}', '{"bank":"Indian Bank","account":"90123456789","ifsc":"IDIB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/karthik.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP010', 'Meera Nair', 31, 'Female', 'AB-', 'Married', '1993-09-28',
 '012345678901', 'ABC0123456', 'PF010123', 'UAN012345', '456 Beach Rd, Kochi', '456 Beach Rd, Kochi',
 '2016-04-05', NULL, 'Biology Teacher', 1, 4, 62000.00,
 'Rajan Nair', '0987654321', '0987654321', '{"degree":"M.Sc","specialization":"Botany","year":2014}', '{"bank":"Federal Bank","account":"01234567890","ifsc":"FDRL001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/meera.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP011', 'Sanjay Mishra', 36, 'Male', 'B+', 'Divorce', '1988-06-20',
 '112233445566', 'DEF1234567', 'PF011234', 'UAN1234567', '789 MG Rd, Bhopal', '789 MG Rd, Bhopal',
 '2013-09-12', NULL, 'IT Administrator', 4, 5, 65000.00,
 'Rekha Mishra', '9876543211', '9876543211', '{"degree":"BCA","specialization":"IT","year":2009}', '{"bank":"SBI","account":"11223344556","ifsc":"SBIN001234"}',
 'Permanent', NULL, FALSE, TRUE, NULL,
 'https://example.com/avatars/sanjay.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP012', 'Anjali Desai', 44, 'Female', 'A-', 'Married', '1980-02-14',
 '223344556677', 'GHI2345678', 'PF012345', 'UAN2345678', '321 Lake Rd, Ahmedabad', '321 Lake Rd, Ahmedabad',
 '2011-01-20', NULL, 'Accountant', 5, 5, 60000.00,
 'Rajesh Desai', '8765432110', '8765432110', '{"degree":"M.Com","specialization":"Finance","year":2004}', '{"bank":"HDFC","account":"22334455667","ifsc":"HDFC001234"}',
 'Permanent', NULL, FALSE, FALSE, NULL,
 'https://example.com/avatars/anjali.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP013', 'Rahul Sharma', 26, 'Male', 'O+', 'Single', '1998-04-30',
 '334455667788', 'JKL3456789', 'PF013456', 'UAN3456789', '654 Park Ave, Chandigarh', '654 Park Ave, Chandigarh',
 '2020-08-01', NULL, 'Junior Teacher', 1, 3, 38000.00,
 'Ramesh Sharma', '7654321123', '7654321123', '{"degree":"B.Sc","specialization":"Physics","year":2019}', '{"bank":"ICICI","account":"33445566778","ifsc":"ICICI001234"}',
 'Probation', '2021-07-31', TRUE, FALSE, NULL,
 'https://example.com/avatars/rahul.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP014', 'Swati Joshi', 39, 'Female', 'B-', 'Married', '1985-07-25',
 '445566778899', 'MNO4567890', 'PF014567', 'UAN4567890', '987 Hill Rd, Dehradun', '987 Hill Rd, Dehradun',
 '2010-03-15', NULL, 'Librarian', 6, 4, 52000.00,
 'Vivek Joshi', '6543211234', '6543211234', '{"degree":"MLIS","specialization":"Library Science","year":2007}', '{"bank":"Axis","account":"44556677889","ifsc":"UTIB001234"}',
 'Permanent', NULL, FALSE, FALSE, NULL,
 'https://example.com/avatars/swati.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP015', 'Manoj Tiwari', 48, 'Male', 'AB+', 'Married', '1976-12-01',
 '556677889900', 'PQR5678901', 'PF015678', 'UAN5678901', '741 Market Rd, Lucknow', '741 Market Rd, Lucknow',
 '2009-05-10', NULL, 'Vice Principal', 3, 5, 95000.00,
 'Pooja Tiwari', '5432101234', '5432101234', '{"degree":"PhD","specialization":"Chemistry","year":2001}', '{"bank":"SBI","account":"55667788990","ifsc":"SBIN009876"}',
 'Permanent', NULL, FALSE, TRUE, NULL,
 'https://example.com/avatars/manoj.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP016', 'Kavita Singh', 34, 'Female', 'O-', 'Single', '1990-01-15',
 '667788990011', 'STU6789012', 'PF016789', 'UAN6789012', '852 Garden Rd, Patna', '852 Garden Rd, Patna',
 '2014-07-22', NULL, 'History Teacher', 1, 2, 59000.00,
 'Sanjay Singh', '4321012345', '4321012345', '{"degree":"MA","specialization":"History","year":2011}', '{"bank":"Kotak","account":"66778899001","ifsc":"KKBK001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/kavita.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP017', 'Vijay Kumar', 52, 'Male', 'A+', 'Widowed', '1972-09-08',
 '778899001122', 'VWX7890123', 'PF017890', 'UAN7890123', '963 Temple Rd, Varanasi', '963 Temple Rd, Varanasi',
 '2007-08-01', NULL, 'Counsellor', 2, 4, 68000.00,
 'Arun Kumar', '3210123456', '3210123456', '{"degree":"MA","specialization":"Psychology","year":1998}', '{"bank":"Canara","account":"77889900112","ifsc":"CNRB001234"}',
 'Permanent', NULL, FALSE, TRUE, 1,
 'https://example.com/avatars/vijay.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP018', 'Pooja Mehta', 28, 'Female', 'B+', 'Single', '1996-05-19',
 '889900112233', 'XYZ8901234', 'PF018901', 'UAN8901234', '159 Lake Rd, Surat', '159 Lake Rd, Surat',
 '2019-01-15', NULL, 'Dance Teacher', 1, 6, 45000.00,
 'Harsh Mehta', '2101234567', '2101234567', '{"degree":"BPA","specialization":"Dance","year":2017}', '{"bank":"BOB","account":"88990011223","ifsc":"BARB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/pooja.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP019', 'Suresh Reddy', 30, 'Male', 'A-', 'Married', '1994-10-10',
 '990011223344', 'ABC9012345', 'PF019012', 'UAN9012345', '753 Beach Rd, Vizag', '753 Beach Rd, Vizag',
 '2017-06-10', NULL, 'Physical Education Teacher', 1, 4, 54000.00,
 'Jyoti Reddy', '1091234567', '1091234567', '{"degree":"MPEd","specialization":"Physical Education","year":2015}', '{"bank":"Indian Bank","account":"99001122334","ifsc":"IDIB001234"}',
 'Permanent', NULL, TRUE, FALSE, NULL,
 'https://example.com/avatars/suresh.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL),

('EMP020', 'Shalini Verma', 32, 'Female', 'AB-', 'Married', '1992-12-05',
 '001122334455', 'DEF0123456', 'PF020123', 'UAN0123456', '357 Park St, Nagpur', '357 Park St, Nagpur',
 '2015-11-20', NULL, 'Music Teacher', 1, 6, 51000.00,
 'Akash Verma', '0981234567', '0981234567', '{"degree":"MA","specialization":"Music","year":2013}', '{"bank":"Federal Bank","account":"00112233445","ifsc":"FDRL001234"}',
 'Contract', '2021-12-31', TRUE, FALSE, NULL,
 'https://example.com/avatars/shalini.jpg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL);
