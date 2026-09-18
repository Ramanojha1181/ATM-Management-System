<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="database.jsp" %>
<!DOCTYPE html>
<html lang="en">

     <%
        PreparedStatement ps = null;
        ResultSet rs = null;

			int bank_Amount=0 ;
			Object atmObj = session.getAttribute("ATM_Number");
	        int atmNumber = (Integer) atmObj;

        if (conn != null) {
            try {
                String query = "SELECT Amount FROM user_details where ATM_Number = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, atmNumber);
                
                rs = ps.executeQuery();
		
			while(rs.next()){
				bank_Amount = rs.getInt("Amount");
		}
			int amount = Integer.parseInt(request.getParameter("amount"));
			
		if(amount >0){
			bank_Amount += amount;
		}else{
			out.print("Value not valid");
		}
		
		String query2 = "UPDATE user_details SET Amount = ? WHERE ATM_Number = ?";
        ps = conn.prepareStatement(query2);
        
        ps.setInt(1, bank_Amount);
        ps.setInt(2, atmNumber);
        
     //   rs = ps.executeUpdate();
	
     // FIX: rs की जगह 'int rowsAffected' का यूज़ करें
        int rowsAffected = ps.executeUpdate();         
     
        response.sendRedirect("HomePage.html");
        
	}catch(SQLException e){
		out.print("<p style='color:red;'>Data fetch error: " + e.getMessage() + "</p>");
	}finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
} else {
		out.print("Database not connected");
}
		    
      
	%>
    
</body>
</html>
