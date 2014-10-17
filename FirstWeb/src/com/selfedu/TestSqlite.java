package com.selfedu;
import java.io.File;
import java.sql.*;
import java.util.jar.JarException;

public class TestSqlite {

	public static void main(String[] args) throws ClassNotFoundException {
		Class.forName("org.sqlite.JDBC");

	    Connection connection = null;
	    try
	    {
	      // create a database connection
	      connection = DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
	      Statement statement = connection.createStatement();
	      statement.setQueryTimeout(30);  // set timeout to 30 sec.

	      //statement.executeUpdate("drop table if exists person");
	      //statement.executeUpdate("create table person (id integer, name string)");
	      statement.executeUpdate("insert into words (name) values('nice')");
	      statement.executeUpdate("insert into words (name) values('fine')");
	      ResultSet rs = statement.executeQuery("select * from words");
	      while(rs.next())
	      {
	        // read the result set
	    	System.out.println("id = " + rs.getInt("id"));
	        System.out.println("name = " + rs.getString("name"));
	      }
	    }
	    catch(SQLException e)
	    {
	      // if the error message is "out of memory", 
	      // it probably means no database file is found
	      System.err.println(e.getMessage());
	    }
	    finally
	    {
	      try
	      {
	        if(connection != null)
	          connection.close();
	      }
	      catch(SQLException e)
	      {
	        // connection close failed.
	        System.err.println(e);
	      }
	    }

	}

}
