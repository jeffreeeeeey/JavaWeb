<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>
<%! 
	public String forSQL(String sql) {
		return sql.replace("'", "\\'");
	}
%>
<%
	String action = request.getParameter("action");
	
	
	if("add".equals(action)){
		String name = request.getParameter("name");
		String IPA_E = request.getParameter("IPA_E");
		String IPA_A = request.getParameter("IPA_A");
		String meaning = request.getParameter("meaning");
		String sample = request.getParameter("sample");
		
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		int word_id = 0, meaning_id = 0, sample_id = 0;
		
		int result = 0;
		
		//Class.forName("com.mysql.jdbc.Driver"); 
		//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		Class.forName("org.sqlite.JDBC");
		connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
		statement = connection.createStatement();
		
		//add word in table, get the id
		String sql = "INSERT INTO words " + "(name, IPA_E, IPA_A) values " + "('" + name +"','" + IPA_E + "', '" + IPA_A +"')";
		//result = statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
		//resultSet = statement.getGeneratedKeys();
		result = statement.executeUpdate(sql);
		//get id
		sql = "SELECT * FROM words ORDER BY id DESC LIMIT 1";
		resultSet = statement.executeQuery(sql);
		resultSet.next();
		word_id = resultSet.getInt("id");
		
		//add meaning in table, get the id
		if(meaning.length() != 0){
			sql = "INSERT INTO words_meanings (word_id, meaning) values " + "('" + word_id +"', '" + meaning + "')";
			statement.executeUpdate(sql);
			sql = "SELECT * FROM words_meanings ORDER BY id DESC LIMIT 1";
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			meaning_id = resultSet.getInt("id");
		}
		
		//add sample in table, get the id
		if(sample.length() != 0){
			sql = "INSERT INTO meaning_samples (meaning_id, sample) value " + "('" + meaning_id +"', '" + sample + "')";
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
	}else if("del".equals(action)){
		String word_id = request.getParameter("word_id");
		if(word_id == null){
			out.println("no word is selected");
			return;
		}
		String sql = "DELETE FROM words where id = " + word_id;
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		
		//Class.forName("com.mysql.jdbc.Driver"); 
		//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		Class.forName("org.sqlite.JDBC");
		connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
		
		statement = connection.createStatement();
		resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
		
		
		
	}else if("edit".equals(action)){
		String id = request.getParameter("id");
		String sql = "SELECT * FORM words WHERE id = " + id;
		
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
		Statement statement1 = null;
		ResultSet resultSet = null;
		String sql = "INSERT INTO meaning_samples (meaning_id, sample) VALUES ('" + meaning_id + "', '" + sample + "')";
		
		//Class.forName("com.mysql.jdbc.Driver"); 
		//connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/wordsDB","root", "123456"); 
		Class.forName("org.sqlite.JDBC");
		connection =DriverManager.getConnection("jdbc:sqlite:E:/360Clouds/360Clouds/Words/WordsSQLite.db");
		statement1 = connection.createStatement();
		
		//statement.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
		//resultSet = statement.getGeneratedKeys();
		
		statement1.executeUpdate(sql);
		//statement.close();
		//statement = connection.createStatement();
		sql = "SELECT * FROM meaning_samples ORDER BY id DESC LIMIT 1";
		statement1.executeQuery(sql);
		if(resultSet.next()){
			sample_id = resultSet.getInt("id");
			out.println("meaning added, id:" + sample_id + "</br>");
		}else{
			out.print("not added");
		}
		if(resultSet != null)
				resultSet.close(); 
		if(statement1 != null) 
			statement1.close();
		if(connection != null) 
			connection.close(); 
	}
	out.println("</br>end of page");
 %>
