<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>网课商城后台管理</title>
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <meta http-equiv="Cache-Control" content="no-siteapp" />
        <link rel="icon" href="${pageContext.request.contextPath }/static/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
          <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
          <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script>
            // 是否开启刷新记忆tab功能
            // var is_remember = false;
        </script>
    </head>
    <body class="index">
        <!-- 顶部开始 -->
        <div class="container">
            <div class="logo">
                <a href="/">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;网课商城</a></div>
            <div class="left_open">
                <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
            </div>
            <ul class="layui-nav right" lay-filter="">
                <li class="layui-nav-item to-index">
                    <a href="${pageContext.request.contextPath }/" target="_blank">平台首页</a>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">admin</a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <!-- <dd>
                            <a onclick="xadmin.open('个人信息','http://www.baidu.com')">个人信息</a></dd> -->
                        <dd>
                            <a onclick='xadmin.add_tab("修改密码","../../manageros/user/toEditPwd")'>密码修改</a></dd>
                        <dd>
                            <a href="javascript:void(0)" onclick="logout()">退出</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
        <!-- 顶部结束 -->
        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav" style="overflow-y: auto;">
            <div id="side-nav">
                <ul id="nav">
                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
            <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
                <ul class="layui-tab-title">
                    <li class="home">
                        <i class="layui-icon">&#xe68e;</i>我的桌面</li>
				</ul>
                <div class="layui-unselect layui-form-select layui-form-selected" id="tab_right">
                    <dl>
                        <dd data-type="this">关闭当前</dd>
                        <dd data-type="other">关闭其它</dd>
                        <dd data-type="all">关闭全部</dd>
					</dl>
                </div>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <iframe src='${pageContext.request.contextPath }/manageros/welcome' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                    </div>
                </div>
                <div id="tab_show"></div>
            </div>
        </div>
        <div class="page-content-bg"></div>
        <style id="theme_style"></style>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->
<script>
            //获取所有的菜单
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath }/manageros/node/findNodeAjax",
            dataType: "json",
            success: function(data) {
                //先添加所有的主材单
                $.each(data, function(i, obj) {
                    var content = "";
                    if (obj.childrenList != null && obj.childrenList.length > 0) {   //一级菜单有子节点的情况
                        content = "<li>";
	                    content += "<a href='javascript:;'>";
	                    content += "<i class='iconfont left-nav-li layui-icon' lay-tips='"+obj.name+"'>"+obj.icon+"</i>";
	                    content += "<cite>"+obj.name+"</cite>";
	                    content += "<i class='iconfont nav_right'>&#xe697;</i>";
	                    content += "</a>";
	                    //这里是添加所有的子菜单
	                    content += loadchild(obj);
	                    
	                    content += "</li>";
                    }else{
                        content += "<li>";
                        content += "<a onclick='xadmin.add_tab(\""+obj.name+"\",\""+obj.url+"\")'>";
                        content += "<i class='iconfont  layui-icon'>"+obj.icon+"</i>";
                        content += "<cite>"+obj.name+"</cite></a>";
                        content += "</li>";
                    }
                    
                    $("#nav").append(content);
                });
                //element.init();
            },
            error: function(jqXHR) {
                aler("发生错误：" + jqXHR.status);
            }
        });
        
        //组装子菜单的方法，递归
        function loadchild(obj) {
            if (obj == null) {
                return;
            }

            var content = "";
            if (obj.childrenList != null && obj.childrenList.length > 0) {
                content += "<ul class='sub-menu'>";
            }  else {
                content += "<ul>";
            } 

            if (obj.childrenList != null && obj.childrenList.length > 0) {
                $.each(obj.childrenList, function(i, note) {
                    
                    if (note.childrenList != null) {    //有三级菜单的情况
                        content += "<li>";
                        content += "<a href='javascript:;'>";
	                    content += "<i class='iconfont left-nav-li layui-icon' lay-tips='"+note.name+"'>"+note.icon+"</i>";
	                    content += "<cite>"+note.name+"</cite>";
	                    content += "<i class='iconfont nav_right'>&#xe697;</i>";
	                    content += "</a>";
                    
                        content += loadchild(note);
                        content += "</li>";
                    }else{              //childrenList 为空，证明没有子节点
                        content += "<li>";
	                    content += "<a onclick='xadmin.add_tab(\""+note.name+"\",\""+note.url+"\")'>";
	                    content += "<i class='iconfont  layui-icon'>"+note.icon+"</i>";
	                    content += "<cite>"+note.name+"</cite></a>";
                        content += "</li>";
                    }
                   
                });

                content += "</ul>";
            }
            //console.log(content);
            return content;
        }    
        
        function logout(){
            window.sessionStorage.clear();
            window.localStorage.clear();
            window.location.href="${pageContext.request.contextPath }/manageros/user/logout";
        }
        window.sessionStorage.clear();
        window.localStorage.clear();
</script>
    </body>

</html>