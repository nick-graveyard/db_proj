package com.Person;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.Common.Constants;
import com.Course.Session;

import java.util.ArrayList;
import java.sql.Date;

public class PersonDAO {
	
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
    
    private static final String SQL_ADD_PERSON = 		
    		"INSERT INTO person (person_id, fName, lName, street_address, zip, city, state, email, gender, DOB, Designation) " +
    		"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_GET_PERSON_DETAILS =
    		"SELECT person_id, fName, lName, street_address, zip, city, state, email, gender, DOB, Designation " +
    		"FROM person WHERE person_id = ? ";
    // TODO Cascading delete
    private static final String SQL_DELETE_PERSON = 	
    		"DELETE FROM person WHERE person_id = ?";
    private static final String SQL_GET_SKILLS = 		
    		"SELECT title, description, ks_level FROM person_k_skills NATURAL JOIN knowledge_skill " +
    		"WHERE person_id = ? ";
    private static final String SQL_GET_CERTIFICATES = 	
    		"SELECT cert_name, exp_date FROM credentials NATURAL JOIN certificate " +
			"WHERE person_id = ? ";
    private static final String SQL_GET_MISSING_SKILLS = 
    		"SELECT title, description, ks_level from knowledge_skill WHERE ks_code IN " +
			"(SELECT ks_code FROM job NATURAL JOIN position_required_skill " +
			"WHERE job_code = ? " +
			"MINUS " +
			"SELECT ks_code FROM person_k_skills WHERE person_id = ? )";
    private static final String SQL_GET_MISSING_CERTIFICATES = 
			"SELECT cert_name,null AS exp_date FROM certificate WHERE cert_code IN " +
			"(SELECT cert_code FROM position_certificate NATURAL JOIN job " +
			"WHERE job_code = ? " +
			"MINUS " +
			"SELECT cert_code FROM credentials WHERE person_id = ? )";

    public PersonDAO(){
        try {
            // Get DataSource
            Context initContext  = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/test2");
 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
    
    public void addPerson (Person person) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_ADD_PERSON;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1, person.getPerson_id());
            pstmt.setString(2, person.getfName());
            pstmt.setString(3, person.getlName());
            pstmt.setString(4, person.getStreet_address());
            pstmt.setInt(5, person.getZip());
            pstmt.setString(6, person.getCity());
            pstmt.setString(7, person.getState());
            pstmt.setString(8, person.getEmail());
            pstmt.setString(9, person.getGender());
            pstmt.setDate(10, person.getDOB());
            pstmt.setString(11, person.getDesignation());
            pstmt.executeUpdate(); // execute insert statement
        } catch (SQLException e) {
            throw new SQLException(e);
        }finally {
            try { if(null!=resultSet)resultSet.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=statement)statement.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=connection)connection.close();} catch (SQLException e)
            {e.printStackTrace();}
        }
    }
    
    public void deletePerson (String person_id) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_DELETE_PERSON;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, person_id);
            pstmt.executeUpdate(); // execute insert statement
        } catch (SQLException e) {
            throw new SQLException(e);
        }finally {
            try { if(null!=resultSet)resultSet.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=statement)statement.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=connection)connection.close();} catch (SQLException e)
            {e.printStackTrace();}
        }
    }
    
    public Person getPersonDetails(String person_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_PERSON_DETAILS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1, Integer.parseInt(person_id));
            rs = pstmt.executeQuery(); 
            return buildPersonFromResultSet(rs);
        } catch (SQLException e) {
            throw new SQLException(e);
        }finally {
            try { if(null!=rs)rs.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=statement)statement.close();} catch (SQLException e)
            {e.printStackTrace();}
            try { if(null!=connection)connection.close();} catch (SQLException e)
            {e.printStackTrace();}
        }
    }
  
    public Person buildPersonFromResultSet(ResultSet rs) throws SQLException{
    	Person person = null;
    	
    	
    	try{
    		while(rs.next()){
    		person = new Person();
    		person.setCity(rs.getString("city"));
    		person.setDesignation(rs.getString("designation"));
    		String dob = null;
    		if(rs.getDate("DOB") !=null){
    			dob = rs.getDate("DOB").toString();
    		}
    		person.setDOB(dob);
    		person.setEmail(rs.getString("email"));
    		person.setGender(rs.getString("gender"));
    		person.setfName(rs.getString("fName"));
    		person.setlName(rs.getString("lName"));
    		person.setPerson_id(rs.getInt("person_id"));
    		person.setState(rs.getString("state"));
    		person.setStreet_address(rs.getString("street_address"));
    		person.setZip(rs.getInt("zip"));
    		}
         }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return person;
    }    


public ArrayList<Skill> getSkills(String person_id) throws SQLException {
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    try {
        // Get Connection and Statement
        connection = dataSource.getConnection();
        String query = SQL_GET_SKILLS;

        pstmt = connection.prepareStatement(query); // create a statement
        pstmt.setInt(1, Integer.parseInt(person_id));
        rs = pstmt.executeQuery(); 
        return buildSkillListFromResultSet(rs);
    } catch (SQLException e) {
        throw new SQLException(e);
    }finally {
        try { if(null!=rs)rs.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=statement)statement.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=connection)connection.close();} catch (SQLException e)
        {e.printStackTrace();}
    }
}

