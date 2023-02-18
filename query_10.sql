-- 10. Список курсів, які певному студенту читає певний викладач.

SELECT c.name
FROM courses c
JOIN grades g ON g.course_id = c.id
WHERE g.student_id=3 and c.teacher_id = 5
GROUP BY c.name