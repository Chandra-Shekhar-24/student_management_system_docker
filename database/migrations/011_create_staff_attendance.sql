/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 011_create_staff_attendance.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `staff_attendance` table for daily staff punch in/out.
		        this is the eleventh table in the migration order.
===================================================================
*/

CREATE TABLE IF NOT EXISTS staff_attendance(
    id SERIAL PRIMARY KEY,
    staff_id INTEGER NOT NULL,
    date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    status VARCHAR(20) DEFAULT 'Present' CHECK(status IN ('Present','Absent','Late','Half Day','Leave')),
    remarks TEXT,
    recorded_by INTEGER ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_staff_attendance_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    CONSTRAINT fk_staff_attendance_recorded_by FOREIGN KEY (recorded_by) REFERENCES staff(id) ON DELETE SET NULL, 
    CONSTRAINT unique_staff_attendance_date UNIQUE (staff_id,date)
);

    /*
     * CONSTRAINT fk_staff_attendance_staff FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE;
     * when a record in the `staff` table is deleted , all rows in `staff_attendance` that refer to that `staff_id` are automatically as deleted as well.
     * e.g., if a staff member leaves the institution and we remove their record form staff , we also want to remove their history (Since it no longer exist).This keep the database clean
    */

    /*
    * CONSTRAINT fk_staff_attendance_recorded_by FOREIGN KEY (recorded_by) REFERENCES staff(staff_id) ON DELETE SET NULL; 
    * when a staff member (who recored and attendance )is deleted, the `recorded_by` column in  `staff_attendance` is set to NULL instead of deleting the attendance record
    * e.g., the attendance record itself is stiil useful (it tells us a staff member was present or absent) even if the person who recored it is no longer in the system. we don't want to lose that data,so we just set the `recorded_by` reference to NULL
    */

    /*
     * CONSTRAINT unique_staff_attendance_date UNIQUE (staff_id,date);
     * ensure that for a given `staff_id`and date, their can be only one in the table
     * e.g., a staff member should have only one attendance record per day (no duplicates).This prevents accidental duplicate entries for the same day
    */

    /*
     * NULL vs NOT NULL
     NULL means "no value" or "unknown". It's not the same as empty string or zero. A column can be defined as NULL(the default value if you don't specify) or NOT NULL 
     * NOT NULL forces a column to always have a value . You can not insert a row without providing a value for that column
     * in our above table
     *  `staff_id` is NOT NULL(implicitly because it's a foreign key without set NULL and we have on delete cascade)    
    */




CREATE INDEX idx_staff_attendance_staff_id ON staff_attendance(staff_id);
CREATE INDEX idx_staff_attendance_date ON staff_attendance(date);
CREATE INDEX idx_staff_attendance_status ON staff_attendance(status);

COMMENT ON TABLE staff_attendance IS 'daily attendance records for staff(punch in/out)';
COMMENT ON COLUMN staff_attendance.staff_id IS 'references staff.id';
COMMENT ON COLUMN staff_attendance.date IS 'attendance date';
COMMENT ON COLUMN staff_attendance.check_in IS 'punch in time';
COMMENT ON COLUMN staff_attendance.check_out IS 'punch out time';
COMMENT ON COLUMN staff_attendance.check_out IS 'punch out time';
COMMENT ON COLUMN staff_attendance.status IS 'attendance status';
COMMENT ON COLUMN staff_attendance.recorded_by IS 'staff who recored this (system & HR)';