<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!Doctype html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>农业育种机械装备网</title>
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
  
    <body>
        <div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="javascript:void(0)">首页</a>
                <a href="javascript:void(0)">产品中心</a>
                <a href="javascript:void(0)">
                    <cite>${this_cpzx.name }</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
                <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
            </a>
        </div>
		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
		  <ul class="layui-tab-title" id="tab_my">
		      <c:forEach items="${list }" var="cpzx" varStatus="vs">
		          <li  <c:if test="${vs.index eq '0' }">class="layui-this"</c:if> lay-id = "${cpzx.id}">${cpzx.name}</li>
		      </c:forEach>
		    <!-- <li class="layui-this" lay-id = "101">数粒仪</li>
		    <li lay-id = "102">清洗机</li>
		    <li lay-id = "103">包衣机</li>
		    <li lay-id = "104">分种器</li> -->
		  </ul>
		  <div class="layui-tab-content" style="">
		    <!-- <div class="layui-tab-item layui-show">内容不一样是要有，因为你可以监听tab事件（阅读下文档就是了）</div>
		    <div class="layui-tab-item">内容2</div>
		    <div class="layui-tab-item">内容3</div>
		    <div class="layui-tab-item">内容41</div> -->
		    <table class="layui-hide" id="testT" lay-filter="test"></table>
		    <input type="hidden" name="parentId" id="parentId" value="" />
		  </div>
		</div>
	 <script type="text/html" id="toolbarDemo">
        <div class = "layui-btn-container" > 
            <button class = "layui-btn layui-btn-sm" lay-event = "add" > 添加 </button>
        </div > 
    </script>
    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
		<script>
layui.use(['table','element','layer'], function(){
  var $ = layui.jquery
  ,table = layui.table
  ,layer = layui.layer
  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  
    setTimeout(function(){
            layui.layer.tips('点击此处刷新', '.x-nav .layui-btn-small', {
            tips: 3
           });
        },500);
    
     var showByTab = function(_type){
	     table.render({
	          elem: '#testT'
	          ,url:'../../manageros/cpzx/cpzxData'
	          ,where: {parentId:_type}
	          ,toolbar: '#toolbarDemo'
	          ,title: '产品中心数据表'
	          //,toolbar:false
	          ,cols: [[
	             /* {type: 'checkbox', fixed: 'left'}
	            , */{field:'xh', title:'序号', width:80, fixed: 'left', unresize: true,align:'center',type:'numbers'}   //unresize: true禁止拖动  type:'numbers' 序号排序
	            ,{field:'name', title:'产品名称',align:'center'}
	             
	            ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:200,align:'center'}
	          ]]
	          ,page: true
	        });
      }
      
      showByTab($("#tab_my li").eq(0).attr("lay-id"));
      $("#parentId").val($("#tab_my li").eq(0).attr("lay-id"));
      //监听Tab切换，以改变地址hash值
      element.on('tab(docDemoTabBrief)', function(){
        $("#parentId").val(this.getAttribute('lay-id'));
	    showByTab(this.getAttribute('lay-id'));
	    
	  });
	  
	   //头工具栏事件
       table.on('toolbar(test)', function(obj){
            if(obj.event === 'add'){
                xadmin.open('添加产品','../../manageros/cpzx/toAdd?parentId='+$("#parentId").val(),'','',true); //${pageContext.request.contextPath }
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
       if(obj.event === 'edit'){
          //打开编辑页面
          xadmin.open('编辑产品','../../manageros/cpzx/toUpdate?id='+data.id,'','',true); //${pageContext.request.contextPath }
          setTimeout(function(){
              layui.layer.tips('点击此处返回', '.layui-layer-setwin .layui-layer-close', {
              tips: 3
             });
          },500);
        }else if(obj.event === 'del'){
          //删除实现
          layer.confirm('确定删除吗？', function(index){
            $.ajax({ 
                url:"../../manageros/cpzx/del",
                data:{"id":data.id},
                type:'get',
                dataType:'json',
                success:function(data){
                    if(data > 0){
                        layer.alert('删除成功', { icon: 1, closeBtn: 0 }, function (index) { 
                            location.reload();
                        });
                        
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
    </body>
</html>
