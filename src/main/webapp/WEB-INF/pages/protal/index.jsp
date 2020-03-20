<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath }/static/img/asset-favicon.ico">
    <title>在线教育网</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/plugins/normalize-css/normalize.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-index.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
</head>

<body data-spy="scroll" data-target="#myNavbar" data-offset="150">

    <jsp:include page="/include/top.jsp"></jsp:include>
    <div class="banner-roll">
        <div class="banner-item">
            <c:forEach items="${lunboList }" var="lunboList">
            	<div class="item" style="background-image: url(${lunboList.img});"></div>
            </c:forEach>
        </div>
        <div class="indicators"></div>
    </div>
    <div class="container">
        <!--左侧列表导航-->
        <div class="travel-index-nav">
            <div class="citylistbox">
            	 <c:forEach items="${hxList }" var="hx" begin="0" end="9">
            	 	<div class="listbox">
                    <div class="list">
                        <dl><dt><a href="${pageContext.request.contextPath }/course/allCourse/${hx.id}" target="_blank" style="color: red">${hx.name }</a></dt></dl>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
        <div class="my-class-box">
            <div class="title">我的课程表</div>
            <div>
                <p>继续学习 程序语言设计</p>
                <p>正在学习-使用对象</p>
            </div>
            <div>
                <p>继续学习 程序语言设计</p>
                <p>正在学习-使用对象</p>
            </div>
            <div>
                <p>继续学习 程序语言设计</p>
                <p>正在学习-使用对象</p>
            </div>
            <div>
                <a href="#">全部课程</a>
            </div>
        </div>
        <div class="recommend-list">
            <div class="btn-group btn-group-justified">
                <li class="btn btn-primary title"><a href="${pageContext.request.contextPath }/course/allCourse/0" target="_blank">精品推荐</a></li>
                <c:forEach items="${hxList }" var="hx">
                	<li class="btn btn-primary"><a href="${pageContext.request.contextPath }/course/allCourse/${hx.id}" target="_blank">${hx.name }</a></li>
                </c:forEach>
            </div>
        </div>
        <div class="conten-list">
            <div class="Recommend">
                <div class="title">精品推荐<a href="javascript:void(0)" onclick="showAll('0')">查看全部</a></div>
                <div class="content" id="jingpintuijian">
                    <!-- 精品推荐 -->
                </div>
            </div>

            <div class="course-box">
                <div class="title">
                   Java
                    <div class="course-nav" >
                        <span class="active" onclick="showJava('1')">初级</span>
                        <span onclick="showJava('2')">中级</span>
                        <span onclick="showJava('3')">高级</span>
                    </div>
                    <a href="javascript:void(0)" onclick="showAll('1')">查看全部</a>
                </div>
                <div class="content">
                    <div class="cont-left">
                        <img src="${pageContext.request.contextPath }/static/img/widget-ind-left.png" width="100%" alt="">
                    </div>
                    <div class="cont-right" id="javaList">
                        <div><img src="${pageContext.request.contextPath }/static/img/widget-ind-top.png" width="100%" alt=""></div>
						<!-- JAVA -->
                    </div>
                </div>
            </div>

            <div class="course-box">
                <div class="title">
                   	人工智能
                    <div class="course-nav">
                        <span class="active" onclick="showAi('1')">初级</span>
                        <span onclick="showAi('2')">中级</span>
                        <span onclick="showAi('3')">高级</span>
                    </div>
                    <a href="javascript:void(0)" onclick="showAll('5')">查看全部</a>
                </div>
                <div class="content">
                    <div class="cont-left">
                        <img src="${pageContext.request.contextPath }/static/img/widget-ind-left1.png" width="100%" alt="">
                    </div>
                    <div class="cont-right" id="aiList">
                        <div><img src="${pageContext.request.contextPath }/static/img/widget-ind-top1.png" width="100%" alt=""></div>
						<!-- 人工智能 -->
                    </div>
                </div>
            </div>

            <div class="Recommend">
                <div class="title-class">
                    Python
                    <div class="course-nav">
                        <span class="active" onclick="showPython('1')">初级</span>
                        <span onclick="showPython('2')">中级</span>
                        <span onclick="showPython('3')">高级</span>
                    </div>
                    <a href="javascript:void(0)" onclick="showAll('3')">查看全部</a>
                </div>
                <div class="content" id="pythonList">
					<!-- Python -->
                </div>
            </div>


            <div class="Recommend">
                <div class="title-class">
                    前端开发工程师
                    <div class="course-nav">
                        <span class="active" onclick="showProtal('1')">初级</span>
                        <span onclick="showProtal('2')">中级</span>
                        <span onclick="showProtal('3')">高级</span>
                    </div>
                    <a href="javascript:void(0)" onclick="showAll('2')">查看全部</a>
                </div>
                <div class="content" id="protalList">
                    <!-- 前端 -->
                </div>
            </div>
        </div>
        <div class="index-cont-nav">
            <div id="myNavbar" class="collapse navbar-collapse ">
                <div id="myCollapse" class="collapse navbar-collapse">
                    <div class="logo-ico"><img src="${pageContext.request.contextPath }/static/img/asset-logoIco.png" alt=""></div>
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#a">编程入门</a></li>
                        <li><a href="#b">数据分析师</a></li>
                        <li><a href="#c">机器学习工程师</a></li>
                        <li><a href="#d">前端开发工程师</a></li>
                        <li><a href="#e">人工智能工程师</a></li>
                        <li><a href="#f">全栈工程师</a></li>
                        <li><a href="#g">iOS工程师</a></li>
                        <li><a href="#h">VR开发者</a></li>
                        <li><a href="#i">深度学习</a></li>
                        <li><a href="#j">商业预测分析师</a></li>
                        <li><a href="#k">Android开发工程师</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
    <div class="container">
        <div class="teacher-list text-center">
            <div class="title"> 牛人推荐 </div>
            <div class="first-box">
            	<c:forEach items="${godList }" var="god" begin="0" end="4">
            		<div class="teach-item">
                    <img src="${pageContext.request.contextPath }/${god.img}" width="100%" alt="">
                    <span class="lab">28555学习过</span>
                    <ul class="teach-info">
                        <li>${god.name}<span>Java EE</span></li>
                        <li>${god.descr}</li>
                    </ul>
                </div>
            	</c:forEach>
                <div class="clearfix"></div>
            </div>
            <div class="two-box">
                <div class="teach-item-adv">
                    <img src="${pageContext.request.contextPath }/static/img/widget-teach-adv.png" width="100%" alt="">
                </div>
                <c:forEach items="${godList }" var="god" begin="5" end="8">
                	<div class="teach-item">
                    <img src="${pageContext.request.contextPath }/${god.img}" width="100%" alt="">
                    <span class="lab">28555学习过</span>
                    <ul class="teach-info">
                        <li>${god.name}<span>Java EE</span></li>
                        <li>${god.descr}</li>
                    </ul>
                </div>
                </c:forEach>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <!-- 页面底部 -->
    <div class="gotop">
        <a href="#"><i class="glyphicon glyphicon-pencil"></i><span class="hide">问题反馈</span></a>
        <a href="#top"><i class="glyphicon glyphicon-plane"></i><span class="hide">返回顶部</span></a>
    </div>

	<jsp:include page="/include/footer.jsp"></jsp:include>
    
    <!-- 页面 css js -->

    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/js/bootstrap.js"></script>
    <script type="text/javascript">
        var tg = $('.banner-item .item');
        var num = 0;
        for (i = 0; i < tg.length; i++) {
            $('.indicators').append('<span></span>');
            $('.indicators').find('span').eq(num).addClass('active');
        }

        function roll() {
            tg.eq(num).animate({
                'opacity': '1',
                'z-index': num
            }, 1000).siblings().animate({
                'opacity': '0',
                'z-index': 0
            }, 1000);
            $('.indicators').find('span').eq(num).addClass('active').siblings().removeClass('active');
            if (num >= tg.length - 1) {
                num = 0;
            } else {
                num++;
            }
        }
        $('.indicators').find('span').click(function() {
            num = $(this).index();
            roll();
        });
        var timer = setInterval(roll, 3000);
        $('.banner-item').mouseover(function() {
            clearInterval(timer)
        });
        $('.banner-item').mouseout(function() {
            timer = setInterval(roll, 3000)
        });
    </script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/widget-travel-index-nav.js"></script>
    <script>
        $('.teach-item').hover(function() {
            $(this).find('.teach-info').animate({
                'height': '100%'
            }, 500);
        }, function() {
            $(this).find('.teach-info').animate({
                'height': '112px'
            }, 500);
        })


        $('.gotop a').hover(function() {
            $(this).find('span').removeClass('hide')
        }, function() {
            $(this).find('span').addClass('hide')
        })


        $(function() {
            $('.interest-box .interest-cont li').click(function() {
                if ($(this).hasClass('active')) {
                    $(this).removeClass('active');
                } else {
                    $(this).addClass('active');
                }
            })
            $('.mask').click(function() {
                $('.interest-box').hide();
            })
            $('.button .pres').click(function() {
                $('.interest-box').hide();
            })
            $('.button .skip').click(function() {
                $('.interest-box').hide();
            })
        })
    </script>
    <script src="${pageContext.request.contextPath }/static/js/page-learing-index.js"></script>
    <script type="text/javascript">
    //精品推荐
    function jingpinList(){
    	var result='';
		$.ajax({
        	url:"${pageContext.request.contextPath }/jingpinList",
        	data:{},
        	type:"GET",
        	success:function(data){
        		for(var i=0;i<data.length;i++){
        			result+='<div class="recom-item">'
        				+'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'">'
        				+'<p><img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="100%" alt=""><span class="lab">HOT</span></p>'
        				+'<ul>'
        				+'<li>'+data[i].name+' </li>'
        				+'<li><span>'+data[i].difficulty+'</span> <em> · </em>' +data[i].views+'人在学习</li>'
        				+'</ul>'
        				+'</a>'
        				+'</div>'
        		}
            $('#jingpintuijian').append(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
    jingpinList();
    
    
    //Java
    function showJava(lx){
    	var result='';
    	$('#javaList').html('');
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/javaList",
        	data:{"lx":lx},
        	type:"GET",
        	success:function(data){
        		for(var i=0;i<data.length;i++){
                result+='<div class="recom-item">'
	                +'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'">'
	                +'<p><img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="100%" alt=""></p>'
	                +'<ul>'
	                +'<li>'+data[i].name+' </li>'
	                +'<li><span>'+data[i].difficulty+'</span> <em> · </em> '+data[i].views+'人在学习</li>'
	                +'</ul>'
	                +'</a>'
	                +'</div>'
        		}
        		$('#javaList').append(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
    showJava(1);
    
    //人工智能
     function showAi(lx){
    	var result='';
    	$('#aiList').html('');
    	$('#aiList').append('<div><img src="${pageContext.request.contextPath }/static/img/widget-ind-top1.png" width="100%" alt=""></div>');
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/aiList",
        	data:{"lx":lx},
        	type:"GET",
        	success:function(data){
        		for(var i=0;i<data.length;i++){
                result+='<div class="recom-item">'
	                +'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'">'
	                +'<p><img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="100%" alt=""></p>'
	                +'<ul>'
	                +'<li>'+data[i].name+' </li>'
	                +'<li><span>'+data[i].difficulty+'</span> <em> · </em> '+data[i].views+'人在学习</li>'
	                +'</ul>'
	                +'</a>'
	                +'</div>'
        		}
        		$('#aiList').append(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
     showAi(1);
     
     //Python
      function showPython(lx){
    	var result='';
    	$('#pythonList').html('');
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/pythonList",
        	data:{"lx":lx},
        	type:"GET",
        	success:function(data){
        		for(var i=0;i<data.length;i++){
                result+='<div class="recom-item">'
	                +'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'">'
	                +'<p><img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="100%" alt=""></p>'
	                +'<ul>'
	                +'<li>'+data[i].name+' </li>'
	                +'<li><span>'+data[i].difficulty+'</span> <em> · </em> '+data[i].views+'人在学习</li>'
	                +'</ul>'
	                +'</a>'
	                +'</div>'
        		}
        		$('#pythonList').append(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
      showPython(1);
      //前端
      function showProtal(lx){
    	var result='';
    	$('#protalList').html('');
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/protalList",
        	data:{"lx":lx},
        	type:"GET",
        	success:function(data){
        		for(var i=0;i<data.length;i++){
                result+='<div class="recom-item">'
	                +'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'">'
	                +'<p><img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="100%" alt=""></p>'
	                +'<ul>'
	                +'<li>'+data[i].name+' </li>'
	                +'<li><span>'+data[i].difficulty+'</span> <em> · </em> '+data[i].views+'人在学习</li>'
	                +'</ul>'
	                +'</a>'
	                +'</div>'
        		}
        		$('#protalList').append(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
      showProtal(1);
      //查看全部
      function showAll(lx){
    	  //window.location.href="${pageContext.request.contextPath }/course/allCourse?lx="+lx;
    	  window.open("${pageContext.request.contextPath }/course/allCourse/"+lx);
      }
      
      //控制样式,点击样式
      $(document).ready(function(){
    	  $('span').click(function(){
    		 $(this).addClass('active');
    		 $(this).siblings('span').removeClass('active');
    	  })
      })
    </script>
</body>


