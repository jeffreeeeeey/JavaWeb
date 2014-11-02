package com.selfedu;

import java.sql.*;

public class ConnectDatabase {
	public ConnectDatabase(){
		
	}
	public Statement getStatement() throws ClassNotFoundException{
		Connection connection = null;
		Statement statement = null;
		SelfSettings settings = new SelfSettings();
		String jdbcString = settings.SQLiteJDBC;
		String databaseURL = settings.SQLiteDatabaseURL;
		try {
			Class.forName(jdbcString);
			connection = DriverManager.getConnection(databaseURL);
			statement = connection.createStatement();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return statement;
	}
	
	public Word getWord(int word_id) throws ClassNotFoundException{
		Word word = new Word();
		try {
			Connection connection = null;
			ResultSet resultSet = null;
			
			Statement statement = getStatement();
			resultSet = statement.executeQuery("SELECT * FROM words WHERE id = " + word_id);
			resultSet.next();
			String name = resultSet.getString("name");
			String character = resultSet.getString("character");
			word.name = name;
			word.character = character;
			resultSet = statement.executeQuery("SELECT * FROM IPAs WHERE word_id = " + word_id);
			if(resultSet.next()){
				String IPA_E = resultSet.getString("IPA_E");
				String IPA_A = resultSet.getString("IPA_A");
				word.IPAs.add(IPA_E);
				word.IPAs.add(IPA_A);
			}
			// Get the meanings
			resultSet = statement.executeQuery("SELECT * FROM words_meanings WHERE word_id = " + word_id);
			while(resultSet.next()){
				WordMeaning wordMeaning = new WordMeaning();
				int meaning_id = resultSet.getInt("id");
				String meaning = resultSet.getString("meaning");
				wordMeaning.id = meaning_id;
				wordMeaning.meaning = meaning;
				word.meanings.add(wordMeaning);
				
				//get sample by meaning id
				/*
				resultSet_sample = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
				resultSet_sample.next();
				String sample = resultSet_sample.getString("sample");
				out.println(sample + "</br>");
				*/
			}
				
			for(int i = 0; i < word.meanings.size(); i++){
				WordMeaning wordMeaning = word.meanings.get(i);
				int meaning_id = wordMeaning.id;
				String meaning = wordMeaning.meaning;
				
				//get sample of this meaning
				resultSet = statement.executeQuery("SELECT * FROM meaning_samples WHERE meaning_id = " + meaning_id);
				
				while(resultSet.next()){
					MeaningSample meaningSample = new MeaningSample();
					int id = resultSet.getInt("id");
					String sample = resultSet.getString("sample");
					meaningSample.id = id;
					meaningSample.sample = sample;
					
					wordMeaning.samplesArrayList.add(meaningSample);
				}
			}

			if(statement != null)
				statement.close();
			if(resultSet != null)
				resultSet.close();
			if(connection != null)
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return word;
	}
}
