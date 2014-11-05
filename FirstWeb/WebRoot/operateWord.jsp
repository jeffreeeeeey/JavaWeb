<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.security.interfaces.RSAKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<%@ page import = "com.selfedu.Word" %>
<%@ page import = "com.selfedu.WordMeaning" %>
<%@ page import = "com.selfedu.*" %>
<%--add --%>
<% 
	String action = request.getParameter("action");
	
	if("add".equals(action)){
		/*
		out.println("meanings:");
		String[] meaningValues = null;
		meaningValues = request.getParameterValues("meaning");
		for(String s:meaningValues)
			out.println(s + ",");
		out.print("</br>");
		int n = meaningValues.length;
		for(int i = 0; i < n; i++){
			out.println("samples of meaning" + (i + 1) + ":");
			//String meaningString = meaningValues[i];
			String sampleName = "meaning" + (i + 1) + "_sample";
			String[] sampleValues = request.getParameterValues(sampleName);
			for(String s:sampleValues){
				out.println(s + ",");
			}
			out.println("</br>");
		}
		*/
	
		String name = request.getParameter("name");
		String IPA_E = request.getParameter("IPA_E");
		String IPA_A = request.getParameter("IPA_A");
		String character = request.getParameter("character");
		
		String sql = null;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int word_id = 0, meaning_id = 0, sample_id = 0;
		
		int result = 0;
		
		ConnectDatabase connectDatabase = new ConnectDatabase();
		statement = connectDatabase.getStatement();
		
		//add word in table, get the id
		if(name.length() != 0){
			sql = "INSERT INTO words " + "(name, character) values " + "('" + name + "', '" + character + "')";
			result = statement.executeUpdate(sql);
			
			//get id
			sql = "SELECT * FROM words ORDER BY id DESC LIMIT 1";
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			word_id = resultSet.getInt("id");
		}
		//add IPAs
		if(!(IPA_E.isEmpty()&&IPA_A.isEmpty())){
			sql = "INSERT INTO IPAs (word_id, IPA_E, IPA_A) VALUES " + "('" + word_id + "','" + IPA_E + "','" + IPA_A +"')";
			statement.executeUpdate(sql);
		}
		
		//insert meaning in database, get the id
		String[] meaningValues = request.getParameterValues("meaning");
		int n = meaningValues.length;
		try{
			for(int i = 0; i < n; i++){
				String meaningString = meaningValues[i];
				String sampleName = "meaning" + (i + 1) + "_sample";
				String[] sampleValues = request.getParameterValues(sampleName);
				
				if(!meaningString.isEmpty()){
					sql = "INSERT INTO words_meanings (word_id, meaning) values " + "('" + word_id +"', '" + meaningString + "')";
					statement.executeUpdate(sql);
					sql = "SELECT * FROM words_meanings ORDER BY id DESC LIMIT 1";
					resultSet = statement.executeQuery(sql);
					resultSet.next();
					meaning_id = resultSet.getInt("id");
				}
				
				for(String s:sampleValues){
					sql = "INSERT INTO meaning_samples (meaning_id, sample) values " + "('" + meaning_id +"', '" + s + "')";
					statement.executeUpdate(sql);
					//sql = "SELECT * FROM meaning_samples ORDER BY id DESC LIMIT 1";
					//resultSet = statement.executeQuery(sql);
					//resultSet.next();
					//sample_id = resultSet.getInt("id");
				}
				out.println("</br>");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(resultSet != null)
				resultSet.close(); 
			if(statement != null) 
				statement.close();
			if(connection != null) 
				connection.close(); 
		}
		
		//add sample in table, get the id
		
		out.println("<html> <body>");
		out.println("executing: "+sql +"</br>");
		out.println("add " + result + "words, </br>");
		out.println("word id:" + word_id + "</br>" + "meaning id:" + meaning_id + "</br>" + "sample id:" + sample_id + "</br>");
		out.println("</body></html>");
		
		//request.setAttribute("word_id", word_id);
		//request.getRequestDispatcher("/WordDetails.jsp").forward(request, response);
	//end of add
	}else if("del".equals(action)){
	%>
	<%-- delete  --%>
	
	<% 
		String word_idString = request.getParameter("word_id");
		int word_id = Integer.parseInt(word_idString);

		String sql = "DELETE FROM words where id = " + word_id;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		
		//Class.forName("com.mysql.jdbc.Driver"); 
		//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		Class.forName("org.sqlite.JDBC");
		connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
		statement = connection.createStatement();
		//delete word
		statement.executeUpdate(sql);
		//delete IPAs
		sql = "DELETE FROM IPAs WHERE word_id = " + word_id;
		statement.executeUpdate(sql);
		//get the meaning id
		ArrayList<Integer> meaningIDs = new ArrayList<Integer>();
		resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
		while(resultSet.next()){
	int meaning_id = resultSet.getInt("id");
	meaningIDs.add(meaning_id);
		}
		if(meaningIDs.size() > 0){
	
	ArrayList<Integer> sampleIDs = new ArrayList<Integer>();
	for(int i = 0; i < meaningIDs.size(); i++){
		sql = "SELECT * FROM meaning_samples WHERE meaning_id = " + meaningIDs.get(i);
		resultSet = statement.executeQuery(sql);
		while(resultSet.next()){
			int sample_id = resultSet.getInt("id");
			sampleIDs.add(sample_id);
		}
	}
	if(sampleIDs.size()>0){
		out.println("delete samples:");
		for(int i = 0; i < sampleIDs.size(); i++){
			out.println(sampleIDs.get(i) + ", ");
			sql = "DELETE FROM meaning_samples WHERE id = " + sampleIDs.get(i);
			statement.executeUpdate(sql);
		}
		out.println("</br>");
	}
	
	//delete meanings
	out.println("delete meanings:");
	for(int i = 0; i < meaningIDs.size(); i++){
		out.println(meaningIDs.get(i) + ", ");
		sql = "DELETE FROM words_meanings WHERE id = " + meaningIDs.get(i);
		statement.executeUpdate(sql);
	}
	out.println("</br>");
		}
		
		if(resultSet != null)
	resultSet.close(); 
		if(statement != null) 
	statement.close();
		if(connection != null) 
	connection.close(); 
	//end of del	
	}else if("edit".equals(action)){
	%>
	<%--edit --%>
	<%
		try{
			String word_idString = request.getParameter("word_id");
			int word_id = Integer.parseInt(word_idString);
			
			/*
			out.println("word_id:" + word_idString + "</br>");
			String sql = "SELECT * FROM words WHERE id = " + word_id;
			
			Connection connection = null;
			Statement statement = null;
			ResultSet resultSet_word = null;
			ResultSet resultSet_meaning = null;
			ResultSet resultSet_sample = null;
			
			ConnectDatabase connectDatabase = new ConnectDatabase();
			statement = connectDatabase.getStatement();
			resultSet_word = statement.executeQuery(sql);
			
			Word word = new Word();
			if(resultSet_word.next()){
				word.name = resultSet_word.getString("name");
				word.character = resultSet_word.getString("character");
				
				request.setAttribute("word_id", word_idString);
				request.setAttribute("name", resultSet_word.getString("name"));
				
				sql = "SELECT * FROM IPAs WHERE word_id = " + word_id;
				resultSet_word = statement.executeQuery(sql);
				if(resultSet_word.next()){
					ArrayList<String> ipaArrayList = new ArrayList<String>();
					String ipaE = resultSet_word.getString("IPA_E");
					String ipaA = resultSet_word.getString("IPA_A");
					ipaArrayList.add(ipaE);
					ipaArrayList.add(ipaA);
					//word.IPAs = new ArrayList<String>();
					word.IPAs = ipaArrayList;
				//request.setAttribute("IPA_E", resultSet_word.getString("IPA_E"));
				//request.setAttribute("IPA_A", resultSet_word.getString("IPA_A"));
				//request.setAttribute("meaning", resultSet.getString("meaning"));
				//request.setAttribute("sample", resultSet.getString("sample"));
				}else{
					out.println("no record found</br>");
				}
				//add meanings
				sql = "SELECT * FROM words_meanings WHERE word_id = " + word_id;
				resultSet_meaning = statement.executeQuery(sql);
				out.println("sql:" + sql + "</br>");
				if(resultSet_meaning.next()){
					WordMeaning meaning = new WordMeaning();
					meaning.id = Integer.parseInt(resultSet_meaning.getString("id"));
					meaning.word_id = Integer.parseInt(resultSet_meaning.getString("word_id"));
					meaning.meaning = resultSet_meaning.getString("meaning");
					word.meanings.add(meaning);
			
					//add samples of this meaning
					sql = "SELECT * FROM meaning_samples WHERE meaning_id = " + meaning.id;
					resultSet_sample = statement.executeQuery(sql);
					if(resultSet_sample.next()){
						MeaningSample sample = new MeaningSample();
						sample.id = Integer.parseInt(resultSet_sample.getString("id"));
						sample.meaning_id = Integer.parseInt(resultSet_sample.getString("meaning_id"));
						sample.sample = resultSet_sample.getString("sample");
						meaning.samplesArrayList.add(sample);
					}
					request.setAttribute("meaning", resultSet_meaning.getString("meaning"));
				}else{
					out.println("no meaning found</br>");
				}
				
				*/
				
				Connection connection = null;
				Statement statement = null;
				ResultSet resultSet = null;
				
				ConnectDatabase connectDatabase = new ConnectDatabase();
				Word word = connectDatabase.getWord(word_id);
				
				request.setAttribute("word", word);
				
				
				if(resultSet != null)
					resultSet.close(); 
				if(statement != null) 
					statement.close();
				if(connection != null) 
					connection.close(); 
				//forward to edit
				request.setAttribute("action", action);
				request.getRequestDispatcher("/addWord.jsp").forward(request, response);
			
			}catch(IOException e){
				e.printStackTrace();
			}catch(SQLException e2){
				e2.printStackTrace();
			}finally{
		}
		%>
		<%--update --%>
		<%
		}else if("Save".equals(action)){
			String word_idString = request.getParameter("word_id");
			int word_id = Integer.parseInt(word_idString);
			String name = request.getParameter("name");
			String IPA_E = request.getParameter("IPA_E");
			String IPA_A = request.getParameter("IPA_A");
			String character = request.getParameter("character");
			
			
			String sql = null;
			
			Connection connection = null;
			Statement statement = null;
			ResultSet resultSet = null;
			int meaning_id = 0, sample_id = 0;
			
			int result = 0;
			
			ConnectDatabase connectDatabase = new ConnectDatabase();
			statement = connectDatabase.getStatement();
			
			//update word in table
			
			if(name.length() != 0){
				sql = "UPDATE words SET name = " + name + ", character = " + character + "WHERE id = " + word_id;
				result = statement.executeUpdate(sql);
				out.println(sql);
			}
			out.println(sql);
			//update IPAs
			if(!(IPA_E.isEmpty()&&IPA_A.isEmpty())){
				sql = "UPDATE IPAs SET IPA_E = " + IPA_E + ", IPA_A = " + IPA_A +"WHERE word_id = " + word_id;
				statement.executeUpdate(sql);
			}
			//get the meaning ids and new values
			String[] meaningIdStrings = request.getParameterValues("meaningId");
			String[] meaningValueStrings = request.getParameterValues("meaning");
			if(meaningIdStrings.length != meaningValueStrings.length){
				out.println("id and meaning length not equal");
			}else{
				for(int i = 0; i < meaningIdStrings.length; i++){
					sql= "UPDATE words_meanings SET meaning = " + meaningValueStrings[i] + "WHERE id = " + meaningIdStrings[i];
					statement.executeUpdate(sql);
				}
			}
			//update sample
			String[] sampleIdStrings = request.getParameterValues("sampleId");
			ArrayList<String> sampleValuesArrayList = new ArrayList<String>();
			//get samples of every meaning, add it to a list
			for(int i = 0; i < meaningValueStrings.length; i++){
				String meaningString = meaningValueStrings[i];
				String sampleName = "meaning" + (i + 1) + "_sample";
				String[] sampleValues = request.getParameterValues(sampleName);
				for(String s : sampleValues){
					sampleValuesArrayList.add(s);
				}
			}
			if(sampleIdStrings.length != sampleValuesArrayList.size()){
				out.println("sample not equal");
			}else{
				for(int i = 0; i < sampleIdStrings.length; i++){
					sql = "UPDATE meaning_samples SET sample = " + sampleValuesArrayList.get(i) + "WHERE id = " + sampleIdStrings[i];
				}
			}
				if(resultSet != null)
					resultSet.close(); 
				if(statement != null) 
					statement.close();
				if(connection != null) 
					connection.close(); 
		
		}else if("addMeaning".equals(action)){
			String word_idString = request.getParameter("word_id");
			
			int word_id = Integer.parseInt(word_idString);
			String meaning = request.getParameter("meaning");
			int meaning_id = 0;
			
			Connection connection = null;
			Statement statement = null;
			ResultSet resultSet = null;
			String sql = "INSERT INTO words_meanings (word_id, meaning) VALUES ('" + word_id + "', '" + meaning + "')";
			
			//Class.forName("com.mysql.jdbc.Driver"); 
			//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			Class.forName("org.sqlite.JDBC");
			connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
			statement = connection.createStatement();
			
			//statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			//resultSet = statement.getGeneratedKeys();
			statement.executeUpdate(sql);
			sql = "SELECT * FROM words_meanings ORDER BY id desc LIMIT 1";
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			meaning_id = resultSet.getInt("id");
			out.println("meaning added, id:" + meaning_id + "</br>");
			
			if(resultSet != null)
		resultSet.close(); 
			if(statement != null) 
		statement.close();
			if(connection != null) 
		connection.close(); 
		}else if("addSample".equals(action)){
			String meaning_idString = request.getParameter("meaning_id");
			int meaning_id = Integer.parseInt(meaning_idString);
			String sample = request.getParameter("sample");
			int sample_id = 0;
			
			Connection connection = null;
			Statement statement = null;
			ResultSet resultSet = null;
			String sql = "INSERT INTO meaning_samples (meaning_id, sample) VALUES ('" + meaning_id + "', '" + sample + "')";
			
			//Class.forName("com.mysql.jdbc.Driver"); 
			//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
			try{
		ConnectDatabase connectDatabase = new ConnectDatabase();
		statement = connectDatabase.getStatement();
		
		//statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
		//resultSet = statement.getGeneratedKeys();
		
		statement.executeUpdate(sql);
		sql = "SELECT * FROM meaning_samples ORDER BY id DESC LIMIT 1";
		resultSet = statement.executeQuery(sql);
		if(resultSet.next()!=false){
			sample_id = resultSet.getInt("id");
			out.println("meaning added, id:" + sample_id + "</br>");
		}else{
			out.println("nothing added");
		}
		if(resultSet != null)
		resultSet.close(); 
		if(statement != null) 
			statement.close();
		if(connection != null) 
			connection.close();
			}catch(SQLException e){
		e.printStackTrace();
		}
		if(resultSet != null)
			resultSet.close(); 
		if(statement != null) 
			statement.close();
		if(connection != null) 
			connection.close();
			 
		}
		out.println("</br>end of page");
	%>
