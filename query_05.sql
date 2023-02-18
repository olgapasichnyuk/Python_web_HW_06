--5. Знайти які курси читає певний викладач.

SELECT c.name, t.fullname
FROM courses c
JOIN teachers t ON c.teacher_id = t.id
GROUP BY c.name, t.fullname


