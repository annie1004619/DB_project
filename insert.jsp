<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 입력</title>
</head>
<body>
<%@include file="top.jsp" %>
<%if (session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>교시</th><th>분반</th><th>과목명</th><th>학점</th><th>최대 수강인원</th><th>수강신청</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL="";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616204";
String password = "ss2";

try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,password);
   stmt = myConn.createStatement();
   
   mySQL = "select c.c_id, c.c_id_no, c.c_unit, c.c_subject, t.t_time, t.t_max from course c, teach t where c.c_id = t.c_id and c.c_id_no = t.c_id_no and c.c_semester = Date2EnrollSemester(SYSDATE)";
   myResultSet = stmt.executeQuery(mySQL);
   if(myResultSet != null){
      while(myResultSet.next()){
         String c_id = myResultSet.getString("c_id");
         int c_id_no = myResultSet.getInt("c_id_no");
         String c_subject = myResultSet.getString("c_subject");
         int c_unit = myResultSet.getInt("c_unit");
         int t_time = myResultSet.getInt("t_time");
         int t_max = myResultSet.getInt("t_max");
      %>
      <tr>
      <td align="center"><%=c_id %></td>
      <td align="center"><%=t_time %></td>
      <td align="center"><%=c_id_no %></td>
      <td align="center"><%=c_subject %></td>
      <td align="center"><%=c_unit %></td>
      <td align="center"><%=t_max %></td>
      <td align="center"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>&t_time=<%=t_time%>">신청</a></td>
      </tr>
      <% 
      }
   }
   
   myResultSet.close();
   stmt.close();
   myConn.close();
}catch(SQLException ex){
   System.err.println("SQLExcemption:"+ex.getMessage());
   }
   
   

%>
</table>
</body>
</html>