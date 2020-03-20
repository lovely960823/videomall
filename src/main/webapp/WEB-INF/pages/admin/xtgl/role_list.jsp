<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
        <script src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
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
                    <cite>角色管理</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
                <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
            </a>
        </div>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <form class="layui-form layui-col-space5">
                                <div class="layui-inline layui-show-xs-block"></div>
                                <div class="layui-inline layui-show-xs-block"></div>
                                <div class="layui-inline layui-show-xs-block">
                                    <input type="text" name="roleName" id="roleName" placeholder="请输入角色名称" autocomplete="off" class="layui-input"></div>
                                <div class="layui-inline layui-show-xs-block">
                                     <button type="button" id="searchB"  class="layui-btn layui-inline" data-type="reload">查找</button>
                                </div>
                            </form>
                        </div>
                        <div class="layui-card-body ">
                            <!-- <table class="layui-table" lay-data="{url:'../../manageros/role/findRoleAjax',page:true,toolbar: '#toolbarDemo',id:'test'}" lay-filter="test">
                                <thead>
                                    <tr>
                                        <th lay-data="{type:'checkbox'}">ID</th>
                                        <th lay-data="{field:'id', width:80}">序号</th>
                                        <th lay-data="{field:'roleName', width:120, }">角色名称</th>
                                        <th lay-data="{field:'roleMs', width: 150}">角色描述</th>
                                        <th lay-data="{field:'createTime', width: 150}">创建时间</th>
                                </thead>
                            </table> -->
                            <table class="layui-hide" id="testT" lay-filter="test"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/html" id="toolbarDemo">
        <div class = "layui-btn-container" > 
            <button class = "layui-btn layui-btn-sm" lay-event = "add" > 添加 </button>
        </div > 
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="grant">授权</a>
	</script>
<script>
    layui.use('table', function(){
		var table = layui.table;
		
		setTimeout(function(){
            layui.layer.tips('点击此处刷新', '.x-nav .layui-btn-small', {
            tips: 3
           });
        },500);
		
		table.render({
		  elem: '#testT'
		  ,url:'../../manageros/role/findRoleAjax'
		  ,toolbar: '#toolbarDemo'
		  ,title: '用户数据表'
		  //,toolbar:false
		  ,cols: [[
		     /* {type: 'checkbox', fixed: 'left'}
		    , */{field:'xh', title:'序号', width:'10%', fixed: 'left', unresize: true,align:'center',type:'numbers'}   //unresize: true禁止拖动
		    ,{field:'roleName', title:'角色名称',width:'30%',align:'center'}
		    ,{field:'createTime', title:'创建时间', width:'20%',align:'center'}
		    ,{field:'updateTime', title:'修改时间', width:'20%',align:'center'}
		    ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'20%',align:'center'}
		  ]]
		  ,page: true
        });
        
        
     //根据条件查询表格数据重新加载
      var $ = layui.$, active = {
            reload: function(){
            //获取用户名
              var demoReload = $('#roleName');
              //执行重载
              table.reload('testT', {
                page: {
                  curr: 1 //重新从第 1 页开始
              }
              //根据条件查询
                ,where: {
                    roleName:demoReload.val()
                    //,createTime:'2019-6-10'
                }
              });
           }
        };
        
      //点击搜索按钮根据条件查询
      $('#searchB').on('click',
          function(){
              var type = $(this).data('type');
              active[type] ? active[type].call(this) : '';
      });
        
         //头工具栏事件
		table.on('toolbar(test)', function(obj){
			 if(obj.event === 'add'){
			     xadmin.open('添加角色','../../manageros/role/toAddRole','','',true); //${pageContext.request.contextPath }
		          setTimeout(function(){
		              layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
		              tips: 3
		             });
		          },500);
			 }
		});
		
       //监听行工具事件
	  table.on('tool(test)', function(obj){
	    var data = obj.data;
	    //console.log(obj)
	    if(obj.event === 'grant'){   
	     //打开授权页面
	     xadmin.open('角色授权','../../manageros/node/grantUI/'+data.id+'','','',true); //${pageContext.request.contextPath }
          setTimeout(function(){
              layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
              tips: 3
             });
          },500);
	    } else if(obj.event === 'edit'){
	      //打开编辑页面
          xadmin.open('编辑角色','../../manageros/role/updateRoleUI/'+data.id+'','','',true); //${pageContext.request.contextPath }
          setTimeout(function(){
              layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
              tips: 3
             });
          },500);
	    }else if(obj.event === 'del'){
          //删除实现
          layer.confirm('确定删除吗？', function(index){
	        $.ajax({ 
                url:"../../manageros/role/delRole/"+data.id+"",
                data:{},
                type:'get',
                dataType:'json',
                success:function(data){
                    if(data == '1'){
                        layer.alert('删除成功', { icon: 1, closeBtn: 0 }, function (index) { 
                            location.reload();
                        });
                    }
                    if(data == '0'){
                        layer.alert('删除失败');
                    }
                },
                error:function(data){
                    layer.alert('服务器繁忙');
                }
            });
            
	        
	      });
          
        }
	    
	  });
	  
		
     });
        
</script>
</html>
