from datetime import datetime, timedelta
from random import randint, choice


import faker
import psycopg2


"""Заповніть отриману базу даних випадковими даними:
(~30-50 студентів, 3 групи, 5-8 предметів, 3-5 викладачів, 
до 20 оцінок у кожного студента з усіх предметів).
Використовуйте пакет Faker для наповнення. """


NAME_OF_GROUPS = ["група 1", "група 2", "група 3"]
COURSES = [
    "Вища математика",
    "Дискретна математика",
    "Лінійна Алгебра",
    "Програмування",
    "Теорія імовірності",
    "Історія України",
    "Англійська",
    "Креслення"
]

NUMBER_TEACHERS = 5
NUMBER_STUDENTS = 50


def generate_list_with_fake_names(required_amount) -> list[str]:
    res = []
    fake_data = faker.Faker()

    for _ in range(required_amount):
        res.append(fake_data.name())

    return res


def seed_groups():
    sql = "INSERT INTO students_groups(group_name) VALUES(%s);"
    cur.executemany(sql, zip(NAME_OF_GROUPS, ))


def seed_teachers():
    teachers = generate_list_with_fake_names(NUMBER_TEACHERS)
    sql = "INSERT INTO teachers(fullname) VALUES(%s);"
    cur.executemany(sql, zip(teachers, ))


def seed_students():
    cur.execute("SELECT id FROM students_groups")
    id_group_list = [i[0] for i in cur.fetchall()]
    students = generate_list_with_fake_names(NUMBER_STUDENTS)
    sql = "INSERT INTO students(fullname, group_id) VALUES(%s, %s);"
    cur.executemany(sql, zip(students,(choice(id_group_list) for _ in range(NUMBER_STUDENTS))))


def seed_courses():
    cur.execute("SELECT id FROM teachers")
    id_teachers_list = [i[0] for i in cur.fetchall()]
    sql = "INSERT INTO courses(name, teacher_id) VALUES(%s,%s);"
    cur.executemany(sql, zip(COURSES, (choice(id_teachers_list) for _ in range(len(COURSES)))))


def seed_grades():
    cur.execute("SELECT id FROM courses")
    id_courses_list = [i[0] for i in cur.fetchall()]
    cur.execute("SELECT id FROM students")
    id_students_list = [i[0] for i in cur.fetchall()]

    start_date = datetime.strptime("2022-09-01", "%Y-%m-%d")
    end_date = datetime.strptime("2023-06-15", "%Y-%m-%d")
    sql = "INSERT INTO grades(course_id, student_id, grade, date_of) VALUES(%s, %s, %s, %s);"

    def get_list_date(start, end) -> list:
        result = []
        current_date = start
        while current_date <= end:
            if current_date.isoweekday() < 6:
                result.append(current_date)
            current_date += timedelta(1)
        return result

    list_dates = get_list_date(start_date, end_date)

    grades = []

    for day in list_dates:
        random_discipline = choice(id_courses_list)
        random_students = [choice(id_students_list) for _ in range(5)]
        for student in random_students:
            grades.append((random_discipline, student, randint(1, 12), day.date()))


    cur.executemany(sql, grades)


if __name__ == '__main__':




    try:
        seed_groups()
        seed_teachers()
        seed_students()
        seed_courses()
        seed_grades()
        connect.commit()
        connect.close()
    except BaseException as error:
        print("Наповнення бази фейковими данними НЕ ВДАЛОСЬ, виникла наступна помилка: \n", error)
        connect.close()

