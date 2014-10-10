<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String action = (String)request.getAttribute("action");
	String id = (String)request.getAttribute("id");
	String name = (String)request.getAttribute("name");
	
	boolean isEdit = "edit".equals(action);
 %>

<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addWord.jsp' starting page</title>
    
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
	 <form action="operateWord.jsp" method = "post">
	 	<input type="hidden" name="action" value="<%=isEdit ? "save" : "add"%>">
	 	<input type="hidden" name="id" value="<% %>"> 
	 </form>   

  </body>
</html>
