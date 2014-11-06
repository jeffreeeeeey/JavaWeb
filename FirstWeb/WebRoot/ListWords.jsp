<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf-8" %>

<%@ page import="com.selfedu.ConnectDatabase" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
	<body>
		
		<br>
		<%
			Connection connection = null; 
			Statement statement = null;
			ResultSet resultSet = null; 
			
			try{
				/*
				SelfSettings settings = new SelfSettings();
				String jdbcString = settings.SQLiteJDBC;
				String databaseURL = settings.SQLiteDatabaseURL;
				Class.forName(jdbcString);
				connection =DriverManager.getConnection(databaseURL);
				*/
				
				ConnectDatabase connectDatabase = new ConnectDatabase();
				statement = connectDatabase.getStatement();
				
				resultSet = statement.executeQuery("select * from words");
				while(resultSet.next()){ 
					int id = resultSet.getInt("id");
					String name = resultSet.getString("name"); 
				
					out.println("<a href = \"WordDetails.jsp?word_id=" + id +"\">" + name + "</a>&nbsp;");
					out.println("    <a href =\"operateWord.jsp?action=edit&word_id=" + id + "\">Edit </a>&nbsp;&nbsp;"); 
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