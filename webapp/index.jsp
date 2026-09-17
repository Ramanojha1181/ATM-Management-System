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

        if (conn != null) {
            try {
                String query = "SELECT ATM_Number, ATM_Pin FROM user_details";
                ps = conn.prepareStatement(query);
                
                rs = ps.executeQuery();
				int atm_number=0 ;
				int atm_pin=0;
		
			while(rs.next()){
				atm_number = rs.getInt("ATM_Number");
				atm_pin = rs.getInt("ATM_Pin");
		}
			int number = Integer.parseInt(request.getParameter("atm_number"));
			int pin = Integer.parseInt(request.getParameter("atm_pin"));
	 
  		if  (number == atm_number){
			if (pin == atm_pin){
				%> 
				<script>window.location.href="HomePage.html";</script>
<%
	}else{
		out.print("Atmpin not match");
%>	    <script>window.location.href="index.html";</script>  <%

	}
}else{
		out.print("Atm number not matcj");
%>		<script>window.location.href="HomePage.html";</script><%
	}
	
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
