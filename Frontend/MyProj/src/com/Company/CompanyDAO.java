
package com.Company;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.Job.Job;
import com.Person.Person;
import com.Person.Employee;
import com.Person.PersonDAO;
import com.Person.Skill;
import com.Company.Project;

import java.util.ArrayList;
import java.util.Date;

public class CompanyDAO {
	
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
    
    private static final String SQL_ADD_COMPANY = "insert into company (company_id, company_name, street_address, zip, website, city, state, GSA)" +
    		"							 			values(?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_GET_COMPANY_DETAILS = "select company_id, company_name, street_address, zip, website, city, state, GSA from company where company_id = ? ";
    // TODO Cascading delete
    private static final String SQL_DELETE_COMPANY = "delete from company where compnay_id = ?";
    private static final String SQL_GET_EMPLOYEES = "select job_code, title, person_id, pay_type, pay_rate " +
    		"from job natural join position where company_id = ? and ( ? = 'ALL' or pay_type = ? )";
    private static final String SQL_GET_PROJECTS = "select project_id, title, director, budget, start_date, end_date " +
    		"from project where company_id = ?";
    private static final String SQL_GET_PROJECT_STAFF = "";
    private static final String SQL_GET_TOP_CANDIDATE = 
    		"WITH JOB_REQUIRED_SKILL (ks_code) AS " +
    		"(SELECT ks_code FROM position_required_skill natural join job WHERE job_code = ?), " +
    		"PERSON_NUM_SKILL (person_id, num_skill) AS " +
    		"(SELECT person_id, count(ks_code) FROM JOB_REQUIRED_SKILL natural join person_k_skills " +
    		"GROUP BY person_id " +
    		"ORDER BY count(ks_code) desc) " +
    		"SELECT person_id,num_skill from PERSON_NUM_SKILL " +
    		"where (? = 'qualified' AND num_skill = (select count(ks_code) from JOB_REQUIRED_SKILL)) " +
    				"OR (? = 'top10' AND rownum <= 10) " +
    				"OR (? = 'top50' AND rownum <= 50) " +
    				"OR (? = 'top100' AND rownum <= 100)";
    
    public CompanyDAO(){
        try {
            // Get DataSource
            Context initContext  = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/test2");
 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
    
    public void addCompany (Company company) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_ADD_COMPANY;

            pstmt = connection.prepareStatement(query); // create a statement            
            pstmt.setString(1, company.getCompany_id());
            pstmt.setString(2, company.getCompany_name());
            pstmt.setString(3, company.getStreet_address());
            pstmt.setInt(4, company.getZip());
            pstmt.setString(5, company.getWebsite());
            pstmt.setString(6, company.getCity());
            pstmt.setString(7, company.getState());
            pstmt.setString(8, company.getGSA());
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
    
    public void deleteCompany (String company_id) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_DELETE_COMPANY;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, company_id);
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
    
    public Company getCompanyDetails(String company_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_COMPANY_DETAILS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, company_id);
            rs = pstmt.executeQuery(); 
            return buildCompanyFromResultSet(rs);
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
  
    public Company buildCompanyFromResultSet(ResultSet rs) throws SQLException{
    	Company company = null;
    	
    	try{
    		while(rs.next()){
    		company = new Company();
    		company.setCompany_id(rs.getString("company_id"));
    		company.setCity(rs.getString("city"));
    		company.setCompany_name(rs.getString("company_name"));
    		company.setState(rs.getString("state"));
    		company.setZip(rs.getInt("zip"));
    		company.setStreet_address(rs.getString("street_address"));
    		company.setWebsite(rs.getString("website"));
    		company.setGSA(rs.getString("GSA"));
    		}
         }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return company;
    }    
    
    public ArrayList<Employee> getEmployees(String company_id, String pay_type) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_EMPLOYEES;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, company_id);
            pstmt.setString(2, pay_type);
            pstmt.setString(3, pay_type);            
            rs = pstmt.executeQuery(); 
            return buildEmployeeListFromResultSet(rs);
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
    
    public ArrayList<Employee> buildEmployeeListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Employee> employeeList = new ArrayList<Employee>();
        try{
    	while (rs.next()) {
    		Person person = new PersonDAO().getPersonDetails(rs.getString("person_id"));
    		Employee employee = new Employee();
            employee.setPerson_id(person.getPerson_id());
            employee.setfName(person.getfName());
            employee.setlName(person.getlName());
            employee.setStreet_address(person.getStreet_address());
            employee.setZip(person.getZip());
            employee.setCity(person.getCity());
            employee.setState(person.getState());
            employee.setEmail(person.getEmail());
            employee.setGender(person.getGender());
            String dob = null;
    		if(person.getDOB() !=null){
    			dob = person.getDOB().toString();
    		}
            employee.setDOB(dob);
            employee.setDesignation(person.getDesignation());
    		employee.setJob_code(rs.getString("job_code"));
    		employee.setPay_rate(rs.getDouble("pay_rate"));
    		employee.setPay_type(rs.getString("pay_type"));
    		employee.setPosition(rs.getString("title"));
    		employeeList.add(employee);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return employeeList;
    }    
    
    public ArrayList<Project> getProjects(String company_id) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_PROJECTS;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, company_id);
            rs = pstmt.executeQuery(); 
            return buildProjectListFromResultSet(rs);
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
    
    public ArrayList<Project> buildProjectListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Project> projectList = new ArrayList<Project>();
        try{
    	while (rs.next()) {
    		Project project = new Project();
    		project.setBudget(rs.getDouble("budget"));
    		project.setDirector(rs.getInt("director"));
    		project.setEnd_date(rs.getDate("end_date"));
    		project.setStart_Date(rs.getDate("start_Date"));
    		project.setTitle(rs.getString("title"));
    		project.setProject_id(rs.getString("project_id"));
    		projectList.add(project);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return projectList;
    }      
    
    public ArrayList<Person> getCandidates(String job_code, String returnType) throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_TOP_CANDIDATE;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, job_code);
            pstmt.setString(2,returnType);
            pstmt.setString(3,returnType);
            pstmt.setString(4,returnType);
            pstmt.setString(5,returnType);
            rs = pstmt.executeQuery(); 
            return buildPersonListFromResultSet(rs);
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
    
    public ArrayList<Person> buildPersonListFromResultSet(ResultSet rs) throws SQLException {
    	ArrayList<Person> personList = new ArrayList<Person>();
        try{
    	while (rs.next()) {
    		Person person = new PersonDAO().getPersonDetails(rs.getString("person_id"));
    		personList.add(person);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return personList;
    }
    
}
