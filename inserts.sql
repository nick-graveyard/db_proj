insert into company values ('RC234578', 'xyz pharmaceuticals', '7115 burthe street', 60118, 'www.xyzpha.com', 'dallas', 'texas', 'false');
insert into company values ('RC554698', 'mac incorpration', '20 loyola avenue', 70148, 'www.maccorp.com', 'new orleans', 'loiusiana', 'false');
insert into company values ('RC198765', 'tulane university', '1440 canal street', 70145, 'www.tulane.edu', 'new orleans', 'louisiana', 'true');
insert into company values ('RC345890', 'steves chamber', '34 maple street', 60998, 'www.steveatt.com', 'dallas', 'texas', 'false');
insert into company values ('RC987543', 'breeding farms', '120 st charles', 70118, 'www.bfarms.com', 'new orleans', 'lousiana', 'false');
insert into speciality values (12345, 'education', 'IT Training schools');
insert into speciality values (13456, 'education', 'business management schools');
insert into speciality values (12678, 'education', 'universities');
insert into speciality values (23455, 'health services', 'pharmaceuticals');
insert into speciality values (23456, 'health services', 'hospital management');
insert into speciality values (45987, 'legal services', 'law firms');
insert into speciality values (34567, 'agriculture', 'crop production');
insert into speciality values (37890, 'agriculture', 'animal production');
insert into speciality values (54567, 'manufacturing', 'iron and steel production');
insert into company_speciality values (23455, 'RC234578');
insert into company_speciality values (54567, 'RC554698');
insert into company_speciality values (12678, 'RC198765');
insert into company_speciality values (45987, 'RC345890');
insert into company_speciality values (34567, 'RC987543');
insert into person values(908765440, 'xxxxx', 'xxxxxxx', '45 broadway street', 70118, 'new orleans', 'louisiana','xxxxxxxx@yahoo.com', 'female', '01-jan-84', 'civilian'); 
insert into person values(876543210, 'xxxxx', 'xxxxxxx', '25 tulane avenue', 70118, 'new orleans', 'louisiana','xxxxxxx@gmail.com', 'male', '08-may-66', 'soldier');
insert into person values(976590870, 'xxxxx' ,'xxxxxxx', '5 ferret street', 70118, 'new orleans', 'louisiana','xxxxxxxxx@hotmail.com', 'male', '15-aug-73', 'officer');  	
insert into person values(923456790, 'julia', 'brown', '3 broad street', 60998, 'dallas', 'texas','jbrown@yahoo.com', 'female', '03-apr-76', 'civilian'); 
insert into person values(997512340, 'ray' ,'ben', '90 s/broad street', 60118, 'dallas', 'texas','rayben@yahoo.com', 'male', '01-jan-84', 'civilian'); 
insert into person values(956789000, 'tom', 'cruise', '3 paris avenue', 70148, 'new orleans', 'louisiana','tcruise@yahoo.com', 'male', '22-dec-60', 'civilian'); 
insert into person values(912345670, 'henry','mark', '14 elk place', 71001, 'new orleans', 'louisiana','hmark@tulane.edu', 'male', '09-jun-00', 'civilian'); 
insert into position values ('mg101', 'manager', 'supervisory position in an organization');
insert into position values ('la234', 'labourer','company labourer');
insert into position values ('db456', 'DBA','manages the database of an organization' );
insert into position values ('sy678', 'system admin', 'manages network and system access in an organization');
insert into position values ('pr478', 'professor','instructor and researcher in a higher instituition of learning');
insert into position values ('ga345', 'graduate assistant', 'lower level instructors that assist professors');
insert into position values ('mg986', 'production manager', 'supervise production department');
insert into job values (10100, 908765440, 'parttime', 'ga345', 10,'wage', 'RC198765');
insert into job values (18907, 876543210, 'fulltime', 'pr478', 90000,'salary', 'RC198765');
insert into job values (14567, 908765440, 'parttime', 'db456', 20,'wage', 'RC345890');
insert into job values (18765, 912345670, 'fulltime', 'mg986', 40000,'salary', 'RC987543');
insert into job values (11234, 956789000, 'fulltime','sy678', 350000, 'salary', 'RC554698');
insert into project values('A9090', 'semantic web', 'xxxxxxx', 1000000, '20-feb-09','20-aug-09', 'RC198765');
insert into project values('C8090', 'poultry clone', 'henry mark', 500000, '04-nov-11', '01-nov-12','RC987543');
insert into project_job values ('A9090', 10100);
insert into project_job values ('A9090', 18907);
insert into project_job values('C8090', 18765);
insert into course values ('csci4125', 'database management', 'academic', 'technology', 500, 'beginner', 'active');
insert into course values ('ora10g1', 'introduction to oracle', 'training', 'IT training', 1500, 'intermediate', 'expired');
insert into course values ('busi3990', 'entrepreneurship', 'academic', 'Business', 500, 'beginner', 'expired');
insert into course values ('ibmf01', 'international business', 'training', 'business', 5000, 'advanced', 'active');
insert into course values ('jav6/7', 'java 6 and 7', 'training', 'technology', 2500, 'advanced', 'active');
insert into course values ('OSsec3', 'OS security', 'training', 'technology', 6500, 'advanced', 'active');
insert into course values ('csci2125', 'data structure', 'academic', 'Technology', 500, 'beginner', 'active');
insert into tools values ('o0004', 'oracle 10g', 'oracle database mgt system', 'version 4', 'oracle incorporation');
insert into tools values ('j0006', 'java 6', 'java Development kit', 'version 6', 'sun microsystems');
insert into tools values ('os001', 'unix os', 'operating system', 'redhat 5', 'unix os');
insert into tools values ('mov01', 'ms visio', 'office package', 'version 2', 'microsoft');
insert into certificate values ('TO909', 'introduction to oracle', '17-dec-13');
insert into certificate values ('TJ666', 'java 6 and 7', '06-oct-14');
insert into certificate values ('TB765', 'international business', null);
insert into certificate values ('TSec3', 'OS security', '13-jun-14');
insert into certificate values ('TO910', 'Oracle PL/SQL', '10-mar-13');
insert into position_certificate values ('mg101', 'TB765', null);
insert into position_certificate values ('db456', 'TO909', 2);
insert into position_certificate values ('sy678', 'TSec3', 2);
insert into position_certificate values ('db456', 'TO910', 3);
insert into toolsbound values ('o0004', 'TO910');
insert into toolsbound values ('o0004', 'TO909');
insert into toolsbound values ('j0006', 'TJ666');
insert into toolsbound values ('os001', 'TO909');
insert into knowledge_skill values (26879, 'dba skill1', 'knowledge of sql', 'begginer');
insert into knowledge_skill values (24599, 'dba skill2', 'knowlege of ER and Oracle DBMS', 'intermediate');
insert into knowledge_skill values (36879, 'jprog skill1', 'programming in java', 'begginer');
insert into knowledge_skill values (37654, 'net skill4', 'hands on cisco networking', 'advanced');
insert into knowledge_skill values (26333, 'tutor_grade5', 'teaching experience', 'advanced');
insert into position_required_skill values('sy678', 37654, 5);
insert into position_required_skill values('db456', 24599, 2);
insert into position_required_skill values('db456', 26879, 1);
insert into position_required_skill values('pr478', 26333, 10);
insert into dependants values(876543210, 908765440, 'wife');
insert into dependants values(976590870, 912345670, 'son');
insert into phone values(7037867557, 'landline');
insert into phone values(7036067123, 'mobile');
insert into phone values(7035993566, 'mobile');
insert into phone values(7036141421, 'landline');
insert into phone values(702220119, 'landline');
insert into phone_contact values(876543210, 7036067123);
insert into phone_contact values(876543210, 7036141421);
insert into phone_contact values(908765440, 7036141421);
insert into phone_contact values(912345670, 7035993566);
insert into person_k_skills values(876543210, 26879);
insert into person_k_skills values(876543210, 24599);
insert into person_k_skills values(876543210, 26333);
insert into person_k_skills values(908765440, 24599);
insert into person_k_skills values(976590870, 36879);
insert into person_k_skills values(976590870, 26879);
insert into credentials values(908765440, 'TO909');
insert into credentials values(876543210, 'TSec3');
insert into credentials values(908765440, 'TJ666');
insert into credentials values(976590870, 'TB765');
insert into course_certificate values ('ora10g1','TO909');
insert into course_certificate values ('jav6/7', 'TJ666');
insert into course_certificate values ('OSsec3','TSec3');
insert into course_certificate values ('ibmf01','TB765');
insert into course_potential_cert values ('csci4125', 'TO909');
insert into course_potential_cert values ('csci2125', 'TJ666');
insert into c_session values('csci4125', 601, 'fall', '09-aug-12', '10-dec-12', 500);
insert into c_session values('csci2125', 001, 'spring', '11-jan-12', '15-may-12', 500);
insert into c_session values('ora10g1', 111, 'summer', '10-jun-12', '01-aug-12', 3000);
insert into c_session values('ibmf01', 222, 'summer', '11-jun-12', '03-aug-12', 5500);
insert into course_format values('csci4125', 'online');
insert into course_format values('csci4125', 'classroom');
insert into course_format values('csci2125', 'online');
insert into course_format values('ibmf01', 'correspondence');
insert into course_format values('OSsec3', 'classroom');
insert into takes values(908765440, 'csci4125', 601, 'fall', '09-aug-12', 'A');
insert into takes values(976590870, 'csci2125', 001, 'spring', '11-jan-12', 'A');
insert into takes values(997512340, 'ora10g1', 111, 'summer', '10-jun-12', 'B');
insert into teaches values(876543210, 'csci4125', 601, 'fall', '09-aug-12');
insert into teaches values(908765440, 'csci2125', 001, 'spring', '11-jan-12');
insert into learning_unit values('L0001', 'RDBM', 'Intro Relational database management', 10, 'csci4125');
insert into learning_unit values('L0002', 'JDBC', 'Intro JDB driver', 15, 'csci4125');
insert into learning_unit values('L0003', 'Java Arrays', 'How to use array in java 6', 15, 'csci2125');
insert into learning_unit values('L0006', 'Intermediate SQL', 'SQL for the intermediate class', 10, 'ora10g1');
insert into lu_k_skills values('L0006', 26879);
insert into lu_k_skills values('L0003', 36879);
insert into course_content values('csci4125','L0001');
insert into course_content values('csci4125','L0002');
insert into course_content values('csci2125', 'L0003');
insert into course_content values('ora10g1', 'L0006');
insert into lu_tool values('L0001', 'mov01');
insert into lu_tool values('L0002', 'o0004');
insert into lu_tool values('L0001', 'j0006');















