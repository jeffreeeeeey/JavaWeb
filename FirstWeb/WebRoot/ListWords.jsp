


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf-8" %>
<%@ page import="com.selfedu.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="main.css" />
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
				int n = 0;//count the row number.
				
				//add words to an arraylist.
				ArrayList<Word> wordsArrayList = new ArrayList<Word>();
				
				while(resultSet.next()){ 
					int id = resultSet.getInt("id");
					String name = resultSet.getString("name");
					Word word = connectDatabase.getWord(id);
					
					//out.print(word.name + "</br>");
					wordsArrayList.add(word);
					} 
				out.println("there are " + wordsArrayList.size() + "words now.</br>");
				request.setAttribute("wordsArrayList", wordsArrayList);
				%>
				<table border="1">
					<tbody>
						<tr>
							<td>id</td>
							<td>word</td>
							<td>character</td>
							<td>operation</td>
						</tr>
					<c:forEach items="${ wordsArrayList }" var="w" varStatus="varstatus">
						<tr>
							<td>${varstatus.count }</td>
							<td><a href = ${"WordDetails.jsp?word_id="}${ w.id }>${w.name }</a></td>
							<td>${w.character }</td>
							<td><a href = ${"operateWord.jsp?action=edit&word_id=" }${w.id }>Edit</a>&nbsp;&nbsp;<a href =${ "operateWord.jsp?action=del&word_id="}${w.id }>delete</a></td>
						</tr>
					</c:forEach>
					</tbody>
				
				</table>
				
				<%
				/*
				for(Word w : wordsArrayList){
					n++;
					out.println(n + ".&nbsp;<a href = \"WordDetails.jsp?word_id=" + w.id +"\">" + w.name + "</a>&nbsp;" + w.character + "&nbsp;&nbsp;");
					out.println("    <a href =\"operateWord.jsp?action=edit&word_id=" + w.id + "\">Edit </a>&nbsp;&nbsp;"); 
					out.println("    <a href =\"operateWord.jsp?action=del&word_id=" + w.id + "\">delete </a></br>"); 
			
				}*/
				
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