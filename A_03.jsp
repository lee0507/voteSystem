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
<title>후보등록 A_03.jsp</title>
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

		Integer NewStuId = 0;
		
		ResultSet rset = stmt.executeQuery("select max(id) from hubo_table");
		String cTmp = request.getParameter("cname");
		Integer cid = Integer.parseInt(request.getParameter("cid"));
		
	if(cTmp.length() == 0) {
		cTmp = "이름을 빈칸으로 할 수 없습니다.";
	} else if(cTmp.contains("&quot") || cTmp.contains("&lt;") || cTmp.contains("&gt;") || 
				cTmp.contains("&amp") || cTmp.contains("&nbsp") || cTmp.contains("&nbsp") || 
				cTmp.contains("&reg")|| cTmp.contains("&copy;") || cTmp.contains("&;") ||
				cTmp.contains("`") || cTmp.contains("~") || cTmp.contains("!") || 
				cTmp.contains("@")|| cTmp.contains("#") || cTmp.contains("$") ||
				cTmp.contains("%") || cTmp.contains("^") || cTmp.contains("&") || 
				cTmp.contains("*")|| cTmp.contains("(") || cTmp.contains(")") ||
				cTmp.contains("-") || cTmp.contains("_") || cTmp.contains("=") || 
				cTmp.contains("+")|| cTmp.contains("\\") || cTmp.contains("|") ||
				cTmp.contains("[") || cTmp.contains("]") || cTmp.contains("{") || 
				cTmp.contains("}")|| cTmp.contains("<") || cTmp.contains(">") ||
				cTmp.contains(",") || cTmp.contains(".") || cTmp.contains("/") || 
				cTmp.contains(":") || cTmp.contains("\"") || cTmp.contains("\'") || 
				cTmp.contains("1") || cTmp.contains("2") || cTmp.contains("3") || 
				cTmp.contains("4") || cTmp.contains("5") || cTmp.contains("6") || 
				cTmp.contains("7") || cTmp.contains("8") || cTmp.contains("9") || 
				cTmp.contains("0") || cTmp.contains("?")) {
		cTmp = "기호는 입력할 수 없습니다.";
	} else {
		while (rset.next()) {
			NewStuId = rset.getInt(1)+1;
		}
		try {
			stmt.execute("insert into hubo_table (name, id) values('"+
			cTmp +"',"+
			cid +" );" );
			out.println("<h1> 후보등록 결과 : 후보가 추가되었습니다. </h1>");
			
		} catch (SQLSyntaxErrorException e) {
			out.println("<h1> => 성적은 숫자를 입력해야합니다. </h1>");		
		} catch (DataTruncation e) {
			out.println("<h1> => 입력한 이름이 칸을 초과하였습니다. </h1>");		
		} catch (SQLIntegrityConstraintViolationException e) {
			out.println("<h1> 후보번호가 중복되었습니다. </h1>");
		} catch (Exception e) {
			out.println(e);
		}
			rset.close();
			stmt.close();
			conn.close();
	}
%>

<a href="A_01.jsp">뒤로가기</a>

</BODY>
</HTML>