package com.selfedu;

public class OperateString {
	public static String filterSQL(String s){
		if (s.isEmpty()) {
			return null;
		}else {
			if (s.contains("'")) {
				s = s.replace("'", "''");
				return s;
			}else {
				return s;
			}
		}
	}//end of filterSQL  
	public static String jsOutputString(String s){
		if (s.isEmpty()) {
			return null;
		}else{
			if (s.contains("'")) {
				s = s.replace("'", "\\'");
				return s;
			}else {
				return s;
			}
		}
		
	}
}
