package com.selfedu;

import java.util.ArrayList;

public class WordMeaning {
	public WordMeaning(){
		this.samplesArrayList = new ArrayList<MeaningSample>();
	}
	public int id;
	public int word_id;
	public String meaning;
	public ArrayList<MeaningSample> samplesArrayList;
}
