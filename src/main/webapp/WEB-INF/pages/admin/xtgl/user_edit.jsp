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
                      <label for="username" class="layui-form-label">
                          <span class="x-red">*</span>登录名
                      </label>
                      <div class="layui-input-inline">
                        <input type="hidden" name="id" value="${user.id}">
                          <input type="text" id="username" name="username" required="" lay-verify="required"
                          autocomplete="off" class="layui-input" value="${user.username }" readonly="readonly" style="background-color: #ccc;">
                      </div>
                      <div class="layui-form-mid layui-word-aux">
                         <!--  <span class="x-red">*</span>将会成为您唯一的登入名 -->
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="phone" class="layui-form-label">
                                                                                     真实姓名
                      </label>
                      <div class="layui-input-inline">
                          <input type="text" id="nickname" name="nickname" 
                          autocomplete="off" class="layui-input" value="${user.nickname }">
                      </div>
                      <div class="layui-form-mid layui-word-aux">
                          <!-- <span class="x-red">*</span>将会成为您唯一的登入名 -->
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="password" class="layui-form-label">
                          <span class="x-red">*</span>密码
                      </label>
                      <div class="layui-input-inline">
                          <input type="password" id="password" name="password" required="" lay-verify="pass"
                          autocomplete="off" class="layui-input" value="${user.password }">
                      </div>
                      <!-- <div class="layui-form-mid layui-word-aux">
                          6到12个字符
                      </div> -->
                  </div>
                  <div class="layui-form-item">
                      <label class="layui-form-label"><span class="x-red">*</span>角色</label>
                      <div class="layui-input-block">
                        <!-- <input type="checkbox" name="like1[write]" lay-skin="primary" title="超级管理员" checked="">
                        <input type="checkbox" name="like1[read]" lay-skin="primary" title="编辑人员">
                        <input type="checkbox" name="like1[write]" lay-skin="primary" title="宣传人员" checked=""> -->
                        <c:forEach items="${roles}" var="role">
                            <input type="checkbox" name="r_id" lay-skin="primary"  
                                <c:forEach items="${user.roleList}" var="roleList">
                                    <c:if test="${role.id == roleList.id}">checked="checked"</c:if>
                                </c:forEach>
                             title="${role.roleName}" value="${role.id }">
                        </c:forEach>
                      </div>
                  </div>
                  <div class="layui-form-item">
                      <label for="L_repass" class="layui-form-label">
                      </label>
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
        
        layui.use(['form', 'layer'],
            function() {
                $ = layui.jquery;
                var form = layui.form,
                layer = layui.layer;

                //监听提交
                form.on('submit(add)',
                function(data) {
                    var arr = new Array();
                    var checkboxValue="";
                    $("input:checkbox[name='r_id']:checked").each(function() {
                        arr.push($(this).val());
                    });
                    checkboxValue = arr.join(",");
                    data.field.r_id = checkboxValue;
                    
                    $.ajax({
                        url:"${pageContext.request.contextPath }/manageros/user/editUser",
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
                            layer.alert("服务器忙，请稍后重试" );
                        },
                        dataType: "json"
                    });
                    
                    return false;
                });
                
            });</script>
    </body>

</html>

