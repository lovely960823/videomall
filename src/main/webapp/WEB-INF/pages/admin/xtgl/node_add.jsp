<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/css.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.8.3.min.js"></script>
	</head>
	<body>
		<div class="mid">
			<div class="rt_nav">
				首页 &gt; 系统管理 &gt; 添加权限
			</div>
			<br/>
			  <h3>添加权限</h3>
			<br/>
			<form id="form1" method="post" name="add_node">
			<table width="600" border="0" cellspacing="0" cellpadding="0" class="box2">
				<tr>
					<td width="150" align="center" class="cx_tdbg" height="35px">
						节点名称
					</td>
					<td>
						<input name="name" type="text" 
							style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
				<tr>
					<td align="center" class="cx_tdbg" height="35px">
						所属节点
					</td>
					<td>
						<input name="part" type="text"
							style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
				<tr>
					<td align="center" class="cx_tdbg" height="35px">
						URL 路径
					</td>
					<td>
						<input name="url" type="text"
							style="height: 19px;width:300px; padding: 2px 0 0 3px;" />
					</td>
				</tr>
			</table>
			<br />
			<table width="700" cellpadding="0" cellspacing="0" border="0" style="margin:0 auto" >
					<tr>
					  <td height="40px" align="center">
					  <input type="button" value="添 加" onclick="add()" class="btn_b btn-margR15" />
					  <input type="button" value="返 回" onclick="window.history.back();"
                            onfocus="this.blur()" class="btn_y" />
					  </td>
					</tr>
			    </table>
			<input type="reset" id="qk" name="reset" style="display: none;" />
			</form>
		</div>
		<script type="text/javascript">
			function add(){  
				$.ajax({
					url:"${pageContext.request.contextPath }/manageros/node/addNode.do",
					data:$('#form1').serialize(),
					type:"POST"manageros/uccess:function(data){
						if(data == '1'){
							$("#qk").trigger("click");
							alert("添加成功");
						}else{
							alert("添加失败");
						}
					},
					error:function(data){
						alert("服务器忙，请稍后重试" );
					},
					dataType: "json"
				});
				
			}
			
		</script>
	</body>
</html>
