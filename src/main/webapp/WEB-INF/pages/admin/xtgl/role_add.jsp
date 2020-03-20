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
    <div class="layui-fluid">
        <div class="layui-row">
            <form class="layui-form">
                <div class="layui-form-item">
                    <label for="roleName" class="layui-form-label"> <span
                        class="x-red">*</span>角色名称 </label>
                    <div class="layui-input-inline">
                        <input type="text" id="roleName" name="roleName" required="" value=""
                            lay-verify="required" lay-reqtext="角色名称不能为空" autocomplete="off" class="layui-input">
                    </div>
                    <!-- <div class="layui-form-mid layui-word-aux">
                        <span class="x-red">*</span>将会成为您唯一的登入名
                    </div> -->
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label"> </label>
                    <button class="layui-btn btn-margR15" lay-filter="add" lay-submit="">
                                                                        添加</button>
                    <button class="layui-btn layui-btn-danger" type="button" onclick="xadmin.close();" >
                                                                        返回</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        layui.use([ 'form', 'layer' ], function() {
            $ = layui.jquery;
            var form = layui.form, layer = layui.layer;

            //监听提交
            form.on('submit(add)', function(data) {
                console.log(data);
                //发异步，把数据提交
                $.ajax({
                    url:"${pageContext.request.contextPath }/manageros/role/addRole",
                    data:data.field,
                    type:"POST",
                    success:function(data){
                        if(data == '1'){
                            layer.alert("添加成功", {
                                icon : 6
                            }, function() {
                                //关闭当前frame
                                xadmin.close();
                                // 可以对父窗口进行刷新 
                                xadmin.father_reload();
                            });
                        }else{
                            layer.alert("添加失败");
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
