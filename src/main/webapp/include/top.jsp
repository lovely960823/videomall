<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 页面头部 -->
<!--头部导航-->
<header>
    <div class="learingHeader">
        <nav class="navbar">
            <div class="">
                <div class="logo"><img src="${pageContext.request.contextPath }/static/img/asset-logoIco.png" width="100%" alt=""></div>
                <div class="nav-list">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="/" target="_blank">首页</a></li>
                        <li><a href="#">课程</a></li>
                        <li><a href="#">职业规划</a></li>
                        <li></li>
                    </ul>
                </div>

                <div class="sign-in">
                	<c:if test="${empty sessionScope.loginUser }">
                		<a href="${pageContext.request.contextPath }/toRegister">登录 </a> <span> | </span> <a href="${pageContext.request.contextPath }/toRegister"> 注册</a>
                	</c:if>
                    <!-- 未登录 -->
                    <!--<a href="#">登录 </a> <span> | </span> <a href="#"> 注册</a>-->
                    <!-- 登录 -->
				<c:if test="${not empty sessionScope.loginUser }">
					<a href="${pageContext.request.contextPath }/back/memeber/center/${sessionScope.loginUser.id }" class="personal">个人中心<span class="personalIco"></span></a> <a href="/back/memeber/center/${sessionScope.loginUser.id }"  class="myInfo"><img src="${sessionScope.loginUser.img }" alt=""> ${sessionScope.loginUser.username }</a>
				</c:if>
                </div>
                <div class="starch">
                	<form action="${pageContext.request.contextPath }/searchList" autocomplete="off" target="_blank">
                		<input type="text" class="input-search" placeholder="输入查询关键词" value="${param.name }" name="name"><input type="submit" class="search-buttom">
                	</form>
                </div>
            </div>
        </nav>
    </div>
</header>