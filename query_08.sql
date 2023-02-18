--8. Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT AVG(g.grade), c.name
FROM grades g
JOIN courses c ON g.course_id = c.id
WHERE c.teacher_id=5
GROUP BY c.teacher_id, c.name