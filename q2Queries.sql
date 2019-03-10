SELECT CourseName, Grade FROM StudentRegistrationsToDegrees as srtd INNER JOIN CourseRegistrations ON srtd.StudentRegistrationId = CourseRegistrations.StudentRegistrationId LEFT JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseRegistrations.CourseOfferId LEFT JOIN Courses ON CourseOffers.CourseId = Courses.CourseId WHERE srtd.StudentId = %1% AND srtd.StudentRegistrationId = %2% AND Grade >= 5 ORDER BY Year, Quartile, CourseOffers.CourseOfferId;
SELECT DISTINCT StudentId FROM DegreeCompleted LEFT JOIN CourseRegistrations ON CourseRegistrations.StudentRegistrationId = DegreeCompleted.StudentRegistrationId LEFT JOIN GPA ON GPA.StudentRegistrationId = DegreeCompleted.StudentRegistrationId AND GPA.GPA > %1% GROUP BY StudentId;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT StudentId, count(StudentId) as numberOfCoursesWhereExcellent FROM HighestGradeCourseOffers GROUP BY StudentId HAVING count(studentid) >= %1%;
SELECT degreeid, birthyearstudent as birthyear, gender, avg(gpa) as avgGrade FROM Students LEFT JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId LEFT JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);
WITH NumAssistantsCourseOffer as(SELECT CourseOfferId, Count(StudentRegistrationId) as NumAssistants FROM StudentAssistants GROUP BY CourseOfferId HAVING Count(StudentRegistrationId)>0), NumStudentsCourseOffer as(SELECT CourseOfferId, Count(StudentRegistrationId) as NumStudents FROM CourseRegistrations GROUP BY CourseOfferId) SELECT CourseName, Year, Quartile FROM NumAssistantsCourseOffer LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId AND NumStudents/NumAssistants>50 LEFT JOIN CourseOffers ON NumStudentsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseOfferId  ORDER BY CourseOffers.CourseOfferId;
