<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%! 
	public String forSQL(String sql) {
		return sql.replace("'", "\\'");
	}
%>
<%
	String name = request.getParameter("name");
	String meaning = request.getParameter("meaning");
	String sample = request.getParameter("sample");
	String action = request.getParameter("action");
	String sql = null;
	
	
	if("add".equals(action)){
		sql = "INSERT INTO words " + "(name) value " + "('" + name + "')";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int word_id = 0, meaning_id = 0, sample_id = 0;
		String aString = "good";
		
		int result = 0;
		
			Class.forName("com.mysql.jdbc.Driver"); 
			connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			statement = connection.createStatement();
			
			//add word in table, get the id
			result = statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			resultSet = statement.getGeneratedKeys();
			resultSet.next();
			word_id = resultSet.getInt(1);
			
			//add meaning in table, get the id
			sql = "INSERT INTO words_meanings (word_id, meaning) value " + "('" + word_id +"', '" + meaning + "')";
			statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			resultSet = statement.getGeneratedKeys();
			resultSet.next();
			meaning_id = resultSet.getInt(1);
			
			//add sample in table, get the id
			sql = "INSERT INTO meaning_samples (meaning_id, sample) value " + "('" + meaning_id +"', '" + sample + "')";
			statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			resultSet = statement.getGeneratedKeys();
			resultSet.next();
			sample_id = resultSet.getInt(1);
			
			out.println("<html> <body>");
			out.println("executing: "+sql +"</br>");
			out.println("add " + result + "words, </br>");
			out.println("word id:" + word_id + "</br>" + "meaning id:" + meaning_id + "</br>" + "sample id:" + sample_id + "</br>");
			out.println("</body></html>");
			
			if(resultSet != null)
				resultSet.close(); 
			if(statement != null) 
				statement.close();
			if(connection != null) 
				connection.close(); 
	}else if("del".equals(action)){
		
	}else if("edit".equals(action)){
		String id = request.getParameter("id");
		sql = "SELECT * FORM words WHERE id = " + id;
		
	}
	out.println("</br>end of page");
 %>
