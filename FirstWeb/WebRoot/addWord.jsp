<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	//String action = (String)request.getAttribute("action");
	String action = "add";
	String id = (String)request.getAttribute("id");
	String name = (String)request.getAttribute("name");
	
	boolean isEdit = "edit".equals(action);
 %>

<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.css">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
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
  <div>
	 <form action="operateWord.jsp" method = "post">
	 	<input type="hidden" name="action" value="add">
	 	<input type="hidden" name="id" value="<%=isEdit ? id : "" %>"> 
	 	<fieldset>
	 		<legend>
	 			<%=
	 				isEdit ? "Edit Word" : "Add New Word"
	 			%>
	 			<br></legend>
	 		<table width="492" border="1">
      <tr>
        <td width="49">&nbsp;</td>
        <td width="219">&nbsp;</td>
        <td width="202">&nbsp;</td>
      </tr>
      <tr>
        <td height="50"><label for="1">Word</label></td>
        <td>
        <input type="text" name="name" id="1" /></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="50"><label for="1">IPA</label></td>
        <td>
        <label>E </label> <input type="text" name="IPA_E" id="1" /></td>
        <td>
        <label>A </label><input type="text" name="IPA_A" id="1" /></td>
      </tr>
      
      <tr>
        <td height="50"><label for="1">Meaning</label></td>
        <td>
        <textarea name="meaning" id="meaning_textarea" cols="30" rows="3"></textarea></td>
        <td>&nbsp;
        </td>
      </tr>
      <tr>
        <td height="50"><label for="1">Sample</label></td>
        <td>
        <textarea name="sample" id="sample_textarea" cols="30" rows="3"></textarea></td>
        <td>&nbsp;</td>
      </tr>

      <tr>
        <td>&nbsp;</td>
        <td><input type="submit" name="button" id="button" value="<%= isEdit? "Save" : "Add" %>" /></td>
        <td>&nbsp;</td>
      </tr>
    </table>

	 		
	 		
	 	</fieldset>
	 </form>   
</div>
  </body>
</html>
