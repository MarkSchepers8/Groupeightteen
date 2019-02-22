COPY students(studentid, studentname, address, birthyearstudent, gender)
FROM '/home/student/tables/Students.table'
DELIMITER ',' CSV HEADER;
COPY degrees(degreeid, dept, degreedescription, totalects)
FROM '/home/student/tables/Degrees.table'
DELIMITER ',' CSV HEADER;
COPY studentregistrationstodegrees(studentregistrationid, studentid, degreeid, registrationyear)
FROM '/home/student/tables/StudentRegistrationsToDegrees.table'
DELIMITER ',' CSV HEADER;
COPY teachers(teacherid, teachername, address, birthyearteacher, gender)
FROM '/home/student/tables/Teachers.table'
DELIMITER ',' CSV HEADER;
COPY courses(courseid, coursename, coursedescription, degreeid, ects)
FROM '/home/student/tables/Courses.table'
DELIMITER ',' CSV HEADER;
COPY courseoffers(courseofferid, courseid, year, quartile)
FROM '/home/student/tables/CourseOffers.table'
DELIMITER ',' CSV HEADER;
COPY teacherassignmentstocourses(courseofferid, teacherid)
FROM '/home/student/tables/TeacherAssignmentsToCourses.table'
DELIMITER ',' CSV HEADER;
COPY studentassistants(courseofferid, studentregistrationid)
FROM '/home/student/tables/StudentAssistants.table'
DELIMITER ',' CSV HEADER;
COPY courseregistrations(courseofferid, studentregistrationid, grade)
FROM '/home/student/tables/CourseRegistrations.table'
DELIMITER ',' CSV HEADER NULL AS 'null';" 