public ArrayList<Skill> getMissingSkills(String person_id, String job_code) throws SQLException {
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    try {
        // Get Connection and Statement
        connection = dataSource.getConnection();
        String query = SQL_GET_MISSING_SKILLS;

        pstmt = connection.prepareStatement(query); // create a statement
        pstmt.setInt(2, Integer.parseInt(person_id));
        pstmt.setString(1, job_code);
        rs = pstmt.executeQuery(); 
        return buildSkillListFromResultSet(rs);
    } catch (SQLException e) {
        throw new SQLException(e);
    }finally {
        try { if(null!=rs)rs.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=statement)statement.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=connection)connection.close();} catch (SQLException e)
        {e.printStackTrace();}
    }
}

public ArrayList<Session> getMissingSessions(String person_id, String job_code, String target_date) throws SQLException {
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    try {
        // Get Connection and Statement
        connection = dataSource.getConnection();
        String query = Constants.SQL_GET_MISSING_SESSIONS;

        pstmt = connection.prepareStatement(query); // create a statement
        pstmt.setInt(2, Integer.parseInt(person_id));
        pstmt.setString(1, job_code);
        pstmt.setString(3, target_date);
        pstmt.setString(4, target_date);        
        rs = pstmt.executeQuery(); 
        return buildSessionListFromResultSet(rs);
    } catch (SQLException e) {
        throw new SQLException(e);
    }finally {
        try { if(null!=rs)rs.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=statement)statement.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=connection)connection.close();} catch (SQLException e)
        {e.printStackTrace();}
    }
}

public ArrayList<Session> buildSessionListFromResultSet(ResultSet rs) throws SQLException{
    ArrayList<Session> sessionList = new ArrayList<Session>();
    try{
	while (rs.next()) {
		Session session = new Session();	
		session.setC_code(rs.getString("c_code"));
		session.setEnd_date(rs.getDate("end_date"));
		session.setPrice(rs.getDouble("price"));
		session.setSemester(rs.getString("semester"));
		session.setSession_id(rs.getString("session_id"));
		session.setStart_date(rs.getDate("start_date"));
		sessionList.add(session);
      }
    }
    catch (SQLException e) {
        throw new SQLException(e);
    }
	return sessionList;
}

public ArrayList<Skill> buildSkillListFromResultSet(ResultSet rs) throws SQLException{
    ArrayList<Skill> skillList = new ArrayList<Skill>();
    try{
	while (rs.next()) {
		Skill skill = new Skill();	
		skill.setTitle(rs.getString("title"));
		skill.setDescription(rs.getString("description"));
		skill.setLevel(rs.getString("ks_level"));
		skillList.add(skill);
      }
    }
    catch (SQLException e) {
        throw new SQLException(e);
    }
	return skillList;
}     

public ArrayList<Certificate> getCertificates(String person_id) throws SQLException {
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    try {
        // Get Connection and Statement
        connection = dataSource.getConnection();
        String query = SQL_GET_CERTIFICATES;

        pstmt = connection.prepareStatement(query); // create a statement
        pstmt.setInt(1, Integer.parseInt(person_id));
        rs = pstmt.executeQuery(); 
        return buildCertificateListFromResultSet(rs);
    } catch (SQLException e) {
        throw new SQLException(e);
    }finally {
        try { if(null!=rs)rs.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=statement)statement.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=connection)connection.close();} catch (SQLException e)
        {e.printStackTrace();}
    }
}

public ArrayList<Certificate> getMissingCertificates(String person_id, String job_code) throws SQLException {
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    try {
        // Get Connection and Statement
        connection = dataSource.getConnection();
        String query = SQL_GET_MISSING_CERTIFICATES;

        pstmt = connection.prepareStatement(query); // create a statement
        pstmt.setInt(2, Integer.parseInt(person_id));
        pstmt.setString(1, job_code);
        rs = pstmt.executeQuery(); 
        return buildCertificateListFromResultSet(rs);
    } catch (SQLException e) {
        throw new SQLException(e);
    }finally {
        try { if(null!=rs)rs.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=statement)statement.close();} catch (SQLException e)
        {e.printStackTrace();}
        try { if(null!=connection)connection.close();} catch (SQLException e)
        {e.printStackTrace();}
    }
}

public ArrayList<Certificate> buildCertificateListFromResultSet(ResultSet rs) throws SQLException{
    ArrayList<Certificate> certificateList = new ArrayList<Certificate>();
    try{
	while (rs.next()) {
		Certificate certificate = new Certificate();	
		certificate.setName(rs.getString("cert_name"));
		certificate.setExp_date(rs.getDate("exp_date"));
		certificateList.add(certificate);
      }
    }
    catch (SQLException e) {
        throw new SQLException(e);
    }
	return certificateList;
} 

}
