<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ include file="database.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amount</title>
    <style>
        body{
            /* text-align: center; */
            background-color: rgba(47, 19, 235, 0.222);
            /* margin-top: 100px; */
            
        }
        marquee{
            font-size: 80px;
        }
        h1{
            height: fit-content;
            /* width: 50px; */
            text-align: center;
            border-radius: 10px;
            padding: 10px;
            border: solid 2px black;
            background-color:  rgb(35, 35, 210);
            color: white;
            margin-bottom: 50px;
        }
        div{
            margin-left: 520px;
        }
        section{
            margin: 20px;

        }
    </style>
</head>
<body>
<%
        PreparedStatement ps = null;
        ResultSet rs = null;

			int Ac_Number = 0;
			int Amount = 0;
			Object atmObj = session.getAttribute("ATM_Number");
	        int atmNumber = (Integer) atmObj;

        if (conn != null) {
            try {
                String query = "SELECT * FROM user_details where ATM_Number = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, atmNumber);
                
                rs = ps.executeQuery();
		
			while(rs.next()){
				Ac_Number = rs.getInt("Account_Number");
				Amount= rs.getInt("Amount");
				
		}			
			%>
    <marquee scrollamount="30">This banking system is fully secure don't worry your money is safe</marquee>
    <h1>ATM Management System</h1>
    <div>
    <section>Account No. :  <%= Ac_Number %> </section>
    <section>Account balance :  <%= Amount %> </section>
    </div>
		<%
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