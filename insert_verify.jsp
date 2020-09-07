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
<%
String s_id = (String)session.getAttribute("user");
String c_id = request.getParameter("c_id");
int t_time = Integer.parseInt(request.getParameter("t_time"));
int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));
%>
<%
Connection myConn = null;
String result = null;
CallableStatement cstmt = null;
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1616204";
String password = "ss2";
try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,password);   
}catch(SQLException ex){
   System.err.println("SQLException:"+ex.getMessage());
   
}

cstmt = myConn.prepareCall("{call insertEnroll(?,?,?,?,?)}");
cstmt.setString(1,s_id);
cstmt.setString(2,c_id);
cstmt.setInt(3,c_id_no);
cstmt.setInt(4,t_time);
cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
try{
   cstmt.execute();
   result=cstmt.getString(5);
   
   %>
   <script>
   alert("<%=result%>");
   location.href="insert.jsp";
   </script>
   <%
   }catch(SQLException ex){
      System.err.println("SQLException:"+ ex.getMessage());
   }
   finally{
      if(cstmt != null)
         try{
            myConn.commit();
            cstmt.close();
            myConn.close();}
      catch(SQLException ex){}
         }
   
   %>
</body>
</html>