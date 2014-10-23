<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.security.interfaces.RSAKey"%>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "com.selfedu.ConnectDatabase" %>
<%
	String action = request.getParameter("action");
	
	if("add".equals(action)){
		String name = request.getParameter("name");
		String IPA_E = request.getParameter("IPA_E");
		String IPA_A = request.getParameter("IPA_A");
		String meaning = request.getParameter("meaning");
		String sample = request.getParameter("sample");
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
			sql = "INSERT INTO words " + "(name) values " + "('" + name +"')";
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
		
		//add meaning in table, get the id
		if(!meaning.isEmpty()){
	
			sql = "INSERT INTO words_meanings (word_id, meaning) values " + "('" + word_id +"', '" + meaning + "')";
			statement.executeUpdate(sql);
			sql = "SELECT * FROM words_meanings ORDER BY id DESC LIMIT 1";
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			meaning_id = resultSet.getInt("id");
		}
		
		//add sample in table, get the id
		if(!sample.isEmpty()){
			sql = "INSERT INTO meaning_samples (meaning_id, sample) values " + "('" + meaning_id +"', '" + sample + "')";
			statement.executeUpdate(sql);
			sql = "SELECT * FROM meaning_samples ORDER BY id DESC LIMIT 1";
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			sample_id = resultSet.getInt("id");
		}
		out.println("<html> <body>");
		out.println("executing: "+sql +"</br>");
		out.println("add " + result + "words, </br>");
		out.println("word id:" + word_id + "</br>" + "meaning id:" + meaning_id + "</br>" + "sample id:" + sample_id + "</br>");
		out.println("</body></html>");
		
		if(resultSet != null)
			resultSet.close(); 
		if(statement != null) 
			statement.close();
		if(connection != null) 
			connection.close(); 
	//end of add
	}else if("del".equals(action)){
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
		String word_idString = request.getParameter("word_id");
		int word_id = Integer.parseInt(word_idString);
		String sql = "SELECT * FROM words WHERE id = " + word_id;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet_word = null;
		ResultSet resultSet_meaning = null;
		ResultSet resultSet_sample = null;
		
		ConnectDatabase connectDatabase = new ConnectDatabase();
		statement = connectDatabase.getStatement();
		resultSet_word = statement.executeQuery(sql);
		
		if(resultSet_word.next()){
			request.setAttribute("word_id", word_id);
			request.setAttribute("name", resultSet_word.getString("name"));
			//request.setAttribute("IPA_E", resultSet_word.getString("IPA_E"));
			//request.setAttribute("IPA_A", resultSet_word.getString("IPA_A"));
			//request.setAttribute("meaning", resultSet.getString("meaning"));
			//request.setAttribute("sample", resultSet.getString("sample"));
			
			
		}else{
			out.println("no record found");
		}
		
		sql = "SELECT * FROM words_meanings WHERE word_id = " + word_id;
		resultSet_meaning = statement.executeQuery(sql);
		if(resultSet_meaning.next()){
			request.setAttribute("meaning", resultSet_meaning.getString("meaning"));
			request.setAttribute("action", action);
			//forward to edit
			request.getRequestDispatcher("/addWord.jsp").forward(request, response);
		}
		
		
		if(resultSet_word != null)
			resultSet_word.close(); 
		if(resultSet_meaning != null)
			resultSet_word.close(); 
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
	Class.forName("org.sqlite.JDBC");
	connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
	statement = connection.createStatement();
	
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
	if(resultSet != null)
		resultSet.close(); 
	if(statement != null) 
		statement.close();
	if(connection != null) 
		connection.close();
		}
		 
	}
	out.println("</br>end of page");
%>
