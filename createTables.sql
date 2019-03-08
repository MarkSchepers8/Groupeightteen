CREATE UNLOGGED TABLE degrees
(
  degreeid INT,
  dept varchar(50),
  degreedescription varchar(200),
  totalects INT,
  CONSTRAINT degrees_pkey PRIMARY KEY (degreeid)
);
CREATE UNLOGGED TABLE students
(
  studentid INT NOT NULL,
  studentname varchar(50),
  address varchar(200),
  birthyearstudent INT,
  gender CHAR(1),
  CONSTRAINT students_pkey PRIMARY KEY (studentid)
);
CREATE UNLOGGED TABLE studentregistrationstodegrees
(
  studentregistrationid INT NOT NULL,
  studentid INT,
  degreeid INT,
  registrationyear INT,
  CONSTRAINT studentregistrationstodegrees_pkey PRIMARY KEY (studentregistrationid)
);
CREATE UNLOGGED TABLE teachers
(
  teacherid INT NOT NULL,
  teachername VARCHAR(50),
  address VARCHAR(200),
  birthyearteacher INT,
  gender CHAR(1),
  CONSTRAINT teachers_pkey PRIMARY KEY (teacherid)
);
CREATE UNLOGGED TABLE courses
(
  courseid INT,
  coursename VARCHAR(50),
  coursedescription VARCHAR(200),
  degreeid INT,
  ects INT,
  CONSTRAINT courses_pkey PRIMARY KEY (courseid)
);
CREATE UNLOGGED TABLE courseoffers
(
  courseofferid INT,
  courseid INT,
  year INT,
  quartile INT
);
CREATE UNLOGGED TABLE teacherassignmentstocourses
(
  courseofferid INT,
  teacherid INT
);
CREATE UNLOGGED TABLE studentassistants
(
  courseofferid INT,
  studentregistrationid INT
);
CREATE UNLOGGED TABLE courseregistrations
(
  courseofferid INT,
  studentregistrationid INT,
  grade INT
);
