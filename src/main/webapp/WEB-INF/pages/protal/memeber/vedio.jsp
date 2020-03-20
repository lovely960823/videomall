<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视频播放</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<video id="myvedio" src="${pageContext.request.contextPath }/${courseDetail.dvideo }" controls="controls" autoplay="autoplay" loop="loop">
</video>
<br>
	<c:if test="${pre ne '0'}">
  		<a href="${pageContext.request.contextPath }/course/courseVedio/${pre}">上一篇: ${preNews.dname }</a>
  	</c:if>
	<c:if test="${pre eq '0'}">
  		<a href="javascript:void(0)" style="color:green">上一篇： 暂无更多数据</a>
  	</c:if>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<c:if test="${next ne '0'}">
  		<a href="${pageContext.request.contextPath }/course/courseVedio/${next}">下一篇：${nextNews.dname }</a>
  	</c:if>
	<c:if test="${next eq '0'}">
  		<a href="javascript:void(0)"  style="color:green">下一篇： 暂无更多数据</a>
  	</c:if>
  	&nbsp;&nbsp;&nbsp;&nbsp;
  	倍速
	<select onchange="changeRate(this.options[this.options.selectedIndex].value)">
		<option value="0.5">0.5X</option>
		<option value="0.75">0.75X</option>
		<option value="1" selected="selected">1X</option>
		<option value="1.5">1.5X</option>
		<option value="1.75">1.75X</option>
		<option value="2">2X</option>
		<option value="2">10X</option>
	</select>
</body>
<script type="text/javascript">
function changeRate(obj){
	document.getElementById("myvedio").playbackRate=obj;
	vedio.play();
}
</script>
</html>