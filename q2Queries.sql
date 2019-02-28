-- QUERY 1
SELECT CourseName, Grade FROM Students 
LEFT JOIN StudentRegistrationsToDegrees ON Students.StudentId = StudentRegistrationsToDegrees.StudentId 
AND StudentRegistrationsToDegrees.DegreeId = %2% AND Students.StudentId = %1% 
LEFT JOIN Courses ON Courses.DegreeId = StudentRegistrationsToDegrees.DegreeId 
LEFT JOIN CourseOffers ON CourseOffers.CourseOfferId = Courses.CourseOfferId 
LEFT JOIN CourseRegistrations ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId 
WHERE Grade > 5 ORDER BY Year THEN BY Quartile THEN BY CourseOfferId;


-- QUERY 2
SELECT DISTINCT StudentId FROM DegreeCompleted
LEFT JOIN CourseRegistrations ON CourseRegistrations.StudentRegistrationId = DegreeCompleted.StudentRegistrationId
LEFT JOIN GPA ON GPA.StudentRegistrationId = DegreeCompleted.StudentRegistrationId AND GPA.GPA > %1% AND CourseRegistration.Grade >= 5
GROUP BY StudentId;



-- QUERY 3

-- QUERY 4

-- QUERY 5

-- QUERY 6
SELECT DISTINCT StudentId, count(StudentId) FROM HighestGradeCourseOffers WHERE Year = 2018 AND Quartile = 1 GROUP BY StudentId HAVING count(studentid) >= %1%;

-- QUERY 7
SELECT degreeid, birthyearstudent, gender, avg(gpa) FROM Students LEFT JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId LEFT JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);

-- QUERY 8
SELECT CourseName, Year, Quartile FROM NumAssistantsCourseOffer LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId AND NumStudents/NumAssistants>50 LEFT JOIN CourseOffers ON NumStudentsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId
LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseOfferId  ORDER BY CourseOffers.CourseOfferId;
