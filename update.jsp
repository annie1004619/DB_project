<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>
<%
String userID = request.getParameter("userID");
String userPassword = request.getParameter("userPassword");

Connection myConn = null;
ResultSet myResultSet = null;
Statement stmt = null;
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616204";
String password = "ss2";

if(session_id==null) response.sendRedirect("login.jsp");

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, password);
	String mySQL = "select s_id, s_pwd, s_major from students where s_id=\'" + session_id + "\'";
	stmt = myConn.createStatement();
	myResultSet = stmt.executeQuery(mySQL);
	if(myResultSet.next()) {		
		String s_id = myResultSet.getString("s_id");
		String s_pwd = myResultSet.getString("s_pwd");
		String s_major = myResultSet.getString("s_major");
%>
		<table width="75%" align="center" bgcolor="#FFFF99" border>
			<tr><td><div align="center">아이디, 비밀번호, 전공을 입력하여 수정하세요</div></td></tr>
		</table>
		<table width="75%" align="center" border>
		<form method="post" action="update_verify.jsp">
			<tr>
			<td><div align="center">아이디</div></td>
			<td><div align="center"><%=s_id%></div></td>
			</tr>
			<tr>
			<td><div align="center">패스워드</div></td>
			<td><div align="center"><input type="text" name="userPassword" value="<%=s_pwd%>"></div></td>
			</tr>
			<tr>
			<td><div align="center">전공</div></td>
			<td><div align="center"><%=s_major%></div></td>
			</tr>
			<tr>
				<td colspan=2><div align="center">
				<input type="submit" name="Submit" value="수정">
				<input type="reset" value="취소">
				</div></td>
			</tr>
		</form>
		</table>
<%

	} else {
		response.sendRedirect("login.jsp");
	}
	
	myResultSet.close();
	stmt.close();
	myConn.close();	
} catch (ClassNotFoundException e) {
	System.out.println("jdbc driver 로딩 실패");
} catch (SQLException e) {
	System.out.println(e);
	System.out.println("오라클 연결 실패");
}
%>

</body>
</html>