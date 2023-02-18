--3. Знайти середній бал у групах з певного предмета.


SELECT AVG(g.grade) ag, sg.group_name, c.name 
FROM students_groups sg
JOIN students s ON sg.id = s.group_id
JOIN grades g ON g.student_id = s.id
JOIN courses c ON g.course_id = c.id
WHERE g.course_id = 4
GROUP BY sg.group_name, c.name
