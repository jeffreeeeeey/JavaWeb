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
 %>

<title>Insert title here</title>
</head>
<body>
<%
	Connection connection = null; 
	Statement statement = null;
	ResultSet resultSet = null; 
	
	Class.forName("com.mysql.jdbc.Driver"); 
	connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
	statement = connection.createStatement();
	resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE id = " + meaning_id);
	resultSet.next();
	String meaning = resultSet.getString("meaning");
	out.println("meaning:" + meaning + "</br>");
 %>
  <form action="operateWord.jsp" method = "post">
 	<input type="hidden" name="action" value="addSample">
 	<input type="hidden" name="meaning_id" value=<%=meaning_id %>>
 	<textarea name="sample" id="sample_textarea" cols="30" rows="3"></textarea>
 	<input type="submit" name="button" id="button" value="Save" />
 </form>
	
</body>
</html>