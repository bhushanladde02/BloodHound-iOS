package com.smallemperor.model;

import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Parser {
	public static void main(String[] args) {
		 String jsonString = "{\"1234\" : true,\"200\" : false}";
		 
		 JsonElement jelement = new JsonParser().parse(jsonString);
		   JsonObject  jobject = jelement.getAsJsonObject();
		    
		   Set<Entry<String, JsonElement>> set = jobject.entrySet();
		   
		   Iterator<Entry<String, JsonElement>> iterator = set.iterator();
		   while(iterator.hasNext()){
			   Entry<String, JsonElement> entry = iterator.next();
			   String beaconId = entry.getKey();
			   String flag = entry.getValue().getAsString();
			   
		   }
	}
}
