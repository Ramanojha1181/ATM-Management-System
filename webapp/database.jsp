<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>


<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Status</title>
</head>
<body>

<%
    // 1. डेटाबेस की क्रेडेंशियल्स (अपने हिसाब से बदलें)
    String url = "jdbc:mysql://localhost:3306/atm_management_system"; // यहाँ अपने DB का नाम डालें
    String dbUser = "root";                                         // MySQL का यूजरनेम
    String dbPassword = "root";                                 // MySQL का पासवर्ड

    Connection conn = null;

    try {
        // 2. MySQL JDBC Driver को लोड करना
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 3. कनेक्शन स्थापित करना
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        if (conn != null) {
            out.print("<h3 style='color: green;'>✔ Database Connection Successful!</h3>");
        }
    } 
    catch (ClassNotFoundException e) {
        out.print("<h3 style='color: red;'>❌ JDBC Driver missing! Add MySQL Connector JAR file.</h3>");
        e.printStackTrace();
    } 
    catch (SQLException e) {
        out.print("<h3 style='color: red;'>❌ Connection Failed! Check URL, Username, or Password.</h3>");
        out.print("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } 

%>

</body>
</html>
