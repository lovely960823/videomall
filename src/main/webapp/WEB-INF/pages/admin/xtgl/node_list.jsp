<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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
		<script type="text/javascript">
  function to(url){
	window.location.href="${pageContext.request.contextPath }/manageros/node/"+url;
}
  function btn(totalPage){
	  var page = $("#tid").val();
	  if(page >= totalPage){
	  	page = totalPage;
	  }
	  if(page <= 0){
	  	page = 1;
	  }
	  window.location.href="${pageContext.request.contextPath }/manageros/node/findAllNode.do?page="+page;
	  }
</script>
	</head>
	<body>
		<div class="mid">
			<div class="rt_nav">
				首页 &gt; 系统管理 &gt; 权限管理
			</div>
			<br /><h3>权限列表</h3><br/>
			<table width="95%" border="0" cellspacing="0" cellpadding="0" style="margin:0px auto">
				<tr>
					<td align="left" height="33px">
						<input type="button" value="添 加" class="btn_tj"
							onClick="to('toAdd.do')" />
					</td>
					<td width="5%">&nbsp;</td>
				</tr>
			</table>
			<table width="95%" border="0" cellspacing="0" cellpadding="0"
				class="box1">
				<tr>
					
					<th width="6%">
						序列
					</th>
					<th width="12%">
						节点名
					</th>
					<th width="11%">
						所属节点
					</th>
					<th width="30%">
						URL路径
					</th>
					<th width="15%">
						添加日期
					</th>
					<th width="15%">
						修改日期
					</th>
					<th width="13%">
						操作
					</th>
				</tr>
				<c:forEach items="${result.data}" var="node" varStatus="n">
				<tr>
					<td>
						&nbsp;${n.count }
					</td>
					<td>
						&nbsp;${node.name }
					</td>
					<td>
						&nbsp;${node.part }
					</td>
					<td>
						&nbsp;${node.url }
					</td>
					<td>
						&nbsp;
						<fmt:formatDate value="${node.createTime }" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						&nbsp;
						<fmt:formatDate value="${node.updateTime }" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						<a class="color_bj" href="${pageContext.request.contextPath }/manageros/node/updateNodeUI.do?id=${node.id }">编辑</a>&nbsp;|&nbsp;
						<a class="color_sc" href="javascript:void(0)" onclick="del(${node.id })">删除</a> 
					</td>
				</tr>
				</c:forEach>
			</table>
			<br />
			<table style="width: 95%" align="center" cellpadding="0"
				cellspacing="0" class="pages">
				<tr>
					<td width="761">
						<div align="left" style="margin: 0 0 0 10px">
							共
							<span style="color: #ff0000">${result.count }</span>记录 &nbsp;&nbsp;当前
							<span style="color: #ff0000">${result.page }</span>/${result.totalPage }页
						</div>
					</td>
					<td width="35" align="center">
						<a href="${pageContext.request.contextPath }/manageros/node/findAllNode.do?page=1&limit=10">首 页</a>
					</td>
					<td width="35" align="center">
						<a href="${pageContext.request.contextPath }/manageros/node/findAllNode.do?page=${result.page-1 <= 0 ? 1 : result.page-1}">上 页</a>
					</td>
					<td width="35" align="center">
							<a href="${pageContext.request.contextPath }/manageros/node/findAllNode.do?page=${result.page+1 >= result.totalPage ? result.totalPage : result.page+1 }">下 页</a>
					</td>
					<td width="35" align="center">
						<a href="${pageContext.request.contextPath }/manageros/node/findAllNode.do?page=${result.totalPage }">末 页</a>
					</td>
					<td width="38">
						转到
					</td>
					<td width="45" align="left">
						<input type="text" name="textfield" id="tid"
							style="width: 20px; padding: 0 3px" />
					</td>
					<td width="45">
						<input type="button" value="GO" onFocus="this.blur()"
							class="btn_gs" onClick="btn(${result.totalPage })" />
					</td>
				</tr>
			</table>
		</div>
		<script type="text/javascript">
			function del(nId){
				if(confirm('确定删除吗？')){
					$.ajax({ 
						url:"${pageContext.request.contextPath }/manageros/node/delNode/"+nId+".do",
						data:{},
						type:'get',
						dataType:'json',
						success:function(data){
							if(data == '1'){
								alert('删除成功');
								//刷新当前页面
								window.location.reload();
							}
							if(data == '0'){
								alert('删除失败');
							}
						},
						error:function(data){
							alert('服务器繁忙');
						}
					});
				}
			};
		</script>
	</body>
</html>
