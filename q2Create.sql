CREATE MATERIALIZED VIEW GPA as (
    SELECT StudentRegistrationsToDegrees.StudentRegistrationId, CAST(sum(grade*ects) as float)/CAST(sum(ects) as float) as gpa
    FROM CourseRegistrations
    INNER JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseRegistrations.Grade >= 5
    INNER JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
    INNER JOIN Courses on Courses.CourseId = CourseOffers.CourseId
    GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId
);

CREATE MATERIALIZED VIEW StudentWorstGrade as (
   SELECT DegreeCompleted.StudentRegistrationId, DegreeId, MIN(grade) as lowestGrade
   FROM DegreeCompleted
   INNER JOIN CourseRegistrations ON DegreeCompleted.StudentRegistrationId = CourseRegistrations.StudentRegistrationId
   GROUP BY DegreeCompleted.StudentRegistrationid, DegreeId
);


CREATE VIEW CourseRegistrations2018_q1 as (
    SELECT CourseOffers.CourseOfferId, studentregistrationid, grade
    FROM CourseRegistrations
    INNER JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
    WHERE Year = 2018 AND Quartile = 1
);

CREATE VIEW HighestGradePerCourseOffer as (
        SELECT CourseOfferId, MAX(grade) as HighestGrade
        FROM CourseRegistrations2018_q1
        WHERE grade>= 0
        GROUP By CourseOfferId
);

CREATE MATERIALIZED VIEW HighestGradeStudents as (
    SELECT StudentId, cr.CourseOfferId, HighestGrade
    FROM HighestGradePerCourseOffer as maxCr
    INNER JOIN CourseRegistrations2018_q1 AS cr ON maxCr.CourseOfferId = cr.CourseOfferId AND maxCr.highestgrade = cr.grade
    INNER JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = cr.StudentRegistrationId 
);

CREATE MATERIALIZED VIEW StudentsECTS as (
    SELECT DISTINCT StudentId, StudentRegistrationsToDegrees.StudentRegistrationId, StudentRegistrationsToDegrees.DegreeId, SUM(ects) as totalects
    FROM StudentRegistrationsToDegrees
    LEFT JOIN CourseRegistrations ON StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND grade >=5 
    LEFT JOIN CourseOffers ON CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId
    LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseId
    GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId
);

CREATE MATERIALIZED VIEW ActiveStudentsPerDegree as (
    SELECT StudentId, StudentRegistrationId, Degrees.DegreeId, studentsects.totalects
    FROM StudentsECTS
    INNER JOIN Degrees ON StudentsECTS.DegreeId = Degrees.DegreeId
    WHERE StudentsECTS.totalects IS NULL OR StudentsECTS.totalects < degrees.totalects
    GROUP BY StudentRegistrationId, StudentId, Degrees.DegreeId, Degrees.TotalECTS, StudentsECTS.TotalECTS
);

CREATE MATERIALIZED VIEW DegreeCompleted as (
    SELECT StudentId, StudentRegistrationId, Degrees.DegreeId
    FROM StudentsECTS
    INNER JOIN Degrees ON Degrees.DegreeId = StudentsECTS.DegreeId
    WHERE Degrees.TotalECTS <= StudentsECTS.TotalECTS
    GROUP BY StudentRegistrationId, StudentId, Degrees.DegreeId, Degrees.TotalECTS, StudentsECTS.TotalECTS
);

