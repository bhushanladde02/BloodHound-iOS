package com.smallemperor.base;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smallemperor.db.Lost;
import com.smallemperor.db.LostDAO;

/**
 * Servlet implementation class FindPeople
 */

public class FindPeople extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private LostDAO lostDAO;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPeople() {
        super();
        lostDAO = new LostDAO();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

		/*String beaconId = (String) request.getParameter("deviceID");
		System.out.println(beaconId);
		Gson gson = new Gson();
		 LostDAO lostDAO = new LostDAO();
		Lost lostObject = lostDAO.getLostDetails(beaconId);
		System.out.println(lostObject.getAddress());
		System.out.println(gson.toJson(lostObject));
		response.getWriter().print(gson.toJson((lostObject)));*/
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String beaconId = (String) request.getParameter("deviceID");
		System.out.println(beaconId);
		Gson gson = new Gson();	
		Lost lostObject = lostDAO.getLostDetails(beaconId);
		System.out.println(lostObject.getAddress());
		System.out.println(gson.toJson(lostObject));
		response.getWriter().print(gson.toJson((lostObject)));
		
	}

}
