COPY students(studentid, studentname, address, birthyearstudent, gender)
FROM '/mnt/ramdisk/tables/Students.table'
DELIMITER ',' CSV HEADER;
COPY degrees(degreeid, dept, degreedescription, totalects)
FROM '/mnt/ramdisk/tables/Degrees.table'
DELIMITER ',' CSV HEADER;
COPY studentregistrationstodegrees(studentregistrationid, studentid, degreeid, registrationyear)
FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table'
DELIMITER ',' CSV HEADER;
COPY teachers(teacherid, teachername, address, birthyearteacher, gender)
FROM '/mnt/ramdisk/tables/Teachers.table'
DELIMITER ',' CSV HEADER;
COPY courses(courseid, coursename, coursedescription, degreeid, ects)
FROM '/mnt/ramdisk/tables/Courses.table'
DELIMITER ',' CSV HEADER;
COPY courseoffers(courseofferid, courseid, year, quartile)
FROM '/mnt/ramdisk/tables/CourseOffers.table'
DELIMITER ',' CSV HEADER;
COPY teacherassignmentstocourses(courseofferid, teacherid)
FROM '/mnt/ramdisk/tables/TeacherAssignmentsToCourses.table'
DELIMITER ',' CSV HEADER;
COPY studentassistants(courseofferid, studentregistrationid)
FROM '/mnt/ramdisk/tables/StudentAssistants.table'
DELIMITER ',' CSV HEADER;
COPY courseregistrations(courseofferid, studentregistrationid, grade)
FROM '/mnt/ramdisk/tables/CourseRegistrations.table'
DELIMITER ',' CSV HEADER NULL AS 'null';" 
