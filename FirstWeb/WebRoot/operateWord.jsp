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
	
	if("add".equals(action)){
		String sql = "INSERT INTO word " + "(name) value " + "('" + forSQL(name) + "')";
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int result = 0;
		try{
			Class.forName("com.mysql.jdbc.Driver"); 
			connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			statement = connection.createStatement();
			result = statement.executeUpdate(sql);
			out.println("added " + result + " words");
		}catch(SQLException e){
			e.printStackTrace();
		}finally{ 
			if(resultSet != null)
				resultSet.close(); 
			if(statement != null) 
				statement.close();
			if(connection != null) 
				connection.close(); 
		}//end of finally
	}else if("del".equals(action)){
		
	}else if("edit".equals(action){
		String id = request.getParameter("id");
		String sql = "SELECT * FORM words WHERE id = " + id;
		
	}
	
 %>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
