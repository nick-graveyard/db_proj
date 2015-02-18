package com.Course;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
 
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.util.ArrayList;

public class CourseDAO {
	
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
    private static final String SQL_ADD_COURSE = "insert into course (c_code, title, type, category, retail_price, c_level, status)" +
    		"							 			values(?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_GET_ALL_COURSES = "select c_code, title, type, category, retail_price, c_level, status from course ";
    // TODO Cascading delete
    private static final String SQL_DELETE_COURSE = "delete from course where c_code = ?";
    public CourseDAO(){
        try {
            // Get DataSource
            Context initContext  = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/test");
 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
    
    public void addCourse (Course course) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_ADD_COURSE;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, course.getC_code());
            pstmt.setString(2, course.getTitle());
            pstmt.setString(3, course.getType());
            pstmt.setString(4, course.getCategory());
            pstmt.setDouble(5, course.getRetail_price());
            pstmt.setString(6, course.getC_level());
            pstmt.setString(7, course.getStatus());
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
    
    public void deleteCourse (String course_id) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_DELETE_COURSE;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, course_id);
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
    
    public ArrayList<Course> getAllCourses() throws SQLException {
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_GET_ALL_COURSES;

            pstmt = connection.prepareStatement(query); // create a statement
            rs = pstmt.executeQuery(); 
            return buildCourseListFromResultSet(rs);
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
  
    public ArrayList<Course> buildCourseListFromResultSet(ResultSet rs) throws SQLException{
        ArrayList<Course> courseList = new ArrayList<Course>();
        try{
    	while (rs.next()) {
    		Course course = new Course();	
    		course.setC_code(rs.getString("c_code"));
    		course.setC_level(rs.getString("title"));
    		course.setCategory(rs.getString("type"));
    		course.setRetail_price(rs.getDouble("retail_price"));
    		course.setStatus(rs.getString("status"));
    		course.setTitle(rs.getString("title"));
    		course.setType(rs.getString("type"));
    		courseList.add(course);
          }
        }
        catch (SQLException e) {
            throw new SQLException(e);
        }
    	return courseList;
    }    
}
