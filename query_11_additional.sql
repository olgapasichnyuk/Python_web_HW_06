-- додаткове1 Середній бал, який певний викладач ставить певному студентові.

SELECT AVG(g.grade)
FROM grades g
JOIN courses c ON g.course_id = c.id
WHERE g.student_id=2 and c.teacher_id = 3
