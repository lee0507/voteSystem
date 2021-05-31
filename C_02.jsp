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
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:3307/kopoctc","root","kopoctc"); 
		Statement stmt = conn.createStatement();
		
		Integer ckey = Integer.parseInt(request.getParameter("key"));
		ResultSet rset = stmt.executeQuery("select * from hubo_table where id = "+ckey+";");
		String cname ="";
		while(rset.next()) {
			cname = rset.getString(2);
		}

%>
<h1> <%=cname%> 후보 득표 성향 </h1>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=75><p align=center>연령대</p></td>
		<td width=500><p align=center>인기도</p></td>
	</tr>
<%
		rset = stmt.executeQuery("select count(*) from tupyo_table where id= "+ckey+";");
		double totalcnt = 0;
		while(rset.next()) {
			totalcnt = rset.getDouble(1);
		}
		double rate_two = 0;
		double rate = 0;
		Integer c_age;
		double rate_age;
		
		for(int i = 10; i < 100; i+=10) {
			rset = stmt.executeQuery("select age, count(*) from tupyo_table where id = "+ckey+" and age="+i+" group by age;");
			rate = 0;
			c_age = 0;
			rate_age = 0;
			
			while(rset.next()) {
				c_age = rset.getInt(2);
				rate_age = (c_age / totalcnt)*100;
				rate_two = (Math.round(rate_age*100)/100.0);
			}
			
			out.println("<tr>");
			out.println("<td width=75><p align=center><p align=center>"+i+"대</p></td>");
			out.println("<td width=500><p align=left><img src='bar.jpg' width="+rate_age*2+" height=20>"+c_age+"("+rate_two+"%)</p></td>");
			out.println("</tr>");
		}
		out.println("</table>");
		
		rset.close();
		stmt.close();
		conn.close();


%>
</BODY>
</HTML>