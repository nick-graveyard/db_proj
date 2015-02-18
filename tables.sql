
CREATE TABLE company(
	company_id varchar(8),
	company_name varchar(20) not null,
	street_address varchar(20),
	zip numeric(5),
	website varchar(20),
	city varchar(12),
	state varchar(10),
	GSA char(5),
	PRIMARY KEY (company_id));
CREATE TABLE speciality(
	speciality_id numeric(5),
	category varchar(15),
	description varchar(50),
	PRIMARY KEY (speciality_id));
CREATE TABLE company_speciality(
	speciality_id numeric(5),
	company_id varchar(8),
	PRIMARY KEY (speciality_id, company_id),
	FOREIGN KEY (company_id) references company(company_id),
	FOREIGN KEY (speciality_id) references speciality(speciality_id));
CREATE TABLE person (
	person_id numeric(9),
	fname varchar(20),
	lname varchar(20),
	street_address varchar(20),
	zip numeric(5),
	city varchar(12),
	state varchar(10),
	email varchar(30),
	gender char(1),
	DOB date,
	Designation varchar(8),
	PRIMARY KEY (person_id));
CREATE TABLE position (
	position_code varchar(5),
	title varchar(20) not null, 
	description varchar (50),
	PRIMARY KEY (position_code));
CREATE TABLE job (
	job_code numeric(5),
	person_id numeric(9),
	type varchar(8),
	position_code varchar(5),
	pay_rate numeric(6),
	pay_type varchar (6),
	company_id varchar (8),
	PRIMARY KEY (job_code),
	FOREIGN KEY (company_id) references company(company_id),
	FOREIGN KEY (position_code) references position (position_code),
	FOREIGN KEY (person_id) references person(person_id));
CREATE TABLE project (
	project_id varchar (5),
	title varchar (20),
	director varchar(20),
	budget numeric (8,2),
	start_date date,
	end_date date,
	company_id varchar(8),
	PRIMARY KEY (project_id),
	FOREIGN KEY (company_id) references company(company_id));
CREATE TABLE project_job (
	project_id varchar(5),
	job_code numeric (5),
	PRIMARY KEY (project_id, job_code),
	FOREIGN KEY (job_code) references job (job_code),
	FOREIGN KEY (project_id) references project (project_id));
CREATE TABLE course(
	c_code varchar(8),
	title varchar(30),
	type varchar(10),
	category varchar(20),
	retail_price numeric(8,2),
	c_level varchar(15),
	status varchar(6),
	PRIMARY KEY (c_code)); 
CREATE TABLE tools(
	t_code varchar(5),
	name varchar(20),
	description varchar(30),
	version varchar(10),
	vendor varchar(20),
	PRIMARY KEY (t_code));
CREATE TABLE certificate (
	cert_code varchar(5),
	cert_name varchar(25),
	PRIMARY KEY (cert_code));
CREATE TABLE position_certificate (
	position_code varchar(5),
	cert_code varchar(5),
	validity numeric(2),
	PRIMARY KEY (position_code, cert_code),
	FOREIGN KEY (position_code) references position (position_code),
	FOREIGN KEY (cert_code) references certificate (cert_code));
CREATE TABLE knowledge_skill(
	ks_code numeric(5),
	title varchar(15),
	description varchar(50),
	ks_level varchar(10),
	PRIMARY KEY (ks_code));
CREATE TABLE position_required_skill (
	position_code varchar (5),
	ks_code numeric (5),
	yrs_of_experience numeric (2),
	PRIMARY KEY(position_code, ks_code),
	FOREIGN KEY (ks_code) references knowledge_skill (ks_code),
	FOREIGN KEY (position_code) references position (position_code));
CREATE TABLE dependant (
	person_id numeric(9),
	dependant_id numeric(9) not null,
	relationship varchar(6),
	PRIMARY KEY (person_id, dependant_id),
	FOREIGN KEY (person_id) references person (person_id));
CREATE TABLE phone (
	phone numeric (10),
	type varchar(10),
	PRIMARY KEY (phone));
