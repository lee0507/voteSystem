<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.lang.Math" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
<title>개표결과 C_01.jsp</title>
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
		<td width=100 align=center><a href="B_01.jsp">투표</a></td>
		<td width=100 bgcolor="#00ffff" align=center><a href="C_01.jsp">개표결과</a></td>
	</tr>
</table>
<h1> 후보별 득표 결과 </h1>

<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:3307/kopoctc","root","kopoctc"); 
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select count(*) from tupyo_table;");
		
		double totalcnt = 0;
		double rate = 0;
		double rate_two = 0;
		while(rset.next()) {
			totalcnt = rset.getDouble(1);
		}
		
		out.println("<table cellspacing=3 width=600 border=1>");
			out.println("<tr>");
				out.println("<td width=75><p align=center>이름</p></td>");
				out.println("<td width=500><p align=center>인기도</p></td>");
			out.println("</tr>");

		rset = stmt.executeQuery("select a.id, a.name, count(b.id) from hubo_table as a left join tupyo_table as b on a.id=b.id group by a.id order by a.id;");
			while(rset.next()) {
				if(totalcnt == 0) {
					totalcnt = 1;
				}
				rate = (rset.getInt(3) / totalcnt) * 100;
				rate_two = (Math.round(rate*100)/100.0);
				out.println("<tr>");
					out.println("<td width=75><a href='C_02.jsp?key="+rset.getInt(1)+"'><p align=center>" + rset.getInt(1) +". "+ rset.getString(2) +"</p></a></td>");
					out.println("<td width=500><p align=left><img src='bar.jpg' width="+rate_two*2+" height=20>" + rset.getInt(3) +"("+rate_two+"%)</p></td>");
				out.println("</tr>");
			}
		out.println("</table>");
		
		rset.close();
		stmt.close();
		conn.close();
%>
</BODY>
</HTML>