<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
<title>후보등록 A_01.jsp</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100 bgcolor="#00ffff" align=center><a href="A_01.jsp">후보등록</a></td>
		<td width=100 align=center><a href="B_01.jsp">투표</a></td>
		<td width=100 align=center><a href="C_01.jsp">개표결과</a></td>
	</tr>
</table>
<h1> 후보등록 </h1>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:3307/kopoctc","root","kopoctc"); 
		Statement stmt = conn.createStatement();

		Integer id;
		String name="";

		ResultSet rset = stmt.executeQuery("select * from hubo_table;");
		out.println("<table>");
		while (rset.next()) {
			out.println("<tr>");
			out.println("<td>");
			out.println("<form method=\"post\" action=\"A_02.jsp\">기호: <input type=\"number\" name=\"id\" value="+rset.getInt(1)+" readonly>"+
			"이름 : <input type=\"text\" name=\"name\" value="+rset.getString(2)+" readonly><input type=\"submit\" value=\"삭제\">");
			out.println("</form>");
			out.println("</td>");
			out.println("</tr>");
		}
		
		rset.close();
		stmt.close();
		conn.close();
%>

<tr>
<td><form method="post" action="A_03.jsp">
기호: <input type="number" name="cid" value="" min="1" max="50" required>이름 : <input type="text" name="cname" value="" autocomplete='off' onkeypress="if(!(event.keyCode < 47 && event.keyCode > 58)) event.returnValue=false;" required><input type="submit" value="추가" >
</form></td>
</tr>
</table>
</BODY>
</HTML>

