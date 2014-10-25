<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String action = (String)request.getAttribute("action");
	
	boolean isEdit = "edit".equals(action);
	
	String id = (String)request.getAttribute("word_id");
	String name = (String)request.getAttribute("name");
	String IPA_E = (String)request.getAttribute("PLA_E");
	String IPA_A = (String)request.getAttribute("PLA_A");
	String meaning = (String)request.getAttribute("meaning");
	String sample = (String)request.getAttribute("sample");
 %>

<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    
    <title><%= isEdit ? "Edit Word" : "Add Word" %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	var meaningCounter = 1;
	var sampleCounter = 1;
	
	function addMeaning(){
		meaningCounter++;
		var fragment = document.createDocumentFragment();
		var meaningFieldSet1 = document.getElementById("meaningFieldSet1");
		//clone a meaning fieldSet
		var newMeaningFieldSet = meaningFieldSet1.cloneNode(true);
		//set the new meaning fieldSet
		newMeaningFieldSet.id = "meaningFieldSet" + meaningCounter;
		var childs = newMeaningFieldSet.childNodes;
		for(i = 0; i < childs.length; i++){
			var ele = childs[i];
			if(ele.id == "meaning_label1"){
				ele.id = "meaning_label" + meaningCounter + 2;
				ele.innerHTML = "new meaning";
			}else{
				
			}
		}
		
		var submitTable = document.getElementById("submitTable");
		var parent = meaningFieldSet1.parentNode;
		parent.insertBefore(newMeaningFieldSet, submitTable);
		
		
		
		//document.getElementById("meaningHeader").innerHTML = "meaning " + meaningCounter;
		
		/*
		var wordDetailTable  = document.getElementById("meaningsTable");
		
		
		var rowLength = wordDetailTable.rows.length;
		var newMeaningRow = wordDetailTable.insertRow(rowLength - 1);
		
		var cell1 = newMeaningRow.insertCell();
		cell1.border = "1";
		var cell2 = newMeaningRow.insertCell();
		cell2.border = "1";
		var cell3 = newMeaningRow.insertCell();
		cell3.border = "1";
		
		//add meaning
		var meaningText = document.createTextNode("meaning");
		var meaningTextArea = document.createElement("textarea");
		var addSampleBtn = document.createElement("input");
		addSampleBtn.type = "button";
		addSampleBtn.value = "add sample";
		var deleteMeaningBtn = document.createElement("input");
		deleteMeaningBtn.type = "button";
		deleteMeaningBtn.value = "delete meaning";
		cell1.appendChild(meaningText);
		cell2.appendChild(meaningTextArea);
		cell3.appendChild(addSampleBtn);
		cell3.appendChild(deleteMeaningBtn);
		
		
		//frash();
		*/
	}
	</script>
  </head>
  
  <body>
  <div>
	 <form action="operateWord.jsp" method = "post" id="addWordForm">
	 	<input type="hidden" name="action" value=<%= isEdit?"save":"add" %>>
	 	<input type="hidden" name="id" value="<%=isEdit ? id : "" %>"> 
	 	<h1><%= isEdit ? "Edit Word" : "Add New Word" %></h1>
	 	<fieldset id="baseFieldSet">
	 		<legend><h2>basic</h2></legend>
	 		<table width="492" border="0" id="wordBasicTable">
      
      <tr>
        <td height="50"><label for="1">Word</label></td>
        <td>
        <input type="text" name="name" id="1" value="<%= isEdit?name:""%>"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="50"><label for="1">IPA</label></td>
        <td>
        <label>E </label> <input type="text" name="IPA_E" id="1" value="<%= isEdit?IPA_E:""%>"/>
        
        </td>
        <td>
        <label>A </label><input type="text" name="IPA_A" id="1" value="<%= isEdit?IPA_A:""%>"/></td>
      </tr>
      <tr>
      	<td>&nbsp;</td>
      	<td><input type="button" id="newMeaning" value="add meaning" onclick="addMeaning()"></td>
      	<td>&nbsp;</td>
      </tr>
      
    </table>
	 	</fieldset>
	 	<fieldset id="meaningFieldSet1">
	 	<legend id="meaninglegend1"><h2 id="meaningHeader">meaning <script type="text/javascript">document.write(/*meaningCounter*/);</script> </h2></legend>
	 	<table  width="492" border="0" id="meaningsTable1">
	 	<tr>
        <td width="49">&nbsp;</td>
        <td width="219">&nbsp;</td>
        <td width="202"></td>
      </tr>
	 	<tr>
        <td height="50"><label for="meaning_label1">Meaning</label></td>
        <td>
        <textarea name="meaning" id="meaning_textarea1" cols="30" rows="3"><%= isEdit?meaning:""%></textarea></td>
        <td><input type="button" id="newSample" value="add sample" onclick="addMeaning()"></br>
        	<input type="button" id="newSample" value="delete meaning" onclick="addMeaning()">
        </td>
      </tr>
      <tr>
        <td height="50"><label for="sample1">Sample</label></td>
        <td>
        <textarea name="sample" id="sample_textarea1" cols="30" rows="3"><%= isEdit?sample:""%></textarea></td>
        <td><input type="button" id="newSample" value="delete sample" onclick="addMeaning()"></td>
      </tr>
	 	</table>
	 	</fieldset>
	 	
	 	<table id="submitTable">
	 	<tr>
        <td width = "100">&nbsp;</td>
        <td><input type="submit" name="button" id="button" value="<%= isEdit? "Save" : "Add" %>" /></td>
        <td>&nbsp;</td>
      </tr>
	 	</table>
	 	
	 </form>   
</div>
  </body>
</html>
