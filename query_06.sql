-- 6 Знайти список студентів у певній групі.

SELECT s.fullname
FROM students s
JOIN students_groups sg ON s.group_id = sg.id 
WHERE sg.id=2
GROUP BY s.fullname