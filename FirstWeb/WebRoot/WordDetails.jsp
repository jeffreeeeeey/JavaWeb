<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String id_string = request.getParameter("word_id");
	int word_id = Integer.parseInt(id_string);
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
		
		//get meaning
		resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
		resultSet.next();
		int meaning_id = resultSet.getInt("id");
		String meaning = resultSet.getString("meaning");
		
		//get sample by meaning id
		resultSet = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
		resultSet.next();
		String sample = resultSet.getString("sample");
		
		out.println("id:" + id_string + "</br>");
		out.print(name + "</br>" + meaning + "</br>" + sample );
	
		connection.close();
		statement.close();
		resultSet.close();
	
 %>


</body>
</html>