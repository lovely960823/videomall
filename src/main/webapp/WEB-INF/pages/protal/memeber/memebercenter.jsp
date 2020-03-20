<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-personal.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
</head>

<body>
    <!-- 页面头部 -->
     <jsp:include page="/include/top.jsp"></jsp:include>
    <div class="personal-header" style="background-image: url(${pageContext.request.contextPath }/static/img/asset-banner.png);">
    </div>
    <!-- 页面 -->
    <div class="container">
        <div class="personal-nav pull-left">
            <div class="nav nav-stacked text-left">
                <div class="title">个人中心</div>
                <div class="my-ico">
                    <img src="${sessionScope.loginUser.img }" alt="">
                    <p>${sessionScope.loginUser.username }</p>
                </div>
                <div class="item">
                    <li ><a href="javascript:void(0)" onclick="mycourse()" class="glyphicon glyphicon-tower"> 我的课程<i class="pull-right">></i></a></li>
                    <li><a href="javascript:void(0)" onclick="myshopcar()" class="glyphicon glyphicon-shopping-cart"> 购物车<i class="pull-right">></i></a></li>
                    <li><a href="javascript:void(0)" onclick="myorder()" class="glyphicon glyphicon-list-alt"> 我的订单<i class="pull-right">></i></a> </li>
                    <li><a href="javascript:void(0)" onclick="myliked()" class="glyphicon glyphicon-heart"> 我的收藏<i class="pull-right">></i></a> </li>
                    <li><a href="" class="glyphicon glyphicon-cog"> 个人设置<i class="pull-right">></i></a></li>
                    <li><a href="/back/memeber/logout" class="glyphicon glyphicon-log-out"> 退出<i class="pull-right">></i></a></li>
                </div>
            </div>
        </div>
        <div class="personal-content pull-right">
            <div class="personal-cont">
                <div class="top">
                    <div class="tit"><span>最后一次观看</span></div>

                    <div class="top-cont">
                    	<c:if test="${empty detailList }">
                    		暂无
                    	</c:if>
                    	<c:if test="${not empty detailList }">
	                    	<c:forEach items="${detailList }" var="recently" begin="0" end="0">
		                        <div class="col-lg-8">
		                            <div class="imgIco"><img src="${pageContext.request.contextPath }/static/img/asset-timg.png" width="60" height="28" alt=""></div>
		                            <div class="title"><span class="lab" >继续学习</span>${recently.dname} <span class="status">学习中</span></div>
		                            <div class="about"><span class="lab">正在学习</span> ${recently.dname}  </div>
		                            <div class="rate">
		                                <li class="active"></li>
		                                <li></li>
		                                <li></li>
		                                <li></li><span>1/4 已完成部分</span> <span>进度25%</span></div>
		                        </div>
		                        <div class="division"></div>
		                        <div class="col-lg-4 text-right">
		                            <a href="${pageContext.request.contextPath }/course/courseVedio/${recently.id}" class="goLear" target="_blank"> 继续学习</a>
		                           <!--  <a href="#" class="evalu"> 课程评价</a> -->
		                            <div class="aft" style="top:0px;right:0px;">● ● ●
		                                <ul></ul>
		                            </div>
		                        </div>
		                        <div class="clearfix"></div>
	                    	</c:forEach>
                    	</c:if>
                    </div>
                </div>
                <div class="my-course">
                    <div class="title">
                        <div class="lab-title">最近观看</div>
                    </div>
                    <div class="cont">
                    	<c:if test="${empty detailList }">
                    		暂无
                    	</c:if>
                    
                    	<c:if test="${not empty detailList }">
                    		<c:forEach items="${detailList }" var="recently" begin="0" end="3">
		                        <div class="col-lg-6">
		                            <div class="item">
		                                <div class="imgIco"><img src="${pageContext.request.contextPath }/static/img/asset-timg.png" width="60" height="28" alt=""></div>
		                                <div class="title"><!-- <span class="lab">继续学习</span> 程序语言设计 <span class="status">学习中</span> -->
		                                    <div class="aft">● ● ●
		                                        <ul></ul>
		                                    </div>
		                                </div>
		                                <div class="about"><span class="lab">正在学习</span>${recently.dname} </div>
		                                <div class="time"></div>
		                                <div class="rate">
		                                    <li class="active"></li>
		                                    <li></li>
		                                    <li></li>
		                                    <li></li><span>1/4 已完成部分 <em>进度 25%</em></span></div>
		                                <div class="parting"></div>
		                                <div class="butItem text-center"><a href="${pageContext.request.contextPath }/course/courseVedio/${recently.id}" class="golearing" target="_blank">继续学习</a> <!-- <a href="#" class="classcom">课程评价</a> --></div>
		                            </div>
		                        </div>
                    		</c:forEach>
                    	</c:if>
                        
                        <div class="clearfix"></div>
                        <div class="help"><span class="">帮助和常见问题 ></span><span class="">问题反馈 ></span></div>
                    </div>
                </div>
                <div id="listcont">
                    <li><a href="#">课程成绩</a></li>
                    <li><a href="#">联系老师</a></li>
                    <li><a href="#">课程延期</a></li>
                    <li><a href="#">退出课程</a></li>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="/include/footer.jsp"></jsp:include>
    <!-- 页面 css js -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/js/bootstrap.js"></script>
    <script>
    	var uid='${sessionScope.loginUser.id}';
        $(function() {
            $('.aft').hover(function() {
                if (!$(this).hasClass('ac')) {
                    $(this).find('ul').html($('#listcont').html())
                    $(this).addClass('ac')
                } else {
                    $(this).find('ul').text('')
                    $(this).removeClass('ac')
                }
            })
        })


        $(function() {
            $(window).scroll(function() {
                if ($(this)[0].scrollY > 235) {
                    $('.personal-nav').css({
                        'position': 'fixed',
                        'top': 10
                    });
                } else if ($(this)[0].scrollY <= 155) {
                    $('.personal-nav').css({
                        'position': 'relative',
                        'top': -70
                    });
                };
            })
        })
        
        //我的购物车
        function myshopcar(){
        	window.open("${pageContext.request.contextPath }/back/memeber/myshopcar/"+uid);
        }
        //我的收藏
        function myliked(){
        	window.open("${pageContext.request.contextPath }/back/memeber/myliked/"+uid);
        }
        //我的课程
        function mycourse(){
        	window.open("${pageContext.request.contextPath }/back/memeber/mycourse/"+uid);
        }
		//我的订单
		function myorder(){
        	window.open("${pageContext.request.contextPath }/back/memeber/myorder/"+uid);
        } 
		function isView(detailid){
			//window.open("${pageContext.request.contextPath }/course/courseVedio/"+detailid);
		}
    </script>
</body>