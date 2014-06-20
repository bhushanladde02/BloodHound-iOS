package com.smallemperor.cache;

import java.util.HashMap;

import com.smallemperor.db.Lost;

public class Cache {
	public static HashMap<String,Lost> lostMap = new HashMap<String, Lost>(); 
	
	public static void main(String[] args) {
		lostMap.put("1",new Lost());
	}
}
