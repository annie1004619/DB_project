<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.Calendar, java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 삭제</title>
</head>
<body>
<%@include file="top.jsp" %>
<%if (session_id == null)response.sendRedirect("login.jsp"); %>
<table width="75%" align="center" height="100%">
<br>
<tr> <td align="center"><%=session_id%>님 수강신청 결과</td> </tr>
</table>
<table width="75%" align="center" border>
<br>
<tr><th>교시</th><th>과목번호</th><th>과목명</th><th>분반</th><th>학점</th><th>장소</th><th>삭제</th></tr>
<%
String s_id = (String)session.getAttribute("user");

Connection myConn = null;
CallableStatement cstmt = null;
ResultSet myResultSet = null;
String mySQL="";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1616204";
String passwd="ss2";
String dbdriver="oracle.jdbc.driver.OracleDriver";


mySQL="{call SelectTimeTable(?,?,?,?)}";

int nSum = 0;

Calendar cal = Calendar.getInstance();
int nYear = cal.get(Calendar.YEAR);

try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,passwd);
   cstmt = myConn.prepareCall("{? = call Date2EnrollSemester(?)}");
   cstmt.registerOutParameter(1 , java.sql.Types.INTEGER);
   cstmt.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
   cstmt.executeQuery();
   
   int nSemester = cstmt.getInt(1);
   
   cstmt = myConn.prepareCall(mySQL);
      
   cstmt.setString(1, s_id);
   cstmt.setInt(2, nYear);
   cstmt.setInt(3, nSemester);
   cstmt.registerOutParameter(4, oracle.jdbc.OracleTypes.CURSOR);
   
   cstmt.executeQuery();
   
   myResultSet = (ResultSet)cstmt.getObject(4);
   
   if(myResultSet != null){
      while(myResultSet.next()){
         int t_time = myResultSet.getInt("t_time");
         String c_id = myResultSet.getString("c_id");
         String c_subject = myResultSet.getString("c_subject");
         int c_id_no = myResultSet.getInt("c_id_no");
         int c_unit = myResultSet.getInt("c_unit");
         String t_place = myResultSet.getString("t_place");
         nSum += c_unit;

      %>
      <tr>
      <td align="center"><%=t_time%></td><td align="center"><%=c_id%></td>
      <td align="center"><%=c_subject%></td><td align="center"><%=c_id_no%></td>
      <td align="center"><%=c_unit%></td><td align="center"><%=t_place %></td>
      <td align="center"><a href="delete_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">삭제</a></td>
      </tr>
      <% 
      }
   }
   
   %>
   
   </table>
   <table width="75%" align="center" height="100%">
   <br>
   <tr><td align="center"><%=myResultSet.getRow()%>개의 과목과 총 <%=nSum %>학점을 신청하였습니다</td></tr>
   </table>
   
   <%
   
   myResultSet.close();
   cstmt.close();
   myConn.close();
   
}catch(SQLException ex){
   System.err.println("SQLExcemption:"+ex.getMessage());
}

%>


</body>
</html>