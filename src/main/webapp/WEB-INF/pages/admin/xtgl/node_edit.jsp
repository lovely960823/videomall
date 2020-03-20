<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<title>网课商城</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/css.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
	</head>
	<body>
		<div class="mid">
			<div class="rt_nav">
				首页 &gt; 系统管理 &gt; 编辑权限
			</div>
			<br>
			  <h3>编辑权限</h3>
			<br>
			<form action="#" name="edit_form" method="post" id="form1">
			<table width="600" border="0" cellspacing="0" cellpadding="0" class="box2">
				<tr height="35px">
					<td width="150" class="cx_tdbg"  align="center">
						节点名称
					</td>
					<td>
					      <input type="hidden" name="id" value="${node.id }"/>
						<input name="name" type="text" value="${node.name }" 
						style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
				<tr height="35px">
					<td align="center" class="cx_tdbg">
						所属节点
					</td>
					<td>
						<input name="part" type="text" value="${node.part }"
							style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
				<tr height="35px">
					<td align="center" class="cx_tdbg">
						URL 路径
					</td>
					<td>
						<input name="url" type="text" value="${node.url }"
							style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
			</table>
			<br>
			<table width="700" cellpadding="0" cellspacing="0" border="0" style="margin:0 auto" >
					<tr>
					  <td height="40px" align="center">
					  <input type="button" value="确 定" onclick="edit()" class="btn_b btn-margR15" />
					  <input type="button" value="返 回" onclick="window.history.back();"
                            onfocus="this.blur()" class="btn_y" />
					  </td>
					</tr>
			    </table>
			
			</form>
		</div>
		<script type="text/javascript">
			function edit(){  //${pageContext.request.contextPath }/node/editNode.do
				$.ajax({
					url:"${pageContext.request.contextPath }/manageros/node/modifyNode.do",
					data:$('#form1').serialize(),
					type:"POmanageros/		success:function(data){
						if(data == '1'){
							alert("修改成功");
							//刷新当前页面
							window.location.reload();
						}else{
							alert("修改失败");
						}
					},
					error:function(data){
						alert("服务器忙，请稍后重试");
					},
					dataType: "json"
				});
				
			}
			
		</script>
	</body>
</html>
