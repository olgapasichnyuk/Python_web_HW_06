--2. Знайти студента із найвищим середнім балом з певного предмета.

SELECT s.fullname, avg(g.grade) avg_grade, c.name 
FROM grades g
JOIN students s on g.student_id = s.id
JOIN courses c on g.course_id = c.id
WHERE c.id = 4
GROUP BY s.fullname, c.name
ORDER BY avg_grade
DESC
LIMIT 1