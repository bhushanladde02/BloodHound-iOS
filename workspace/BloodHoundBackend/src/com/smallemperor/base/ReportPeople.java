package com.smallemperor.base;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smallemperor.db.Lost;
import com.smallemperor.db.LostDAO;

/**
 * Servlet implementation class ReportPeople 
 *  -- Sets isReported ( col7 ) flag  true or false
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String jsonData = (String) request.getParameter("jsonData");
		System.out.println("Json data is : "+jsonData);
		
		LostDAO lostDAO = new LostDAO();
		Lost lost = new Lost();
		lost.setBeaconId("\"ShashankKarkare\"");
		lost.setCol7("true");
		lostDAO.updateReportedBeacon(lost);
	}
	
	/*public static void main(String[] args) {
		LostDAO lostDAO = new LostDAO();
		Lost lost = new Lost();
		lost.setBeaconId("\"ShashankKarkare\"");
		lost.setCol7("true");
		lostDAO.updateReportedBeacon(lost);
	}*/
}
