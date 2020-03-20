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
                <input name="id" value="${lunbo.id}" type="hidden">
                  <div class="layui-form-item">
                     <label for="unit" class="layui-form-label">
                          <span class="x-red">*</span>图片
                      </label>
                      <div class="layui-input-inline">
                          <input type="file" id="imageFile" name="imageFile" required="" lay-verify="imageFile" 
                          autocomplete="off" class="layui-input">
                      </div>
                      <div class="layui-form-mid layui-word-aux">
                         <span class="x-red">*</span>图片不得大于3M,建议图片宽高比例为600：400
                      </div>
                  </div>
                 
                  <div class="layui-form-item" style="text-align:center">
                      <button  class="layui-btn btn-margR15" lay-filter="add" lay-submit="">
                                                                            修改
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
				  
				  //自定义验证规则
                /* form.verify({
                    imageFile:function(value){
                        if($('#imageFile').val()=="" || $('#imageFile').val()==null){
                            return "图片不能为空";
                        }else{
                            var _name, _fileName;
		                    _name = $("#imageFile").val();
		                    _fileName = _name.substring(_name.lastIndexOf(".") + 1).toLowerCase();
		                    if (_fileName != "png" && _fileName != "jpg" && _fileName !="gif" && _fileName != "jpeg") {
		                         return "上传图片格式不正确，请重新上传";
		                    }
		                    var tmpFile = document.getElementById('imageFile');
		                    var fileData = tmpFile.files[0];
		                    var size = fileData.size;
		                    if(size > 1024*1024*3){
		                        return "图片大于3M,请处理后重新上传";
		                    }
                        }
                    }
                }); */
                //监听提交
                form.on('submit(add)',
                function(data) {
                    var form = new FormData(document.getElementById("myform"));
                    $.ajax({
	                    url:"${pageContext.request.contextPath }/manageros/lunbo/update",
	                    data:form,
	                    type:"POST",
	                    async : false,
			            contentType: false,   
			            processData: false,   
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
	                        layer.alert("服务器忙，请稍后重试" );
	                    },
	                    dataType: "json"
	                });
                    
                    return false;
                });
                
            });</script>
    </body>

</html>

