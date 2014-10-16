<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Dictionary"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.selfedu.WordMeaning" %>
<%@ page import = "com.selfedu.MeaningSample" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String id_string = request.getParameter("word_id");
	int word_id = Integer.parseInt(id_string);
 %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	Connection connection = null; 
	Statement statement = null;
	ResultSet resultSet = null; 
	ResultSet resultSet_meaning = null;
	ResultSet resultSet_sample = null;
	
		Class.forName("com.mysql.jdbc.Driver"); 
		connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		statement = connection.createStatement();
		resultSet = statement.executeQuery("SELECT * FROM words WHERE id = " + word_id);
		resultSet.next();
		String name = resultSet.getString("name");
		out.print(name + "    <a href=\"addMeaning.jsp?word_id=" + word_id + "\">add meaning</a> </br>");
		
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
			
			
			//get sample by meaning id
			/*
			resultSet_sample = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
			resultSet_sample.next();
			String sample = resultSet_sample.getString("sample");
			out.println(sample + "</br>");
			*/
		}
		
		for(int i = 0; i < meanings.size(); i++){
			WordMeaning wordMeaning = meanings.get(i);
			int meaning_id = wordMeaning.id;
			String meaning = wordMeaning.meaning;
			//get sample of this meaning
			resultSet_sample = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
			while(resultSet_sample.next()){
				MeaningSample meaningSample = new MeaningSample();
				int id = resultSet_sample.getInt("id");
				String sample = resultSet_sample.getString("sample");
				meaningSample.id = id;
				meaningSample.sample = sample;
				
				wordMeaning.samplesArrayList.add(meaningSample);
			}
			
			out.println(meaning + "    <a href=\"\">add sample</a> </br>");
			
			int n = wordMeaning.samplesArrayList.size();
			for(int j = 0; j < n; i++ ){
				MeaningSample meaningSample = wordMeaning.samplesArrayList.get(j);
				out.println(meaningSample + "</br>");
			}
		}
		out.println("</br>size:" + meanings.size());
		
		//out.println("id:" + id_string + "</br>");
	
		connection.close();
		statement.close();
		resultSet.close();
		resultSet_sample.close();
		resultSet_meaning.close();
 %>


</body>
</html>