package com.atm;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.Timestamp;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter; // 1. Naya import formatter ke liye
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		
		// 1. HTML se data fetch karna (String formats mein safely)
		String name = request.getParameter("username");
//		String dateTimeStr = request.getParameter("datetime");
		String gender = request.getParameter("gender");
//		String dob = request.getParameter("birthdate"); 
		String Address = request.getParameter("address"); 
		
		// Mobile aur ATM Number ko String mein lein taaki size limit ki dikkat na ho
		int Mo_Number = Integer.parseInt(request.getParameter("mo_number"));
		int Pin = Integer.parseInt(request.getParameter("pin"));
		int ATM_Number = Integer.parseInt(request.getParameter("atm_number"));
		int Amount = Integer.parseInt(request.getParameter("amount"));
		int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
		
		// Database Credentials
		String dbUrl = "jdbc:mysql://localhost:3306/atm_management_system";
		String dbUser = "root";
		String dbPassword = "root";
		
		Connection conn = null;
		PreparedStatement ps = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			
			String sql = "Insert into user_details(name, m_numbers, gender, address, ATM_Number, Account_Number, ATM_Pin, Amount) values ( ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, name);
//			ps.setTimestamp(2, sqlTimestamp);
			
			// Database columns types update support (String bhejna safe hai VARCHAR ke liye)
			ps.setInt(2, Mo_Number); 
//			ps.setString(4, dob);
			ps.setString(3, gender);
			ps.setString(4, Address);
			ps.setInt(5, ATM_Number); 
			ps.setInt(6, accountNumber);
			ps.setInt(7, Pin);
			ps.setInt(8, Amount);
			
			int result = ps.executeUpdate();
			if(result > 0) {
				System.out.println("Data successfully saved to MySQL Database!");
				response.getWriter().println("<h3>Registration Successful!</h3>");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
		} 
	}
}
