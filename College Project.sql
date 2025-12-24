create database CollegeProject;

use CollegeProject;

select * from STUDENTS;
select * from FACULTY;
select * from ENROLLMENTS;
select * from COURSES;

---1) Get the average grade for each student (considering A=4, B=3, C=2, D=1, F=0).

SELECT 
    s.StudentID,
    s.Name,
    AVG(
        CASE e.Grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END
    ) AS Avg_Grade
FROM STUDENTS s
JOIN ENROLLMENTS e 
    ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name;

---2) Find the average salary of instructors in each department.
SELECT department, 
       AVG(Salary) AS avg_salary
FROM FACULTY
GROUP BY department;

---3) List all courses that are taught by more than one instructor 

SELECT CourseID, CourseName, COUNT(InstructorID) AS InstructorCount
FROM COURSES
GROUP BY CourseID, CourseName;


---4) List all instructors who are teaching a course with fewer than 3 students enrolled.
SELECT 
    f.faculty_id,
    f.first_name,
    f.last_name,
    c.CourseName,
    COUNT(DISTINCT e.StudentID) AS student_count
FROM COURSES c
LEFT JOIN ENROLLMENTS e
    ON c.CourseID = e.CourseID
JOIN FACULTY f
    ON c.InstructorID = f.faculty_id
GROUP BY 
    f.faculty_id, f.first_name, f.last_name, c.CourseName
HAVING COUNT(DISTINCT e.StudentID) < 3;

---5) Find the total number of credits each student has earned, grouped by their major.

SELECT 
    s.Major,
    s.StudentID,
    s.Name,
    SUM(c.Credits) AS total_credits
FROM STUDENTS s
JOIN ENROLLMENTS e
    ON s.StudentID = e.StudentID
JOIN COURSES c
    ON e.CourseID = c.CourseID
WHERE e.Grade NOT IN ('F', 'Incomplete')  -- only count passed courses
GROUP BY s.Major, s.StudentID, s.Name
ORDER BY s.Major, total_credits DESC;


---6) List the top 3 students with the highest number of credits earned.
SELECT TOP 3 
    s.StudentID,
    s.Name,
    SUM(c.Credits) AS TotalCredits
FROM STUDENTS s
JOIN ENROLLMENTS e 
    ON s.StudentID = e.StudentID
JOIN COURSES c 
    ON e.CourseID = c.CourseID
GROUP BY s.StudentID, s.Name
ORDER BY TotalCredits DESC;





