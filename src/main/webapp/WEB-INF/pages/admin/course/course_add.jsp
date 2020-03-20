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
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/lay/modules/layer.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath }/static/js/editor/kindeditor.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath }/static/js/editor/lang/zh_CN.js"></script>
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
            <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
            <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        
        <form class="layui-form" id="courseForm">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title" id="tab_my" style="text-align: center;">
                    <li class="layui-this" lay-id="101">课程介绍</li>
                    <li lay-id="102">目录</li>
                </ul>
                <div class="layui-tab-content" >
                	<div class="layui-tab-item layui-show">
                   		<div class="layui-form-item">
		                      <label for="beginTime" class="layui-form-label">
		                            	<span class="x-red">*</span>所属学科
		                      </label>
		                      <div class="layui-input-inline" >
		                      	   <span id="selectCity">
			                            <select name="parentId" required lay-verify="required"  id="parentId" lay-search=""  required="">
			                                <option value="">直接选择或搜索选择</option>
			                                <c:forEach items="${xkList}" var="xk">
			                                    <option value="${xk.id}">${xk.name}</option>
			                                </c:forEach>
			                            </select>
			                         </span>
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                          <!-- <span class="x-red">*</span>不能为空 -->
		                      </div>
		                      <label for="endTime" class="layui-form-label">
		                            	<span class="x-red">*</span>课程名称
		                      </label>
		                      <div class="layui-input-inline" >
		                          <input type="text" id="name" name="name" required lay-verify="required"  autocomplete="off" class="layui-input">
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                      </div>
	                    </div>
	                    <div class="layui-form-item">
		                      <label for="beginTime" class="layui-form-label">
		                            	<span class="x-red">*</span>难度等级
		                      </label>
		                      <div class="layui-input-inline" >
		                      	   <input type="text" id="difficulty" name="difficulty" required lay-verify="required" autocomplete="off" class="layui-input">
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                          <!-- <span class="x-red">*</span>不能为空 -->
		                      </div>
		                      <label for="endTime" class="layui-form-label">
		                            	<span class="x-red">*</span>课程时长
		                      </label>
		                      <div class="layui-input-inline" >
		                          <input type="text" id="duration" name="duration" required lay-verify="required" autocomplete="off" class="layui-input">
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                      </div>
	                    </div>
	                    <div class="layui-form-item">
		                      <label for="beginTime" class="layui-form-label">
		                            	<span class="x-red">*</span>原价
		                      </label>
		                      <div class="layui-input-inline" >
		                      	   <input type="text" id="price" name="price" required lay-verify="required"  autocomplete="off" class="layui-input">
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                          <!-- <span class="x-red">*</span>不能为空 -->
		                      </div>
		                      <label for="endTime" class="layui-form-label">
		                            	特惠价格
		                      </label>
		                      <div class="layui-input-inline" >
		                          <input type="text" id="discountPrice" name="discountPrice"  autocomplete="off" class="layui-input">
		                      </div>
		                      <div class="layui-form-mid layui-word-aux">
		                      </div>
	                    </div>
                        <div class="layui-form-item">
                        	<label for="tId" class="layui-form-label">
		                            	<span class="x-red">*</span>教学老师
		                      </label>
		                      <div class="layui-input-inline" >
		                      	   <span id="selecttId">
			                            <select name="tId" required lay-verify="required"  id="tId" lay-search=""  required="">
			                                <option value="">直接选择或搜索选择</option>
			                                <c:forEach items="${teacherList}" var="teacher">
			                                    <option value="${teacher.id}">${teacher.name}</option>
			                                </c:forEach>
			                            </select>
			                         </span>
		                      </div>
                            <label for="contents" class="layui-form-label"><span class="x-red">*</span>配图</label>
                            <div class="layui-input-inline">
                               <input type="file" name="imageFile" required lay-verify="required" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="contents" class="layui-form-label"><span class="x-red">*</span>课程介绍</label>
                            <div class="layui-input-block">
                                <textarea name="content" required lay-verify="required" class="layui-textarea" required="" id="editor"
                                 placeholder="课程介绍"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item" style="text-align:center">
		                    <button class="layui-btn btn-margR15" lay-filter="add" lay-submit="">
		                                                                            添加
		                    </button>
		                    <button class="layui-btn layui-btn-danger" type="button" onclick="xadmin.close();">
		                                                                            返回</button>
		                </div>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-table" style="width: 90%;margin: 0 auto;text-align: center;" >
						  <colgroup>
						    <col width="20%">
						    <col>
						    <col width="20%">
						    <col width="5%">
						  </colgroup>
						  <thead>
						    <tr>
						      <th align="center">名称</th>
						      <th align="center">简介</th>
						      <th align="center">文件</th>
						      <th align="center"><button type="button" class="layui-btn" onclick="addJscs()">新增数据</button></th>
						    </tr>
						  </thead> 
						  <tbody id="jscs">
						      <tr>
						          <td><input type="text" name="dname"  autocomplete="off" class="layui-input"></td>
						          <td>
						          	<textarea name="dcontent" required lay-verify="required" class="layui-textarea" placeholder="简介"></textarea>
						          </td>
						          <td><input type="file" name="videoFile" required lay-verify="required" class="layui-input"/></td>
						          <td><button type="button" class="layui-btn layui-btn-danger" onclick="delJscs(this)">删除</button></td>
						      </tr>
						  </tbody>
						 </table>
                    </div>

                </div>
                
            </div>
        </form>

    </body>
    <script type="text/javascript">
           var xhrOnProgress=function(fun) {
		      xhrOnProgress.onprogress = fun; //绑定监听
		      //使用闭包实现监听绑
		      return function() {
		         //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
		         var xhr = $.ajaxSettings.xhr();
		         //判断监听函数是否为函数
		         if (typeof xhrOnProgress.onprogress !== 'function')
		            return xhr;
		         //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
		         if (xhrOnProgress.onprogress && xhr.upload) {
		            xhr.upload.onprogress = xhrOnProgress.onprogress;
		         }
		         return xhr;
		      }
		   }
		   
        layui.use(['form', 'element', 'upload', 'layer'], function() {
            $ = layui.jquery;
            var form = layui.form,
                element = layui.element,
                layer = layui.layer,
                upload = layui.upload;

           //监听提交
            form.on('submit(add)',
            function(data) {
                var formData = new FormData(document.getElementById('courseForm'));  //courseForm  
                $.ajax({
                    url:"${pageContext.request.contextPath }/manageros/course/add",
                    data:formData,
                    type:"POST",
                    contentType: false, //不设置内容类型
                    processData: false, //不处理数据
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
           
        });
        
         function delJscs(obj){
            $(obj).parent().parent().remove();
         }
         function addJscs(){
            $("#jscs").append('<tr>'+
                                  '<td><input type="text" name="dname"  autocomplete="off" class="layui-input"></td> '+
                                  '<td><textarea name="dcontent" required lay-verify="required" class="layui-textarea" placeholder="简介"></textarea></td> '+
                                  '<td><input type="file" name="videoFile" required lay-verify="required" class="layui-input"/></td> '+
                                  '<td><button type="button" class="layui-btn layui-btn-danger" onclick="delJscs(this) ">删除</button></td> '+
                              '</tr>');
         }
         
                  
    </script>
</html>
