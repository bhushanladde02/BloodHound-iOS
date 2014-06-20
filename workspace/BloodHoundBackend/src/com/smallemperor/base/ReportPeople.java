package com.smallemperor.base;

import java.io.IOException;
import java.util.Iterator;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.smallemperor.db.Lost;
import com.smallemperor.db.LostDAO;

/**
 * Servlet implementation class ReportPeople -- Sets isReported ( col7 ) flag
 * true or false
 */

public class ReportPeople extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportPeople() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try{
		String jsonData = (String) request.getParameter("jsonData");
		System.out.println("Json data is : " + jsonData);

		LostDAO lostDAO = new LostDAO();

		JsonElement jelement = new JsonParser().parse(jsonData);
		JsonObject jobject = jelement.getAsJsonObject();

		Set<Entry<String, JsonElement>> set = jobject.entrySet();

		Iterator<Entry<String, JsonElement>> iterator = set.iterator();
		while (iterator.hasNext()) {
			Entry<String, JsonElement> entry = iterator.next();
			String beaconId = entry.getKey();
			String flag = entry.getValue().getAsString();

			Lost lost = new Lost();
			lost.setBeaconId(beaconId);
			lost.setCol7(flag);
			lostDAO.updateReportedBeacon(lost);
		}
		}catch (Exception e) {
			// TODO: handle exception
			response.getWriter().print("Something went wrong, Please come back letter");
			e.printStackTrace();
		}
	}

}
