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
	 	<legend name="meaningLegend"><h2 name="legendText">meaning1</h2></legend>
	 	<table  width="492" border="0" id="">
	 	<tbody name="meaning_table1" id="meaning_table1">
	 	<tr>
        <td width="49">&nbsp;</td>
        <td width="219">&nbsp;</td>
        <td width="202"></td>
      </tr>
	 	<tr id="meaning_row">
        <td height="50"><label>Meaning</label></td>
        <td>
        <textarea name="meaning" id="meaning1_textarea" cols="30" rows="3"><%= isEdit?meaning:""%></textarea></td>
        <td><input type="button" id="add_sample" name="add_sample" value="add sample" onclick="addSample(1,'meaning_table1')"></br>
        	<input type="button" id="delete_meaning" value="delete meaning" onclick="">
        </td>
      </tr>
      <tr id="sample_row1">
        <td height="50"><label for="sample1">Sample</label></td>
        <td>
        <textarea name="meaning1_sample" id="meaning1_sample1_textarea" cols="30" rows="3"><%= isEdit?sample:""%></textarea></td>
        <td><input type="button" id="delete_sample" value="delete sample" onclick=""></td>
      </tr>
      </tbody>
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
  <script type="text/javascript">
  	var meaningsArray = [];
  	var samplesArray = [];
  	var Word = new Object();
  	Word.meanings = [];
  	
  	var meaning1 = new Object();
  	meaning1.id = 1;
  	meaning1.text = "";
  	meaning1.samples = [];
  	
  	var sample1 = new Object();
  	sample1.id = 1;
  	sample1.text = "";
  	
  	meaning1.samples.push(sample1);
  	Word.meanings.push(meaning1);
  	
	var meaningCounter = 1;
	var sampleCounter = 1;
	//clone a meaning fieldSet when the page loaded
	var meaningFieldSet1 = document.getElementById("meaningFieldSet1");
	var baseMeaningFieldSet = meaningFieldSet1.cloneNode(true);
	
	function addMeaning(){
		meaningCounter = Word.meanings.length;
		var n = meaningCounter + 1;
		//create objects of meaning and sample, and add it to the word obj.
		var newMeaningObj = new Object();
		newMeaningObj.id = meaningCounter + 1;
		newMeaningObj.text = "";
		newMeaningObj.samples = [];
		
		var newSampleObj = new Object();
		newSampleObj.id = 1;
		newSampleObj.text = "";
		
		newMeaningObj.samples.push(newSampleObj);
		Word.meanings.push(newMeaningObj);
		
		
		/* create elements one by one
		//Create elements of the fieldset
		var fragment = document.createDocumentFragment();
		
		var new_fieldset = document.createElement("fieldset");
		new_fieldset.id = "meaning_fieldset" + meaningCounter;
		var new_legend = document.createElement("legend");
		var new_legend_h = document.createElement("h2");
		var new_legend_text = document.createTextNode("meaning" + meaningCounter);
		
		var new_table = document.createElement("table");
		new_table.width = "492";
		new_table.border = "0";
		var tbody = document.createElement("tbody");
		
		new_legend_h.appendChild(new_legend_text);
		new_legend.appendChild(new_legend_h);
		new_fieldset.appendChild(new_legend);
		new_fieldset.appendChild(new_table);
		fragment.appendChild(new_fieldset);
		*/
		
		// clone a new one from the base
		var newMeaningFieldSet = baseMeaningFieldSet.cloneNode(true);
		
		var parent = meaningFieldSet1.parentNode;
		
		//set the new meaning fieldSet, and insert it before the submit button
		newMeaningFieldSet.id = "meaningFieldSet" + Word.meanings.length;
		
		var submitTable = document.getElementById("submitTable");
		
		parent.insertBefore(newMeaningFieldSet, submitTable);
		
		//set the id and name of meanings and samples, so when submit the form, request can get parameters.
		var meanings = document.getElementsByName("meaning");
		//Iterate the meaning textareas, get the last one
		for(i = 0; i < meanings.length; i++){
			if(i == meanings.length - 1){
				var ele = meanings[i];
				ele.id = "meaning" + (meaningCounter + 1) + "_textarea";
				ele.name = "meaning";// + (meaningCounter + 1);
			}
		}
		var samples = document.getElementsByName("meaning1_sample");
		//Get the added sample textarea
		for (var i = 0; i < samples.length; i++) {
			if(i == samples.length - 1){
				var ele = samples[i];
				ele.id = "meaning" + (meaningCounter+1) + "_sample" + 1 + "_textarea";
				ele.name = "meaning" + (meaningCounter+1) + "_sample";
			}
		}
		//Set the id of table, can use it when add sample
		var tables = document.getElementsByName("meaning_table1");
		for (var i = 0; i < tables.length; i++) {
			if (i == tables.length - 1) {
				var ele = tables[i];
				ele.id = "meaning_table" + (meaningCounter + 1);
				ele.name = "meaning_table";
				//alert(ele.name);
			}
		}
		//Set the buttons
		var buttons = document.getElementsByName("add_sample");
		for (var i = 0; i < buttons.length; i++) {
			if(i == buttons.length - 1){
				var ele = buttons[i];
				var n = meaningCounter + 1;
				var m = "meaning_table" + n;
				ele.onclick = function(){
					addSample(n,m);
				};
			}
		}
		
		//alert(Word.meanings.length);
		updateLegend();
	}
	
	function updateLegend(){
		var legends = document.getElementsByName("legendText");
		for (var i = 0; i < legends.length; i++) {
			var ele = legends[i];
			ele.textContent = "meaning" + (i + 1);
			
			//alert(ele.textContent);
		}
	}
	
	function addSample(meaningNum,tableID){
		var n = meaningNum;
		var theMeaning = Word.meanings[meaningNum - 1];
		var sampleNum = theMeaning.samples.length + 1;
		//add an object to samples array
		var newSample = new Object();
		newSample.id = sampleNum;
		newSample.text = "";
		theMeaning.samples.push(newSample);
		
		var meaning = document.getElementById(tableID);
		var row = document.createElement("tr");
		row.id = "menaing" + meaningNum + "_sample" + sampleNum + "_tr";
		var cell1 = document.createElement("td");
		var cell2 = document.createElement("td");
		var cell3 = document.createElement("td");
		var text = document.createTextNode("sample" + sampleNum);
		cell1.appendChild(text);
		var textarea = document.createElement("textarea");
		textarea.rows = "3";
		textarea.cols= "30";
		textarea.id = "meaning" + meaningNum + "_sample" + sampleNum;
		textarea.name = "meaning" + meaningNum + "_sample";
		cell2.appendChild(textarea);
		var btn = document.createElement("input");
		btn.type = "button";
		btn.value = "delete sample";
		btn.onclick = function(){
			deleteSample("");
		}
		cell3.appendChild(btn);
		
		row.appendChild(cell1);
		row.appendChild(cell2);
		row.appendChild(cell3);
		meaning.appendChild(row);
	}
	
	function deleteSample(sampleRow_id){
		var sample = document.getElementById(sample_id);
		var parent = sample.parentNode;
		parent.removeChild(sample);
	}
	
	function deleteMeaning(meaning_id){
		
	}
	</script>
</html>
