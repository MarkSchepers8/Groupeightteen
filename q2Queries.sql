SELECT CourseName, Grade FROM StudentRegistrationsToDegrees as srtd INNER JOIN CourseRegistrations ON srtd.StudentRegistrationId = CourseRegistrations.StudentRegistrationId INNER JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId INNER JOIN Courses ON CourseOffers.CourseId = Courses.CourseId WHERE srtd.StudentId = %1% AND srtd.DegreeId = %2% AND Grade >= 5 ORDER BY Year, Quartile, CourseOffers.CourseOfferId;
SELECT 0;
SELECT A.DegreeId, 100*(COUNT(CASE WHEN A2.Gender = 'F' THEN 1 END)/count(A.StudentId)::float) AS percentage FROM ActiveStudentsPerDegree A INNER JOIN Students A2 ON A2.StudentId = A.StudentId GROUP BY A.DegreeId ORDER BY A.DegreeId;
SELECT 100*(COUNT(CASE WHEN A2.Gender = 'F' THEN 1 END) / COUNT(A.StudentId)::float) AS percentage FROM StudentRegistrationsToDegrees A INNER JOIN Students A2 ON A2.StudentId = A.StudentId INNER JOIN Degrees A3 ON A3.DegreeId = A.DegreeId WHERE A3.Dept =%1% GROUP BY A.DegreeId;
SELECT 0;
SELECT StudentId, count(StudentId) as numberOfCoursesWhereExcellent FROM HighestGradeStudents GROUP BY StudentId HAVING count(studentid) >= %1% ORDER BY StudentId;
SELECT degreeid, birthyearstudent as birthyear, gender, avg(gpa) as avgGrade FROM Students INNER JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId INNER JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);
WITH NumAssistantsCourseOffer as(SELECT CourseOffers.CourseOfferId, Count(StudentRegistrationId) as NumAssistants FROM CourseOffers LEFT JOIN StudentAssistants ON StudentAssistants.CourseOfferId = CourseOffers.CourseOfferId GROUP BY CourseOffers.CourseOfferId), NumStudentsCourseOffer as(SELECT CourseOfferId, Count(StudentRegistrationId) as NumStudents FROM CourseRegistrations GROUP BY CourseOfferId) SELECT CourseName, Year, Quartile FROM CourseOffers LEFT JOIN NumAssistantsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId INNER JOIN Courses ON Courses.CourseId = CourseOffers.CourseId WHERE NumAssistants = 0 OR CAST(NumStudents as float)/CAST(NumAssistants as float)>50 ORDER BY CourseOffers.CourseOfferId;