CREATE TABLE phone_contact (
	person_id numeric (9),
	phone numeric (10),
	PRIMARY KEY (person_id, phone),
	FOREIGN KEY (person_id) references person (person_id),
	FOREIGN KEY (phone) references phone (phone));
CREATE TABLE person_k_skills (
	person_id numeric (9),
	ks_code numeric (5),
	PRIMARY KEY (person_id, ks_code),
	FOREIGN KEY (person_id) references person (person_id),
	FOREIGN KEY (ks_code) references knowledge_skill (ks_code));
CREATE TABLE credentials (
	person_id numeric (9),
	cert_code varchar(5),
	exp_date date,
	PRIMARY KEY (person_id, cert_code),
	FOREIGN KEY (person_id) references person (person_id),
	FOREIGN KEY (cert_code) references certificate (cert_code));
CREATE TABLE c_session (
	c_code varchar(8),
	session_id numeric(3),
	semester varchar(5),
	start_date date,
	end_date date,
	price numeric (8,2),
	PRIMARY KEY (session_id, semester, start_date),
	FOREIGN KEY (c_code) references course (c_code));
CREATE TABLE takes (
	person_id numeric (9),
	c_code varchar(8),
	session_id numeric(3),
	semester varchar(5), 
	start_date date,
	grade char(1),
	PRIMARY KEY (person_id, c_code, session_id, semester, start_date),
	FOREIGN KEY (person_id) references person (person_id),
	FOREIGN KEY (c_code) references course (c_code),
	FOREIGN KEY (session_id, semester, start_date) references c_session (session_id, semester, start_date));
CREATE TABLE course_format (
	c_code varchar(8),
	format varchar(14),
	PRIMARY KEY (c_code, format),
	FOREIGN KEY (c_code) references course (c_code));
CREATE TABLE teaches (
	person_id numeric (9),
	c_code varchar(8),
	session_id numeric(3),
	semester varchar(5), 
	start_date date,
	PRIMARY KEY (person_id, c_code, session_id, semester, start_date),
	FOREIGN KEY (person_id) references person (person_id),
	FOREIGN KEY (c_code) references course (c_code),
	FOREIGN KEY (session_id, semester, start_date) references c_session (session_id, semester, start_date));
CREATE TABLE learning_unit (
	lu_code varchar(5),
	topic varchar (15),
	description varchar(50),
	duration int,
	c_code varchar(8),
	PRIMARY KEY (lu_code),
	FOREIGN KEY (c_code) references course (c_code));
CREATE TABLE lu_k_skills (
	lu_code varchar (5),
	ks_code numeric (5),
	PRIMARY KEY (lu_code, ks_code),
	FOREIGN KEY (lu_code) references learning_unit (lu_code),
	FOREIGN KEY (ks_code) references knowledge_skill (ks_code));
CREATE TABLE course_content(
	c_code varchar (8),
	lu_code varchar(5),
	PRIMARY KEY (c_code, lu_code),
	FOREIGN KEY (c_code) references course (c_code),
	FOREIGN KEY (lu_code) references learning_unit (lu_code));
CREATE TABLE lu_tool(
	lu_code varchar (5),
	t_code varchar(5),
	PRIMARY KEY (lu_code, t_code),
	FOREIGN KEY (lu_code) references learning_unit (lu_code),
	FOREIGN KEY (t_code) references tools (t_code));
CREATE TABLE tools_bound(
	t_code varchar(5),
	cert_code varchar(5),
	PRIMARY KEY (t_code, cert_code),
	FOREIGN KEY (t_code) references tools(t_code),
	FOREIGN KEY (cert_code) references certificate(cert_code));
CREATE TABLE lu_course(
	lu_code varchar(5),
    	c_code varchar(8),
    	PRIMARY KEY (lu_code,c_code),
    	FOREIGN KEY (lu_code) references learning_unit (lu_code),
	FOREIGN KEY (c_code) references course (c_code)); 
CREATE TABLE applied_job (
	person_id numeric(9,0),
	job_code numeric(5,0),
	application_date date,
	PRIMARY KEY (person_id,job_code),
	FOREIGN KEY (person_id) references person(person_id),
	FOREIGN KEY (job_code) references job(job_code))