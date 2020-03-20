<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
<meta charset="UTF-8">
<title>网课商城</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js"
	charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
<!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
<!--[if lt IE 9]>
            <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
            <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>
<body>
	<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="javascript:void(0)">首页</a>
                <a href="javascript:void(0)">系统管理</a>
                <a href="javascript:void(0)">
                    <cite>修改密码</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
                <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
            </a>
        </div>
	<div class="layui-fluid">
		<div class="layui-row">
			<form class="layui-form" style="font-size: 14px">
				<div class="layui-form-item">
					<label for="username" class="layui-form-label">用户名</label>
					<div class="layui-input-inline">
					    <input name="id" type="hidden" value="${loginUser.id }" />
						<input type="text" id="username" name="username" required="" value="${loginUser.username }"
						readonly="readonly" class="layui-input" style="background-color: #ccc;">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="password" class="layui-form-label"> <span
						class="x-red">*</span>旧密码</label>
					<div class="layui-input-inline">
						<input type="password" id="password" name="password" required="" value=""
							lay-verify="required" lay-reqtext="旧密码不能为空" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label for="newP" class="layui-form-label"> <span
						class="x-red">*</span>新密码</label>
					<div class="layui-input-inline">
						<input type="password" id="newP" name="newPwd" required="" value=""
						 autocomplete="off" class="layui-input" required="" lay-verify="newPwd">
					</div>
					<div class="layui-form-mid layui-word-aux">
                         6到12个字符
                    </div>
				</div>
				<div class="layui-form-item">
					<label for="reNewP" class="layui-form-label"> <span
						class="x-red">*</span>确认新密码</label>
					<div class="layui-input-inline">
						<input type="password" id="reNewP" name="reNewPwd" required="" value=""
						 autocomplete="off" class="layui-input" required="" lay-verify="reNewPwd">
					</div>
					<div class="layui-form-mid layui-word-aux">
                         6到12个字符
                    </div>
					<!-- <div class="layui-form-mid layui-word-aux">
						<span class="x-red">*</span>将会成为您唯一的登入名
					</div> -->
				</div>
				<div class="layui-form-item">
					<label for="L_repass" class="layui-form-label"> </label>
					<button class="layui-btn btn-margR15" lay-filter="update" lay-submit="">
						修改</button>
					<button type="reset" class="layui-btn layui-btn-warm">重置</button>
				</div>
			</form>
		</div>
	</div>
	<script>
		layui.use([ 'form', 'layer' ], function() {
			$ = layui.jquery;
			var form = layui.form, layer = layui.layer;
			//自定义验证规则
            form.verify({
            	newPwd: [/(.+){6,12}$/, '密码必须6到12位'],
            	reNewPwd: function(value) {
                    if ($('#newP').val() != $('#reNewP').val()) {
                        return '两次密码不一致';
                    }
                }
            });
			//监听提交
			form.on('submit(update)', function(data) {
				console.log(data);
				//发异步，把数据提交
				$.ajax({
                    url:"${pageContext.request.contextPath }/manageros/user/editPwd.do",
                    data:data.field,
                    type:"POST",
                    success:function(data){
                        if(data == '1'){
                            layer.alert("修改成功", {
			                    icon : 6
			                }, function() {
			                    //关闭当前frame
			                    xadmin.close();
			                    // 可以对父窗口进行刷新 
			                    xadmin.father_reload();
			                });
                        }else{
                            layer.alert("修改失败");
                        }
                    },
                    error:function(data){
                        alert("服务器忙，请稍后重试");
                    },
                    dataType: "json"
                });
				return false;
			});

		});
	</script>
</body>
</html>
