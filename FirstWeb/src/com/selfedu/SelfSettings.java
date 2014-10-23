package com.selfedu;

public class SelfSettings {
	public  String SQLiteJDBC = "org.sqlite.JDBC";
	public  String SQLiteDatabaseURL = "jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db";
	
	public String MySqlJDBC = "com.mysql.jdbc.Driver";
	public String MySqlDatabaseURL = "jdbc:mysql://localhost:3306/wordsDB";
	public String MySqlManager = "root";
	public String MySqlKey = "123456";
	public void show(){
		System.out.println("here");
	}
}
