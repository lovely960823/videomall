<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台登录-网课商城</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
    <link rel="icon" href="${pageContext.request.contextPath }/static/favicon.ico" type="image/x-icon"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
    <script src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
        <script type="text/javascript">
            if(window!=top){
                top.location.href = location.href;
            }
        </script>
<script type="text/javascript">
$(document).ready(function(){
    layui.use('layer', function(){
	    var layer = layui.layer;
	    var msg1=$("#msg1").val();
	    var msg2=$("#msg2").val();
	    var msg3=$("#msg3").val();
	    var msg4=$("#msg4").val();
	    if(!isNaN(msg1)&&msg1!==""){
	        layer.alert("用户已注销！");
	    }
	    if(!isNaN(msg2)&&msg2!==""){
	        layer.alert("用户未启用！");
	    }
	    if(!isNaN(msg3)&&msg3!==""){
	        layer.alert("用户审核未通过！");
	    }
	    if(!isNaN(msg4)&&msg4!==""){
	        layer.alert("用户名或密码错误,请重新登录！");
	    }
    });
});
</script>
<body class="login-bg">
    
    <div class="login layui-anim layui-anim-up">
        <div class="message">网课商城-管理登录</div>
        <div id="darkbannerwrap"></div>
        <input type="hidden" value="${msg1 }"  id="msg1"/>
         <input type="hidden" value="${msg2 }"  id="msg2"/>
         <input type="hidden" value="${msg3 }"  id="msg3"/>
         <input type="hidden" value="${msg4 }"  id="msg4"/>
        <form method="post" action="${pageContext.request.contextPath }/manageros/user/login" class="layui-form" >
            <input name="username" placeholder="用户名" autocomplete="off" type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密    码"  type="password" class="layui-input">
            <hr class="hr15">
            <input value="登 录" lay-submit lay-filter="login" style="width:100%;font-size:16px;margin-top:20px;" type="submit">
            <hr class="hr20" >
        </form>
    </div>

    <script>
        $(function  () {
            layui.use('form', function(){
              var form = layui.form;
              form.on('submit(login)', function(data){
               /*  layer.msg(JSON.stringify(data.field),function(){
                    location.href='index.html'
                });
                return false; */
              });
            });
        })
    </script>
</body>
</html>
