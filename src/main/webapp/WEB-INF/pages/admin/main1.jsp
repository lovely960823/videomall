<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="icon" href="${pageContext.request.contextPath }/favicon.ico" type="image/x-icon"/>
<title>网课商城</title>
		<meta http-equiv="x-ua-compatible" content="ie=11"/>
</head>


<frameset rows="101,*" frameborder="0" framespacing="0">
<frame src="${pageContext.request.contextPath }/include/behind_top.jsp" frameborder="0" scrolling="no" />
<frameset cols="192,*" frameborder="0" framespacing="0">
<frame src="${pageContext.request.contextPath }/manageros/user/loginUmanageros/do?id=${sessionScope.loginUser.id }" name="left" frameborder="0" scrolling="auto" noresize="noresize"/>
<frame src="${pageContext.request.contextPath }/include/behind_main.jsp" name="right" frameborder="0" scrolling="auto" style="border-left:1px #ccc solid;"/>
</frameset></frameset>
<noframes><body>
</body></noframes>
</html>
