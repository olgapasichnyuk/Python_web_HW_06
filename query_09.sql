-- 9. Знайти список курсів, які відвідує студент

SELECT c.name
FROM courses c
JOIN grades g ON g.course_id = c.id
WHERE g.student_id=3
GROUP BY c.name