<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<jsp:directive.page import="java.sql.Date" />
<jsp:directive.page import="java.sql.Timestamp" />
<jsp:directive.page import="java.sql.SQLException" />

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
	<body>
		<a href="addWord.jsp" id="link-1">add</a>
		<br>
		<%
			Connection connection = null; Statement statement = null;
			ResultSet resultSet = null; 
			try{
				//Class.forName("com.mysql.jdbc.Driver"); 
				//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
				Class.forName("org.sqlite.JDBC");
				connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
				statement = connection.createStatement();
				resultSet = statement.executeQuery("select * from words");
				while(resultSet.next()){ 
					int id = resultSet.getInt("id");
					String name = resultSet.getString("name"); 
				
					out.println("<a href = \"WordDetails.jsp?word_id=" + id +"\">" + name + "</a>");
					out.println("    <a href =\"operateWord.jsp?action=del&word_id=" + id + "\">delete </a></br>"); 
					} 
				}catch(SQLException e){
					e.printStackTrace(); 
				}
					if(resultSet != null)
						resultSet.close(); 
					if(statement != null) 
						statement.close();
					if(connection != null) 
						connection.close(); 
		%>
	</body>
</html>