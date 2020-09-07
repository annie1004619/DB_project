<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 삭제</title>
</head>
<body>
<%
String s_id = (String)session.getAttribute("user");
String c_id = request.getParameter("c_id");
int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));

Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL="";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1616204";
String passwd="ss2";
String dbdriver="oracle.jdbc.driver.OracleDriver";

try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,passwd);
   stmt = myConn.createStatement();
   mySQL="DELETE FROM enroll WHERE s_id='"+s_id+"' and c_id='"+c_id+"' and c_id_no="+c_id_no+"";
   myResultSet = stmt.executeQuery(mySQL);
   
   myResultSet.close();
   stmt.close();
   myConn.close();
   
}catch(SQLException ex){
   System.err.println("SQLExcemption:"+ex.getMessage());

}

%>

<script>
alert("수강 취소 하셨습니다.");
location.href="delete.jsp";
</script>


</body>
</html>