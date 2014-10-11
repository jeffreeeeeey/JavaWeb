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
		int result = 0;
		try{
			Class.forName("com.mysql.jdbc.Driver"); 
			connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			statement = connection.createStatement();
			out.println("good");
			out.println("executing: "+sql);
			result = statement.executeUpdate(sql);
			
		}catch(SQLException e){
			out.println("executing: "+sql);
			e.printStackTrace();
			
		}finally{ 
			if(resultSet != null)
				resultSet.close(); 
			if(statement != null) 
				statement.close();
			if(connection != null) 
				connection.close(); 
		}//end of finally
		
		out.println("<html> <body>");
		out.println("add " + result + "words");
		out.println("</body></html>");
	}else if("del".equals(action)){
		
	}else if("edit".equals(action)){
		String id = request.getParameter("id");
		sql = "SELECT * FORM words WHERE id = " + id;
		
	}
	
	
 %>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'operateWord.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    This is my JSP page. <br>
    
  </body>
</html>
