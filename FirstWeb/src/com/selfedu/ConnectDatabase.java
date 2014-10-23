package com.selfedu;

import java.sql.*;

public class ConnectDatabase {
	public ConnectDatabase(){
		
	}
	public Statement getStatement() throws ClassNotFoundException{
		Connection connection = null;
		Statement statement = null;
		SelfSettings settings = new SelfSettings();
		String jdbcString = settings.SQLiteJDBC;
		String databaseURL = settings.SQLiteDatabaseURL;
		try {
			Class.forName(jdbcString);
			connection = DriverManager.getConnection(databaseURL);
			statement = connection.createStatement();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return statement;
	}
}
