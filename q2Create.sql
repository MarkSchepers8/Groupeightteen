CREATE MATERIALIZED VIEW GPA as (
    SELECT StudentRegistrationId, CAST(sum(grade*ects) as float)/CAST(sum(ects) as float) as gpa
    FROM CourseRegistrations
    WHERE CourseRegistrations.Grade >= 5
    LEFT JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId
    LEFT JOIN CourseOffers ON CourseRegistrations.CourseOfferId = CourseOffers.CourseOfferId
    LEFT JOIN Courses on Courses.CourseId = CourseOffers.CourseId
    GROUP BY StudentRegistrationId
);

CREATE MATERIALIZED VIEW HighestGradeCourseOffers as (
    SELECT StudentId, grade, year, quartile
    FROM (
        SELECT CourseOfferId, MAX(grade) as HighestGrade
        FROM CourseRegistrations
        GROUP By CourseOfferId
    ) AS maxCr
    INNER JOIN CourseRegistrations AS cr ON maxCr.CourseOfferId = cr.CourseOfferId AND maxCr.grade = cr.HighestGrade
    LEFT JOIN StudentRegistrationsToDegrees ON StudentRegistrationsToDegrees.StudentRegistrationId = cr.StudentRegistrationId 
);

CREATE MATERIALIZED VIEW StudentsECTS as (
    SELECT StudentId, StudentRegistrationId, DegreeId, SUM(ects) as totalects
    FROM StudentRegistrationsToDegrees
    LEFT JOIN CourseRegistrations ON StudentRegistrationsToDegrees.StudentRegistrationId = CourseRegistrations.StudentRegistrationId AND grade >=5 
    LEFT JOIN CourseOffers ON CourseOffers.CourseOfferId = CourseRegistrations.CourseOfferId
    LEFT JOIN Courses ON Courses.CourseId = CourseOffers.CourseId
    GROUP BY StudentRegistrationId
)

CREATE MATERIALIZED VIEW ActiveStudentsPerDegree as (
    SELECT StudentId, StudentRegistrationId, DegreeId
    FROM StudentsECTS
    LEFT JOIN Degrees ON StudentsECTS.DegreeId = Degrees.DegreeId
    HAVING StudentsECTS.totalects < totalects
);

CREATE MATERIALIZED VIEW DegreeCompleted as (
    SELECT StudentId, StudentRegistrationId FROM StudentsECTS
    LEFT JOIN Degrees ON Degrees.DegreeId = StudentsECTS.DegreeId
    HAVING Degrees.TotalECTS <= StudentsECTS.TotalECTS
);

