SELECT * FROM CourseOffers, Courses, Degrees, Teachers WHERE CourseOffers.courseOfferId = 1;
SELECT StudentAssistants.CourseOfferId, CourseId, Year, Quartile, StudentId, StudentName, Address, BirthYearStudent, Gender, DegreeId, Dept, DegreeDescription, TotalECTS FROM StudentAssistants, CourseOffers, Students, Degrees WHERE StudentAssistents.StudenRegistrationId=140;
SELECT AVG(Grade) FROM CourseRegistrations WHERE CourseRegistrations.StudentRegistrationId=140;
