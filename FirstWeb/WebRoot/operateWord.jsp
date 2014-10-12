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
	String action = request.getParameter("action");
	String sql = null;
	
	
	if("add".equals(action)){
		sql = "INSERT INTO words " + "(name) value " + "('" + name + "')";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int n = 0;
		String aString = "good";
		
		int result = 0;
		
			Class.forName("com.mysql.jdbc.Driver"); 
			connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			statement = connection.createStatement();
			result = statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			resultSet = statement.getGeneratedKeys();
			resultSet.next();
			n = resultSet.getInt(1);
			
			out.println("<html> <body>");
			out.println("executing: "+sql +"</br>");
			out.println("add " + result + "words, </br>" + aString);
			out.println("word id:" + n);
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
