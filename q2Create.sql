CREATE MATERIALIZED VIEW GPA as (
    SELECT StudentRegistrationsToDegrees.StudentRegistrationId, CAST(sum(grade*ects) as float)/CAST(sum(ects) as float) as gpa
    FROM CourseRegistrations
    LEFT JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND CourseRegistrations.Grade >= 5
    LEFT JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
    LEFT JOIN Courses on Courses.CourseId = CourseOffers.CourseId
    GROUP BY StudentRegistrationsToDegrees.StudentRegistrationId
);

CREATE MATERIALIZED VIEW CourseRegistrations2018_q1 as (
    SELECT CourseOffers.CourseOfferId, studentregistrationid, grade
    FROM CourseOffers
    LEFT JOIN CourseRegistrations ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
    WHERE Year = 2018 AND Quartile = 1
);

CREATE MATERIALIZED VIEW HighestGradeCourseOffers as (
    SELECT StudentId
    FROM (
        SELECT CourseOfferId, MAX(grade) as HighestGrade
        FROM CourseRegistrations2018_q1
        GROUP By CourseOfferId
    ) AS maxCr
    INNER JOIN CourseRegistrations2018_q1 AS cr ON maxCr.CourseOfferId = cr.CourseOfferId AND maxCr.highestgrade = cr.grade
    LEFT JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = cr.StudentRegistrationId 
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
    SELECT StudentId, StudentRegistrationId, Degrees.DegreeId
    FROM StudentsECTS
    LEFT JOIN Degrees ON StudentsECTS.DegreeId = Degrees.DegreeId
    GROUP BY StudentRegistrationId, StudentId, Degrees.DegreeId, Degrees.TotalECTS, StudentsECTS.TotalECTS
    HAVING StudentsECTS.totalects < degrees.totalects
);

CREATE MATERIALIZED VIEW DegreeCompleted as (
    SELECT StudentId, StudentRegistrationId 
    FROM StudentsECTS
    LEFT JOIN Degrees ON Degrees.DegreeId = StudentsECTS.DegreeId
    GROUP BY StudentRegistrationId, StudentId, Degrees.DegreeId, Degrees.TotalECTS, StudentsECTS.TotalECTS
    HAVING Degrees.TotalECTS <= StudentsECTS.TotalECTS
);

