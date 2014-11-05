<%@page import="com.selfedu.ConnectDatabase"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Dictionary"%>
<%@ page import="java.sql.SQLException"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.selfedu.*" %>
<%@ page import = "com.selfedu.MeaningSample" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	String id_string = request.getParameter("word_id");
	int word_id = Integer.parseInt(id_string);
 %>
<title>Insert title here</title>
</head>
<body>
<%
	Connection connection = null; 
	Statement statement = null;
	ResultSet resultSet = null; 
	ResultSet resultSet_meaning = null;
	ResultSet resultSet_sample = null;
	/*
	try{
		//Class.forName("com.mysql.jdbc.Driver"); 
		//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		
		Class.forName("org.sqlite.JDBC");
		connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
		//Get word name
		statement = connection.createStatement();
		resultSet = statement.executeQuery("SELECT * FROM words WHERE id = " + word_id);
		resultSet.next();
		String name = resultSet.getString("name");
		String character = resultSet.getString("character");
		
		out.print("<strong>" + name + "</strong>" + "</br><a href=\"addMeaning.jsp?word_id=" + word_id + "\">add meaning</a> </br>");
		out.print(character + "</br>");
		//Get IPAs
		resultSet = statement.executeQuery("SELECT * FROM IPAs WHERE word_id = " + word_id);
		if(resultSet.next()){
			String IPA_E = resultSet.getString("IPA_E");
			String IPA_A = resultSet.getString("IPA_A");
			out.println("IPA: /" + IPA_E + "/  /" + IPA_A + "/</br>");
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	//get meanings
	resultSet_meaning = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
	ArrayList<WordMeaning> meanings = new ArrayList<WordMeaning>();
	
	while(resultSet_meaning.next()){
		WordMeaning wordMeaning = new WordMeaning();
		int meaning_id = resultSet_meaning.getInt("id");
		String meaning = resultSet_meaning.getString("meaning");
		wordMeaning.id = meaning_id;
		wordMeaning.meaning = meaning;
		meanings.add(wordMeaning);
		
	}
		
	for(int i = 0; i < meanings.size(); i++){
		WordMeaning wordMeaning = meanings.get(i);
		int meaning_id = wordMeaning.id;
		String meaning = wordMeaning.meaning;
		out.println("* " + meaning + " <a href=\"" + meaning_id + "\">Edit</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"addSample.jsp?meaning_id=" + meaning_id + "\">add sample</a> </br>");
		
		//get sample of this meaning
		wordMeaning.samplesArrayList = new ArrayList<MeaningSample>();
		resultSet_sample = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
		
		while(resultSet_sample.next()){
			MeaningSample meaningSample = new MeaningSample();
			int id = resultSet_sample.getInt("id");
			String sample = resultSet_sample.getString("sample");
			meaningSample.id = id;
			meaningSample.sample = sample;
			
			wordMeaning.samplesArrayList.add(meaningSample);
		}
		
		int n = wordMeaning.samplesArrayList.size();
		if(n >= 1){
			for(int j = 0; j < n; j++ ){
				MeaningSample meaningSample = wordMeaning.samplesArrayList.get(j);
				out.println("<em>" + meaningSample.sample + "</em><a href = \"\">Edit</a>&nbsp;&nbsp;</br>");
			}
		}
	}
	//out.println("</br>size:" + meanings.size());
	
	//out.println("id:" + id_string + "</br>");

	if(statement != null)
		statement.close();
	if(resultSet != null)
		resultSet.close();
	if(resultSet_sample != null)
		resultSet_sample.close();
	if(resultSet_meaning != null)
		resultSet_meaning.close();
	if(connection != null)
	connection.close();
	*/
	
	ConnectDatabase connectDatabase = new ConnectDatabase();
	Word word = connectDatabase.getWord(word_id);
	
	String name = word.name;
	String character = word.character;
		
	out.print("<strong>" + name + "</strong><a href=\"addMeaning.jsp?word_id=" + word_id + "\">add meaning</a></br>");
	out.print(character + "</br>");
	for(String ipa : word.IPAs){
		out.println(ipa + "&nbsp;");
	}
	out.println("</br>");
	for(WordMeaning meaning : word.meanings){
		out.print("*" + meaning.meaning + "&nbsp;&nbsp;<a href=\"addSample.jsp?meaning_id=" + meaning.id + "\">add sample</a></br>");
		for(MeaningSample sample : meaning.samplesArrayList){
			out.println("<em>" + sample.sample + "</em></br>");
		}
	}
 %>


</body>
</html>