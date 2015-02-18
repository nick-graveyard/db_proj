package com.Job;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.Course.Course;

import java.util.ArrayList;
import java.util.Date;

public class JobDAO {
	
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
	
    private static final String SQL_GET_PERSON_JOBS = 
    		"SELECT company_name, title AS pos_title, company_id, job_code, pay_rate, pay_type " +
    		"FROM company NATURAL JOIN job NATURAL JOIN position " +
    		"WHERE person_id = ? ";
    private static final String SQL_GET_PERSON_APPLIED_JOBS = 
    		"SELECT c.company_name, p.title AS pos_title, j.company_id, j.job_code, j.pay_rate, j.pay_type, a.status " +
    		"FROM job j, company c, position p, applied_job a " +
    		"WHERE a.person_id = ? AND " +
    		"j.position_code = p.position_code AND j.company_id = c.company_id AND j.job_code = a.job_code";
    private static final String SQL_ADD_APPLICATION = 
    		"INSERT INTO applied_job (person_id,job_code) VALUES (?,?)";
    private static final String SQL_DELETE_APPLICATION = 
    		"DELETE FROM applied_job WHERE person_id = ? AND job_code = ?";    
    private static final String SQL_GET_ALL_POSITIONS = 
    		"SELECT position_code, title, description FROM position ORDER BY title";
    private static final String SQL_GET_JOB_LIST_FOR_CRITERIA = 
    		"SELECT company_name, title AS pos_title, company_id, job_code, pay_rate, pay_type " +
    		"FROM company NATURAL JOIN job NATURAL JOIN position " +
    		"WHERE UPPER(company_name) LIKE UPPER(?) AND (? = 'ALL' OR position_code = ?)";
    private static final String SQL_GET_QUALIFIED_JOBS =
    		"WITH test1 (position_code) AS " +
    		"(SELECT position_code FROM position p " +
    		"WHERE NOT EXISTS ( " +
    				"SELECT ks_code FROM position_required_skill ps " +
    				"WHERE p.position_code = ps.position_code " +
    				"MINUS " +
    				"SELECT ks_code FROM person_k_skills " +
    				"WHERE person_id = ? ) " +
    			"AND NOT EXISTS ( " +
    				"(SELECT cert_code FROM position_certificate pc " +
    				"WHERE p.position_code = pc.position_code) " +
    				"MINUS " +
    				"(SELECT cert_code FROM credentials " +
    				"WHERE person_id = ? ))), " +
    		"test2 (job_code, annualpay) AS " +
    				"((SELECT job_code, pay_rate as annualpay " +
    				"FROM job NATURAL JOIN test1 " +
    				"WHERE pay_type = 'salary') " +
    				"UNION " +
    				"(SELECT job_code, (pay_rate*40*12) AS annualpay " +
    				"FROM job NATURAL JOIN test1 " +
    				"WHERE pay_type = 'wage')) " +
    		"SELECT company_name, title AS pos_title, company_id, job_code, pay_rate, pay_type " +
    		"FROM company NATURAL JOIN job NATURAL JOIN position NATURAL JOIN test2 " +
    		"ORDER BY annualpay";

    public JobDAO(){
        try {
            // Get DataSource
            Context initContext  = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/test2");
 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
    
    public ArrayList<Job> getPersonJobs(String person_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_PERSON_JOBS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1,Integer.parseInt(person_id));
            rs = pstmt.executeQuery(); 
            return buildJobListFromResultSet(rs);
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
    
    public ArrayList<Job> getJobListForCriteria(String company_name, String position_code) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_JOB_LIST_FOR_CRITERIA;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, "%"+company_name+"%");
            pstmt.setString(2, position_code);
            pstmt.setString(3, position_code);
 
            rs = pstmt.executeQuery(); 
            return buildJobListFromResultSet(rs);
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
  
    public ArrayList<Job> buildJobListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Job> jobList = new ArrayList<Job>();
        try{
    	while (rs.next()) {
    		Job job = new Job();	
    		job.setCompany_name(rs.getString("company_name"));
    		job.setCompany_code(rs.getString("company_id"));
    		job.setJob_code(rs.getString("job_code"));
    		job.setPay_rate(rs.getInt("pay_rate"));
    		job.setPay_type(rs.getString("pay_type"));
    		job.setPosition(rs.getString("pos_title"));
    		jobList.add(job);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return jobList;
    }    
    
    public ArrayList<Job> buildAppliedJobListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Job> jobList = new ArrayList<Job>();
        try{
    	while (rs.next()) {
    		Job job = new Job();	
    		job.setCompany_name(rs.getString("company_name"));
    		job.setCompany_code(rs.getString("company_id"));
    		job.setJob_code(rs.getString("job_code"));
    		job.setPay_rate(rs.getInt("pay_rate"));
    		job.setPay_type(rs.getString("pay_type"));
    		job.setPosition(rs.getString("pos_title"));
    		job.setStatus(rs.getString("status"));
    		jobList.add(job);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return jobList;
    }    
    
    public ArrayList<Job> getQualifiedJobs(String person_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_QUALIFIED_JOBS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1,Integer.parseInt(person_id));
            pstmt.setInt(2,Integer.parseInt(person_id));
            rs = pstmt.executeQuery(); 
            return buildJobListFromResultSet(rs);
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
    
    public ArrayList<Job> getAppliedJobs(String person_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_PERSON_APPLIED_JOBS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1,Integer.parseInt(person_id));
            rs = pstmt.executeQuery(); 
            return buildAppliedJobListFromResultSet(rs);
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
    
    
    public ArrayList<Position> getAllPositions() throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_ALL_POSITIONS;

            pstmt = connection.prepareStatement(query); // create a statement
            rs = pstmt.executeQuery(); 
            return buildPositionListFromResultSet(rs);
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
    
    public ArrayList<Position> buildPositionListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Position> positionList = new ArrayList<Position>();
        try{
    	while (rs.next()) {
    		Position position = new Position();	
    		position.setPosition_code(rs.getString("position_code"));
    		position.setTitle(rs.getString("title"));
    		position.setDescription(rs.getString("description"));
    		positionList.add(position);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return positionList;
    }  
    
    public void saveApplication (String person_id, String job_code) throws SQLException {
    	ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_ADD_APPLICATION;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1, Integer.parseInt(person_id));
            pstmt.setString(2, job_code);
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
    
    public void removeApplication (String person_id, String job_code) throws SQLException {
    	ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_DELETE_APPLICATION;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1, Integer.parseInt(person_id));
            pstmt.setString(2, job_code);
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
}
