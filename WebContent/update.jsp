<%@page import="board.boardDTO"%>
<%@page import="board.boardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//세션 체크
		String userid = null;
		
		if(session.getAttribute("userid") != null){
			userid = (String)session.getAttribute("userid");
		}
		
		
		
		//로그인 한 회원만 글 수정 가능
		if(userid == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 먼저 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int num = 0;
		
		//게시글 번호 조회
		if(request.getParameter("num") != null){
			num = Integer.parseInt(request.getParameter("num"));
		}
		
		//게시글 번호가 없으면 없는 게시글
		if(num == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 게시글 입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}

		//id를 가져와서 권한 설정
		boardDTO bt = new boardDAO().getContent(num);
		System.out.println(bt.getUserid());
		
		if(!userid.equals(bt.getUserid())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 할 권한이 없습니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
	%>
	
	<form action="update_result.jsp?num=<%=num %>" method="post">
		<table border=1>
			<tr>
				<th>글 제목</th>
				<td><input type="text" name="title" value="<%= bt.getTitle()%>"></td>
			</tr>
			<tr>
				<th>글 내용</th>
				<td><textarea name="content"><%= bt.getContent() %></textarea></td>
			</tr>
		</table>
		<input type="submit" value="수정">
	</form>
</body>
</html>