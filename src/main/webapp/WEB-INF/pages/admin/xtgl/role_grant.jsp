<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/css/css.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js"
		    charset="utf-8"></script>
		    
		 <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/lay/modules/layer.js"></script>   
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
		<style>
body {
	font: 12px "宋体", "楷体_GB2312";
	color: #000;
	margin: 0px;
	background-color: #f6faff;
}

ul,li {
	list-style: none;
}

a,a:hover {
	color: #000;
	font-family: "宋体", "楷体_GB2312";
	text-decoration: none;
}

#jdgl {
	width: 99%;
	padding: 2px 0 5px 2px;
	margin: 0 auto;
}

#root {
	margin: 10px;
	margin-left: 46%;
	width: 200px;
	overflow: hidden;
}

#root li {
	line-height: 25px;
}

#root .rem {
	padding-left: 16px;
}

#root li a {
	color: #666666;
	padding-left: 5px;
	text-decoration: none;
	outline: none;
	blr: expression(this.onFocus =   this.blur () );
}

#root li input {
	vertical-align: middle;
	margin-left: 5px;
}

#root .two {
	padding-left: 0px;
	display: none;
}

#root .two li {
	padding-left: 20px;
}

</style>
		<script type="text/javascript">
	function box_set() {
		var temp = '${param_nodes }';
		if (temp == '') {
			return;
		}
		var arr = document.getElementsByName("nodes");
		var len = arr.length;
		temp = "," + temp + ",";
		for ( var i = 0; i < len; i++) {
			if (temp.search("," + arr[i].value + ",") != -1) {
				arr[i].checked = true;
			}
		}
	}
</script>
</head>
	<body onload="box_set()">
	<form action="#" method="post" id="form1">
		<div class="mid">
			<!-- <div class="rt_nav">
				首页 &gt; 系统管理 &gt; 角色授权
			</div>
			<br>
			<br> -->
			<div id="jdgl">
				<input type="hidden" name="rId" value="${rId }" />
				<ul id="root">
					<c:forEach items="${nodelist}" var="node">
						<c:if test="${node.name eq node.part}">
							<li>
								<label>
									<a href="javascript:;" onFocus="this.blur()"
										style="font-size: 15px; color: #000"> <input name="nodes"
											type="checkbox" value="${node.id }" /> ${node.name }</a>
								</label>
								<ul class="two">
									<c:forEach items="${nodelist}" var="node1">
										<c:if
											test="${node1.name ne node1.part && node1.part eq node.part}">
											<li>
												<a> <input name="nodes" type="checkbox"
														value="${node1.id }" /> ${node1.name } </a>
														
													<ul class="three">
													   
													   <c:forEach items="${nodelist}" var="node2">
					                                        <c:if
					                                            test="${node2.name ne node2.part && node2.parentId eq node1.id}">
					                                            <li>
					                                                <a> <input name="nodes" type="checkbox"
					                                                        value="${node2.id }" /> ${node2.name } </a>
					                                            </li>
					                                        </c:if>
					                                    </c:forEach>
													</ul>	
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<script type="text/javascript">
	function addEvent(el, name, fn) {//绑定事件 
		if (el.addEventListener)
			return el.addEventListener(name, fn, false);
		return el.attachEvent('on' + name, fn);
	}
	function nextnode(node) {//寻找下一个兄弟并剔除空的文本节点 
		if (!node)
			return;
		if (node.nodeType == 1)
			return node;
		if (node.nextSibling)
			return nextnode(node.nextSibling);
	}
	function sibcheck(self) {//判断兄弟节点是否已经全部选中 
		var sbi = self.parentNode.parentNode.parentNode.childNodes, n = 0;
		for ( var i = 0; i < sbi.length; i++) {
			if (sbi[i].nodeType != 1)//由于孩子结点中包括空的文本节点，所以这里累计长度的时候也要算上去 
				n++;
			else if (sbi[i].getElementsByTagName('input')[0].checked)
				n++;
		}
		return n == sbi.length ? true : false;
	}
	addEvent(
			document.getElementById('root'),
			'click',
			function(e) {//绑定input点击事件，使用root根元素代理 
				e = e || window.event;
				var target = e.target || e.srcElement;
				var tp = nextnode(target.parentNode.nextSibling);
				switch (target.nodeName) {
				case 'A'://点击A标签展开和收缩树形目录，并改变其样式会选中checkbox 
					if (tp && tp.nodeName == 'UL') {
						if (tp.style.display != 'block') {
							tp.style.display = 'block';
							prevnode(target.parentNode.previousSibling).className = 'ren'
						} else {
							tp.style.display = 'none';
							prevnode(target.parentNode.previousSibling).className = 'add'
						}
					}
					break;
				case 'SPAN'://点击图标只展开或者收缩 
					var ap = nextnode(nextnode(target.nextSibling).nextSibling);
					if (ap.style.display != 'block') {
						ap.style.display = 'block';
						target.className = 'ren'
					} else {
						ap.style.display = 'none';
						target.className = 'add'
					}
					break;
				case 'INPUT'://点击checkbox，父亲元素选中，则孩子节点中的checkbox也同时选中，孩子结点取消父元素随之取消 
					if (target.checked) {
						if (tp) {
							var checkbox = tp.getElementsByTagName('input');
							for ( var i = 0; i < checkbox.length; i++)
								checkbox[i].checked = true;
						}
					} else {
						if (tp) {
							var checkbox = tp.getElementsByTagName('input');
							for ( var i = 0; i < checkbox.length; i++)
								checkbox[i].checked = false;
						}
					}
					parcheck(target, sibcheck(target));//当孩子结点取消选中的时候调用该方法递归其父节点的checkbox逐一取消选中 
					break;
				}
			});
</script>
			</div>
			<br>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="right">
						<input class="layui-btn btn-margR15" type="button" onclick="grant()" value="确  定"
							onFocus="this.blur()" />  &nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>
						<input type="button" value="返 回" onclick="xadmin.close();"
                            onfocus="this.blur()" class="layui-btn layui-btn-danger" />
					</td>
				</tr>
			</table>
			<br>
		</div>
		</form>
		<script type="text/javascript">
			function grant(){
					$.ajax({ //window.location='${pageContext.request.contextPath }/role/delRole/${role.id }'
						url:"${pageContext.request.contextPath }/manageros/role/editRoleGrant",
						data:$("#form1").serialize(),
						type:'POST',
						dataType:'json',
						success:function(data){
							if(data == '1'){
								alert("授权成功");
                                window.location.reload();
                                
							}
							
							if(data == '0'){
								alert('授权失败');
							}
						},
						error:function(data){
							alert('服务器繁忙');
						}
					});
			}
		</script>
	</body>
</html>
