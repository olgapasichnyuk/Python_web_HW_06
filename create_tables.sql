/*Реалізуйте базу даних, схема якої містить:

Таблиця студентів;
Таблицю груп;
Таблицю викладачів;
Таблицю предметів із вказівкою викладача, який читає предмет;
Таблицю, де у кожного студента є оцінки з предметів із зазначенням коли оцінку отримано

*/

DROP TABLE IF EXISTS students_groups CASCADE;
CREATE TABLE students_groups (
id SERIAL PRIMARY KEY NOT NULL,
group_name VARCHAR(10) UNIQUE
);


DROP TABLE IF EXISTS teachers CASCADE;
CREATE TABLE teachers (
  id SERIAL PRIMARY key NOT NULL,
  fullname VARCHAR(50)
);

DROP TABLE IF EXISTS students CASCADE;
CREATE TABLE students (
  id SERIAL PRIMARY key NOT NULL,
  fullname VARCHAR(50),
  group_id INTEGER REFERENCES students_groups (id)
);


DROP TABLE IF EXISTS courses CASCADE;
CREATE TABLE courses (
  id SERIAL PRIMARY key NOT NULL,
  name VARCHAR(50),
  teacher_id INTEGER REFERENCES teachers (id)
);


DROP TABLE IF EXISTS grades CASCADE;
CREATE TABLE grades (
  id SERIAL PRIMARY key NOT NULL,
  course_id INTEGER REFERENCES courses(id),
  student_id INTEGER REFERENCES students (id),
  grade INTEGER,
  date_of DATE
);

