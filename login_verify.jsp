<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

Connection myConn = null;
PreparedStatement pstmt = null;
ResultSet myResultSet = null;
String mySQL="";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616204";
String password = "ss2";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, password);
	pstmt = myConn.prepareStatement
			("select s_id from students where s_id= ? and s_pwd= ? ");
			pstmt.setString(1,userID);
			pstmt.setString(2,userPassword);

	myResultSet = pstmt.executeQuery();

	if(myResultSet.next()) {
		session.setAttribute("user", myResultSet.getString("s_id"));
		response.sendRedirect("main.jsp");
	} else {
		response.sendRedirect("login.jsp");
	}
	
	myResultSet.close();
	pstmt.close();
	myConn.close();	
} catch (ClassNotFoundException e) {
	System.out.println("jdbc driver 로딩 실패");
} catch (SQLException e) {
	System.out.println(e);
	System.out.println("오라클 연결 실패");
}
%>