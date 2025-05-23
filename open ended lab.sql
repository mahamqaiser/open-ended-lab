-- 1. Create tables

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    major VARCHAR(50)
);

CREATE TABLE Organizers (
    organizer_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    title VARCHAR(150),
    description TEXT,
    event_date DATE,
    location VARCHAR(100),
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY,
    student_id INT,
    event_id INT,
    registration_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- 2. Insert sample data

-- Students
INSERT INTO Students VALUES
(1, 'Alice Johnson', 'alice@university.edu', 'Computer Science'),
(2, 'Bob Smith', 'bob@university.edu', 'Mechanical Engineering'),
(3, 'Carol Davis', 'carol@university.edu', 'Psychology'),
(4, 'David Lee', 'david@university.edu', 'Business'),
(5, 'Eva Wang', 'eva@university.edu', 'Biology');

-- Organizers
INSERT INTO Organizers VALUES
(1, 'Tech Club', 'techclub@university.edu'),
(2, 'Music Society', 'music@university.edu'),
(3, 'Sports Committee', 'sports@university.edu'),
(4, 'Art Club', 'artclub@university.edu'),
(5, 'Drama Club', 'drama@university.edu');

-- Events
INSERT INTO Events VALUES
(1, 'AI Workshop', 'A workshop on Artificial Intelligence basics', '2025-06-10', 'Room 101', 1),
(2, 'Jazz Night', 'Live Jazz music event', '2025-06-15', 'Auditorium', 2),
(3, 'Football Tournament', 'Inter-college football matches', '2025-07-01', 'Sports Field', 3),
(4, 'Painting Exhibition', 'Exhibition of student artwork', '2025-06-20', 'Art Gallery', 4),
(5, 'Drama Play', 'Annual drama club performance', '2025-06-25', 'Theater Hall', 5);

-- Registrations
INSERT INTO Registrations VALUES
(1, 1, 1, '2025-05-20'),
(2, 2, 1, '2025-05-21'),
(3, 3, 2, '2025-05-22'),
(4, 4, 3, '2025-05-23'),
(5, 5, 3, '2025-05-24'),
(6, 1, 3, '2025-05-25'),
(7, 2, 4, '2025-05-26'),
(8, 3, 5, '2025-05-27'),
(9, 4, 2, '2025-05-28'),
(10, 5, 1, '2025-05-29');

-- Display all data from Students table
SELECT * FROM Students;

-- Display all data from Organizers table
SELECT * FROM Organizers;

-- Display all data from Events table
SELECT * FROM Events;

-- Display all data from Registrations table
SELECT * FROM Registrations;


-- 1. List all students alphabetically by name
SELECT name, email, major
FROM Students
ORDER BY name ASC;

-- 2. Find all events happening at the 'Auditorium'
SELECT title, event_date, location
FROM Events
WHERE location = 'Auditorium';

-- 3. Find organizers whose name contains the word 'Club'
SELECT *
FROM Organizers
WHERE name LIKE '%Club%';

-- 4. Count how many events each organizer manages
SELECT organizer_id, COUNT(event_id) AS total_events
FROM Events
GROUP BY organizer_id;

-- 5. Show all registrations made on or after '2025-05-25'
SELECT registration_id, student_id, event_id, registration_date
FROM Registrations
WHERE registration_date >= '2025-05-25';

-- 6. Get a list of all events along with the number of registrations (including events with zero registrations)
SELECT E.title, COUNT(R.registration_id) AS registrations_count
FROM Events E
LEFT JOIN Registrations R ON E.event_id = R.event_id
GROUP BY E.event_id, E.title;

-- 7. List students along with the events they registered for (including students with no registrations)
SELECT S.name, E.title
FROM Students S
LEFT JOIN Registrations R ON S.student_id = R.student_id
LEFT JOIN Events E ON R.event_id = E.event_id;

-- 8. Find the earliest event date
SELECT MIN(event_date) AS earliest_event
FROM Events;

-- 9. List students with majors that start with 'B'
SELECT *
FROM Students
WHERE major LIKE 'B%';

-- 10. Get events and organizers’ contact emails
SELECT E.title, O.contact_email
FROM Events E
JOIN Organizers O ON E.organizer_id = O.organizer_id;

