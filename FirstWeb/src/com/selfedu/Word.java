package com.selfedu;

import java.util.ArrayList;

public class Word {
	public Word(){
		this.IPAs = new ArrayList<String>();
		this.meanings = new ArrayList<WordMeaning>();
	}
	
	public int id;
	public String name;
	public String character;
	public ArrayList<String> IPAs;
	public ArrayList<WordMeaning> meanings;
}
