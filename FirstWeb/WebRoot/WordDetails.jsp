<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String id_string = request.getParameter("word_id");
	int word_id = 22;
 %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	Connection connection = null; Statement statement = null;
	ResultSet resultSet = null; 
	
		Class.forName("com.mysql.jdbc.Driver"); 
		connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		statement = connection.createStatement();
		resultSet = statement.executeQuery("SELECT * FROM words WHERE id = " + word_id);
		resultSet.next();
		String name = resultSet.getString("name");
		resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
		resultSet.next();
		String meaning = resultSet.getString("meaning");
		
		out.print(name + "</br>" + meaning);
		out.print("good");
	
		connection.close();
		statement.close();
		resultSet.close();
	
 %>


</body>
</html>