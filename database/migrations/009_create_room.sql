/* ================================================================
FILE INFORMATION
===================================================================
File Name     : 009_create_room.sql
Developer     : Chandra Shekhar Bansal
Contact       : chandrashekahrbansal.2006@gmail.com
Version       : 1.0.0 
Date          : 2026-03-21
Description   : creates the `room` table for physical classroom by room.
		        this is the ninth table in the migration order.
===================================================================
*/
CREATE TABLE IF NOT EXISTS room(
    id SERIAL PRIMARY KEY,
    room_number VARCHAR(20) UNIQUE NOT NULL,
    capacity INTEGER,
    building VARCHAR(100),
    floor INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_room_room_number ON room(room_number);
CREATE INDEX idx_room_building ON room(building);
CREATE INDEX idx_room_is_active ON room(is_active);

COMMENT ON TABLE room IS 'physical classroom by room for timetable and exam scheduling';
COMMENT ON COLUMN room.room_number IS 'room number or identified by unique';
COMMENT ON COLUMN room.capacity IS 'maximum sitting capacity';
COMMENT ON COLUMN room.building IS 'building number';
COMMENT ON COLUMN room.floor IS 'floor number';
COMMENT ON COLUMN room.is_active IS 'weather the room is currently available for scheduling or not';

