<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>网课商城</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
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
    </head>
    <body>
        <div class="layui-fluid">
            <div class="layui-row">
                <form class="layui-form" id="myform" enctype="multipart/form-data">
                 <div class="layui-form-item">
                    <div class="layui-block">
                         <label for="researchDirection" class="layui-form-label">
                              <span class="x-red">*</span>学科名称
                          </label>
                          <div class="layui-input-block" style="width:40%;">
	                            <input type="text" id="name" name="name" required="" lay-verify="required" 
	                          autocomplete="off" class="layui-input">    
                          </div>
                     </div>
                      <div class="layui-form-mid layui-word-aux">
                      </div>
                  </div>
                 
                  <div class="layui-form-item" style="text-align:center">
                      <button  class="layui-btn btn-margR15" lay-filter="add" lay-submit="">
                                                                           添加
                      </button>
                      <button class="layui-btn layui-btn-danger" type="button" onclick="xadmin.close();" >
                                                                        返回</button>
                  </div>
              </form>
            </div>
        </div>
        <script>
        
        layui.use(['form', 'layer', 'laydate'],
            function() {
                $ = layui.jquery;
                var form = layui.form,
                laydate = layui.laydate,
                layer = layui.layer;
                //日期
				  laydate.render({
				    elem: '#birthday'
				    ,type: 'month'
				  });
				  
                //监听提交
                form.on('submit(add)',
                function(data) {
                    var form = new FormData(document.getElementById("myform"));
                    console.log(form);
                    $.ajax({
	                    url:"${pageContext.request.contextPath }/manageros/course/addXk",
	                    data:form,
	                    type:"POST",
	                    async : false,
			            contentType: false,   
			            processData: false,   
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
	                        layer.alert("服务器忙，请稍后重试" );
	                    },
	                    dataType: "json"
	                });
                    
                    return false;
                });
                
            });</script>
    </body>

</html>

