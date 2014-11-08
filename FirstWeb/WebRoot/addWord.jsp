<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.selfedu.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<html>
  <head>
  	<%
  	OperateString operateString = new OperateString();
	String action = (String)request.getAttribute("action");
	Word word = new Word();
	String id = null;//in edit, use js to set its value
	
	int word_id = 0; 
	String name = null;
	String IPA_E = null;
	String IPA_A = null;
	String character = null;
	
	boolean isEdit = "edit".equals(action);
	//out.print("is eidt?:" + isEdit + "</br>");
	if(isEdit){
		//String word_idString = request.getParameter("word_id");
		//word_id = Integer.parseInt(word_idString);
		word = (Word)request.getAttribute("word");
	}
	%>
  
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <base href="<%=basePath%>">
    
    <title><%= isEdit ? "Edit Word" : "Add Word" %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="main.css" />
	
	</head>
	<body>
  <div>
	 <form action="operateWord.jsp" method = "post" id="addWordForm">
	 	<input type="hidden" name="action" value=<%= isEdit?"save":"add" %>>
	 	<input type="hidden" name="id" value="<%=isEdit ? word.id : "" %>"> 
	 	<h1><%= isEdit ? "Edit Word" : "Add New Word" %></h1>
	 	<fieldset id="baseFieldSet">
	 		<legend><h2>basic</h2></legend>
	 		<table width="492" border="0" id="wordBasicTable">
      
      <tr>
        <td height="50"><label for="1">Word</label></td>
        <td>
        <input type="text" name="name" id="wordNameInput" style="font-size: 25px; font-weight: bolder;" autofocus="true" value="<%= isEdit?name:""%>"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="50"><label for="1">IPA</label></td>
        <td>
        <label>E </label> <input type="text" name="IPA_E" id="IPA_EInput" value="<%= isEdit?IPA_E:""%>"/>
        
        </td>
        <td>
        <label>A </label><input type="text" name="IPA_A" id="IPA_AInput" value="<%= isEdit?IPA_A:""%>"/></td>
      </tr>
      <tr>
      	<td>
      	character
      	</td>
      	<td>
	      	<select id="character" name="character">
	      	<option>noun</option>
	      	<option>adjective</option>
	      	<option>verb</option>
	      	<option>adverb</option>
	      	<option>article</option>
	      	<option>prep</option>
	      	<option>pronoun</option>
	      	<option>conjunction</option>
	      	<option>numeral</option>
	      	<option>interjection</option>
	      	<option>determiner</option>
	      	</select>
      	</td>
      </tr>
      <tr height=60>
      	<td>&nbsp;</td>
      	<td><input type="button" name="addMeaningBtn" id="newMeaning" value="add meaning" onclick="addMeaning()"></td>
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
        <input type=hidden name="meaningId" value=<%= isEdit? word.meanings.get(0).id:"" %>>
        <textarea name="meaning" id="meaning1_textarea" cols="50" rows="3"></textarea></td>
        <td><input type="button" id="add_sample" name="addSampleBtn" value="add sample" onclick="addSample(1,'meaning_table1')"></br></br>
        	<input type="button" class="deletebtn" name="deleteMeaningBtn" id="deleteMeaningBtn_1" value="delete meaning" onclick="deleteMeaning('meaningFieldSet1')">
        </td>
      </tr>
      <tr id="meaning1_sample1_tr" name="sample_tr">
        <td height="50"><label for="sample1">Sample</label></td>
        <td>
        <input type=hidden name="sampleId" value=<%= isEdit? word.meanings.get(0).samplesArrayList.get(0).id:"" %>>
        <textarea name="meaning1_sample" id="meaning1_sample1_textarea" cols="50" rows="3"></textarea></td>
        <td><input type="button" class="deletebtn" id="delete_sample" name="deleteSampleBtn" value="delete sample" onclick="deleteSample('meaning1_sample1_tr')"></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      <td></td>
      <td>&nbsp;</td>
      </tr>
      </tbody>
	 	</table>
	 	</fieldset>
	 	
	 	<table id="submitTable">
	 	<tr height=60>
      	<td>&nbsp;</td>
      	<td><input type="button" name="addMeaningBtn" id="newMeaning" value="add meaning" onclick="addMeaning()"></td>
      	<td>&nbsp;</td>
      </tr>
	 	<tr>
        <td width = "100">&nbsp;</td>
        <td><input type="submit" name="button"  class="mainBtn" id="button" value="<%= isEdit? "Save" : "Add" %>" /></td>
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
	
	function addMeaning(meaningId){
		meaningCounter = Word.meanings.length;
		console.log("meaningCounter:" + meaningCounter);
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
		
		// clone a new one from the base
		var newMeaningFieldSet = baseMeaningFieldSet.cloneNode(true);
		
		//set the new meaning fieldSet, and insert it before the submit button
		newMeaningFieldSet.id = "meaningFieldSet" + Word.meanings.length;
		
		var submitTable = document.getElementById("submitTable");
		var parent = submitTable.parentNode;
		
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
		// Iterate the hidden meaning id inputs, get the last one
		var meaningIds = document.getElementsByName("meaningId");
		for(i = 0; i < meaningIds.length; i++){
			if(i == meaningIds.length - 1){
				var ele = meaningIds[i];
				ele.value = meaningId;
				console.log("meaning id:" + meaningId);
			}
		}
		// Iterate the hidden sample id inputs, get the last one
		
		
		//Get the added sample textarea
		var samples = document.getElementsByName("meaning1_sample");
		
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
		//Set the sample row, need it when delete
		var sampleRows = document.getElementsByName("sample_tr");
		var thisSampleRow;
		for (var i = 0; i < sampleRows.length; i++) {
			if(i == sampleRows.length - 1){
				thisSampleRow = sampleRows[i];
				thisSampleRow.id = "meaning" + (meaningCounter+1) + "_sample" + 1 + "_tr";
			}
		}
		
		//Set the add sample button
		var addSampleButtons = document.getElementsByName("addSampleBtn");
		for (var i = 0; i < addSampleButtons.length; i++) {
			if(i == addSampleButtons.length - 1){
				var ele = addSampleButtons[i];
				var n = meaningCounter + 1;
				var m = "meaning_table" + n;
				ele.onclick = function(){
					addSample(n,m);
				};
			}
		}
		//Set the delete sample button
		var deleteSampleBtns = document.getElementsByName("deleteSampleBtn");
		if(deleteSampleBtns.length > 1){
			var n = deleteSampleBtns.length - 1;
			var ele = deleteSampleBtns[n];
			
			ele.onclick = function() {
				deleteSample("meaning" + (meaningCounter+1) + "_sample" + 1 + "_tr");
			}
		}
		
		//Set the delete meaning button
		var deleteMeaningBtns = document.getElementsByName("deleteMeaningBtn");
		for (var i = 0; i < deleteMeaningBtns.length; i++) {
			if(i == deleteMeaningBtns.length - 1){
				var ele = deleteMeaningBtns[i];
				var fieldSet = "meaningFieldSet" + (meaningCounter + 1);
				//alert(fieldSet);
				ele.onclick = function(){
					deleteMeaning(fieldSet);
				}
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
	// get which meaning is, and the meaning table, add the new sample row as it's child
	function addSample(meaningNum,tableID){
		console.log("meaning num:" + meaningNum);
		meaningNum++;
		
		var theMeaning = Word.meanings[meaningNum - 2];
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
		var idInput = document.createElement("input");
		idInput.type = "hidden";
		idInput.name = "sampleId";
		var textarea = document.createElement("textarea");
		textarea.rows = "3";
		textarea.cols= "50";
		textarea.id = "meaning" + meaningNum + "_sample" + sampleNum + "_textarea";
		textarea.name = "meaning" + meaningNum + "_sample";
		cell2.appendChild(idInput);
		cell2.appendChild(textarea);
		var btn = document.createElement("input");
		btn.type = "button";
		btn.value = "delete sample";
		btn.name = "deleteSampleBtn";
		btn.className = "deletebtn";
		btn.onclick = function(){
			deleteSample(row.id );
		}
		cell3.appendChild(btn);
		
		row.appendChild(cell1);
		row.appendChild(cell2);
		row.appendChild(cell3);
		meaning.appendChild(row);
	}
	
	function deleteSample(sampleRow_id){
		var sample = document.getElementById(sampleRow_id);
		var parent = sample.parentNode;
		parent.removeChild(sample);
	}
	
	function deleteMeaning(meaningFieldSet_id){
		var fieldset = document.getElementById(meaningFieldSet_id);
		var parent = fieldset.parentNode;
		parent.removeChild(fieldset);
	}
	</script>
	
	<!-- If edit, set the meaning and sample form and values -->
	<script tye="text/javascript">
	var isEdit = false;
	<%
		if(isEdit){
			out.println("isEdit = true");
			
		 }
	 %>
	 if(isEdit){
 		setForm();
 	 }
	 function setForm(){
	 	var name = document.getElementById("wordNameInput");
	 	var ipa_e = document.getElementById("IPA_EInput");
	 	var ipa_a = document.getElementById("IPA_AInput");
	 	var character = document.getElementById("character");
	 	var characterText;
	 	
	 	<%
	 	if(isEdit){
		 	word = (Word)request.getAttribute("word");
			id = String.valueOf(word.id);
			
			name = word.name;
			if(word.IPAs.size() == 2){
				IPA_E = word.IPAs.get(0);
				IPA_A = word.IPAs.get(1);
			}
			
			character = word.character;
			ArrayList<WordMeaning> meanings = word.meanings; 
			out.println("name.value='" + name + "'");
			out.println("ipa_e.value='" + IPA_E + "'");
			out.println("ipa_a.value='" + IPA_A + "'");
			out.println("characterText = " + "'" + character + "'");
			for(int i = 0; i < word.meanings.size(); i++){
				if(i > 0){
					out.println("addMeaning(" + word.meanings.get(i).id +");");
				}
				// set the ' to \'
				WordMeaning meaning = word.meanings.get(i);
				String ms = meaning.meaning;
				ms = operateString.jsOutputString(ms);
				int n = i + 1;
				out.println("var meaning" + n + " = document.getElementById(\"meaning" + n + "_textarea\")");
				out.println("meaning" + n + ".value = " + "'" + ms + "'");
				for(int j = 0; j < meaning.samplesArrayList.size(); j++){
					//add sample textarea when there are more than one samples
					if(j > 0){
						int meaningNum  = i + 1;
						String tableID = "meaning_table" + meaningNum;
						out.println("addSample(" + i + ",'" + tableID + "');");
					}
					//set the sample value
					MeaningSample sample = meaning.samplesArrayList.get(j);
					String ss = sample.sample;
					ss = operateString.jsOutputString(ss);
					int m = j + 1;
					out.println("var sample" + m + " = document.getElementById(\"meaning" + n + "_sample" + m + "_textarea\")");
					out.println("sample" + m + ".value = " + "'" + ss + "'");
					//set the sample hidden id
					out.println("var sampleIds = document.getElementsByName(\"sampleId\")");
					out.println("var n = sampleIds.length;");
					out.println("var ele = sampleIds[n - 1];");
					out.println("ele.value =" + sample.id);
				}
			}
			
		}
	 	%>
	 	//disable the buttons
	 	for(var i = 0; i < character.options.length; i++){
			if(character.options[i].text == characterText){
				character.options[i].selected = true;
			}
		}
		var amBtns = document.getElementsByName("addMeaningBtn");
		var asBtns = document.getElementsByName("addSampleBtn");
		var dmBtns = document.getElementsByName("deleteMeaningBtn");
		var dsBtns = document.getElementsByName("deleteSampleBtn");
		console.log("dsBtns:" + dsBtns.length);
		/*
		for(var i = 0; i < dsBtns.length; i++){
			dsBtns[i].disabled="disabled";
			
		}
		*/
		
		var btns = [amBtns, asBtns, dmBtns, dsBtns];
		for(var i in btns){
			for(var j in btns[i]){
				btns[i][j].disabled="disabled";
			}
		}
		
	 }
	
	</script>
	
</html>
