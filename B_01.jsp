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
<title>투표 B_01.jsp</title>
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
		<td width=100 align=center><a href="A_01.jsp">후보등록</a></td>
		<td width=100 bgcolor="#00ffff" align=center><a href="B_01.jsp">투표</a></td>
		<td width=100 align=center><a href="C_01.jsp">개표결과</a></td>
	</tr>
</table>
<h1> 투표하기 </h1>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:3307/kopoctc","root","kopoctc"); 
		Statement stmt = conn.createStatement();

		Integer NewStuId = 0;
		
		ResultSet rset = stmt.executeQuery("select * from hubo_table");
	
		out.println("<table cellspacing=3 width=600 border=1>");
		out.println("<tr>");
		out.println("<form method=\"post\" action=\"B_02.jsp\">");
		out.println("<td width=200><p align=center>");
		out.println("<select name=cchoice required>");
		out.println("<option value='' selected=\"selected\">후보자 선택</option>");
		while(rset.next()) {
			out.println("<option value="+rset.getInt(1)+">"+rset.getInt(1)+" "+rset.getString(2)+" ");
		}
		out.println("</select>");
		
		out.println("<select name=cage required>");
		out.println("<option value='' selected=\"selected\">연령별 선택</option>");
		out.println("<option value='10'>10대</option>");
		out.println("<option value='20'>20대</option>");
		out.println("<option value='30'>30대</option>");
		out.println("<option value='40'>40대</option>");
		out.println("<option value='50'>50대</option>");
		out.println("<option value='60'>60대</option>");
		out.println("<option value='70'>70대</option>");
		out.println("<option value='80'>80대</option>");
		out.println("<option value='90'>90대</option>");
		out.println("</select>");
		out.println("</p>");
		out.println("<td>");
		out.println("<input type=submit value=\"투표하기\">");
		out.println("</td>");
	out.println("</form>");
	out.println("</tr>");
out.println("</table>");
%>

</BODY>
</HTML>
