-- додаткове2 Оцінки студентів у певній групі з певного предмета на останньому занятті.

SELECT g.grade, g.date_of  
FROM grades g
JOIN students s ON g.student_id = s.id
WHERE s.group_id= 3
and g.course_id = 5
and g.date_of = (SELECT max(g1.date_of)FROM grades g1 JOIN students s1 ON g1.student_id = s1.id WHERE s1.group_id= 3 and g1.course_id = 5)
group by g.grade, g.date_of




