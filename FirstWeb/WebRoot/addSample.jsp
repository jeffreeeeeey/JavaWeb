<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	String id_string = request.getParameter("meaning_id");
	int meaning_id = Integer.parseInt(id_string);
	String wordIdString = request.getParameter("word_id");
	int word_id = Integer.parseInt(wordIdString);
 %>
<link rel="stylesheet" type="text/css" href="main.css" />
<title>add sample</title>
</head>
<body>
<%
	Connection connection = null; 
	Statement statement = null;
	ResultSet resultSet = null; 
	
	//Class.forName("com.mysql.jdbc.Driver"); 
	//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
	Class.forName("org.sqlite.JDBC");
	connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
	statement = connection.createStatement();
	resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE id = " + meaning_id);
	resultSet.next();
	String meaning = resultSet.getString("meaning");
	out.println("meaning:" + meaning + "</br>");
	
	if(resultSet != null)
		resultSet.close(); 
	if(statement != null) 
		statement.close();
	if(connection != null) 
		connection.close(); 
 %>
  <form action="operateWord.jsp" method = "post">
 	<input type="hidden" name="action" value="addSample">
 	<input type="hidden" name="word_id" value=<%=word_id %>>
 	<input type="hidden" name="meaning_id" value=<%=meaning_id %>>
 	<textarea name="sample" id="sample_textarea" cols="30" rows="3"></textarea>
 	<input type="submit" name="button" id="button" value="Save" />
 </form>
	
</body>
</html>