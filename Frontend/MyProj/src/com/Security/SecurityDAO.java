package com.Security;

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

import java.util.ArrayList;
import java.util.Date;

public class SecurityDAO {
	
    private DataSource dataSource;
    private Connection connection;
    private Statement statement;
    
    private static final String SQL_VERIFY_PERSON_ID = "SELECT person_id FROM person WHERE person_id = ? ";
    private static final String SQL_VERIFY_COMPANY_ID = "SELECT company_id FROM company WHERE company_id = ? ";    

    public SecurityDAO(){
        try {
            // Get DataSource
            Context initContext  = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/test2");
 
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
   
    public boolean verifyPersonID (String person_id) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_VERIFY_PERSON_ID;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setInt(1, Integer.parseInt(person_id));
            resultSet = pstmt.executeQuery(); 
            return resultSet.next();
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
    
    public boolean verifyCompanyID (String company_id) throws SQLException {
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        try {
            // Get Connection and Statement
            connection = dataSource.getConnection();
            String query = SQL_VERIFY_COMPANY_ID;

            pstmt = connection.prepareStatement(query); // create a statement
            pstmt.setString(1, company_id);
            resultSet = pstmt.executeQuery(); 
            return resultSet.next();
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
