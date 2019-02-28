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
LEFT JOIN GPA ON GPA.StudentRegistrationId = DegreeCompleted.StudentRegistrationId HAVING GPA.GPA > %1% AND min(CourseRegistration.Grade >= 5) 
GROUP BY StudentId;



-- QUERY 3

-- QUERY 4
SELECT (SELECT COUNT(CASE WHEN a1.gender = ‘F’ then 1 end) FROM Students a1)/ (SELECT COUNT(*) FROM StudentRegistrationToDegrees a3) as percentage_f
FROM Students a1
INNER JOIN  a3 ON a1.StudentId = a3.StudentId
INNER JOIN Degrees a2 ON a1.DegreeId = a2.DegreeId
WHERE a2.Dept = %1%
GROUPBY a3.DegreeID;

-- QUERY 5
SELECT CourseId, (SELECT COUNT(CASE WHEN a1.grade >= %1% then 1 	end) / (SELECT COUNT(StudentRegistrationid) FROM courseRegistrations ) FROM StudentRegistrationToDegrees a1 WHERE a1.grade IS NOT NULL) AS percentagePassing FROM Courses
INNER JOIN courseRegistrations a1 ON a1.courseId = Courses.CourseId;

-- QUERY 6
SELECT DISTINCT StudentId, count(StudentId) FROM HighestGradeCourseOffers WHERE Year = 2018 AND Quartile = 1 GROUP BY StudentId HAVING count(studentid) >= %1%;

-- QUERY 7
SELECT degreeid, birthyearstudent, gender, avg(gpa) FROM Students LEFT JOIN ActiveStudentsPerDegree ON ActiveStudentsPerDegree.StudentId = Students.StudentId LEFT JOIN GPA ON GPA.StudentRegistrationId = ActiveStudentsPerDegree.StudentRegistrationId GROUP BY cube(degreeid, birthyearstudent, gender);

-- QUERY 8
SELECT CourseName, Year, Quartile FROM NumAssistantsCourseOffer LEFT JOIN NumStudentsCourseOffer ON NumAssistantsCourseOffer.CourseOfferId = NumStudentsCourseOffer.CourseOfferId AND NumStudents/NumAssistants>50 LEFT JOIN CourseOffers ON NumStudentsCourseOffer.CourseOfferId = CourseOffers.CourseOfferId
LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseOfferId  ORDER BY CourseOffers.CourseOfferId;
