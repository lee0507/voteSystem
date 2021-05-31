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
<title>후보삭제 A_02.jsp</title>
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
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.83:3307/kopoctc","root","kopoctc"); 
		Statement stmt = conn.createStatement();
	try {
		String ctmp = request.getParameter("id");
		String sql = "delete from hubo_table where id = "+ctmp+";";
		stmt.executeUpdate(sql);
		String sqlm = "delete from tupyo_table where id = "+ctmp+";";
		stmt.executeUpdate(sqlm);
	} catch (Exception e) {
		out.println("error");
	}
	
		stmt.close();
		conn.close();
%>

<h1> 후보등록 결과 : 후보가 삭제되었습니다. </h1>
<a href="A_01.jsp">뒤로가기</a>
</BODY>
</HTML>