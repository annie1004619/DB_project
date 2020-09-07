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
<%
request.setCharacterEncoding("euc-kr");

String session_id = (String)session.getAttribute("user");
String userPassword = request.getParameter("userPassword");


Connection myConn = null;
Statement stmt = null;
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616204";
String password = "ss2";

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, password);
	stmt = myConn.createStatement();
	
	String mySQL ="update students set s_pwd=\'" + userPassword + 
			"\' where s_id=\'" + session_id + "\'";

	int myResultSet = stmt.executeUpdate(mySQL);
	
	stmt.close();
	myConn.close();	
%>

<script>
alert("수정 되었습니다.");
location.href="main.jsp";
</script>

<%
} catch(SQLException ex) {
	String sMessage;
	if(ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다.";
	else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
	else sMessage = "잠시 후 다시 시도하십시오.";

%>
<script>
alert('<%=sMessage%>');
location.href="main.jsp";
</script>
<% } %>

</body>
</html>