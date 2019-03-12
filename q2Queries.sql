SELECT CourseName, Grade FROM StudentRegistrationsToDegrees as srtd INNER JOIN CourseRegistrations ON srtd.StudentRegistrationId = CourseRegistrations.StudentRegistrationId INNER JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId INNER JOIN Courses ON CourseOffers.CourseId = Courses.CourseId WHERE srtd.StudentId = %1% AND srtd.DegreeId = %2% AND Grade >= 5 ORDER BY Year, Quartile, CourseOffers.CourseOfferId;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT StudentId, count(StudentId) as numberOfCoursesWhereExcellent FROM HighestGradeCourseOffers GROUP BY StudentId HAVING count(studentid) >= %1%;
SELECT degreeid, birthyearstudent as birthyear, gender, avg(gpa) as avgGrade FROM Students INNER JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId INNER JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);
WITH NumAssistantsCourseOffer as(SELECT CourseOfferId, Count(StudentRegistrationId) as NumAssistants FROM CourseOffers LEFT JOIN StudentAssistants ON StudentAssistants.CourseOfferId = CourseOffers.CourseOfferId GROUP BY CourseOfferId), NumStudentsCourseOffer as(SELECT CourseOfferId, Count(StudentRegistrationId) as NumStudents FROM CourseRegistrations GROUP BY CourseOfferId) SELECT CourseName, Year, Quartile FROM CourseOffers LEFT JOIN NumAssistantsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId INNER JOIN Courses ON Courses.CourseId = CourseOffers.CourseId WHERE CAST(NumStudents as float)/CAST(NumAssistants as float)>50 ORDER BY CourseOffers.CourseOfferId;
