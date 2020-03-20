<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-shopping-order.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/lay/modules/layer.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery.qrcode.min.js"></script>
</head>

<body data-spy="scroll" data-target="#articleNavbar" data-offset="150" >
    <!-- 页面头部 -->
    <!--头部导航-->
     <jsp:include page="/include/top.jsp"></jsp:include>
     
    <div class="container">
        <div class="learing-shopping-order">
            <div class="topTit">
                <h2>我的课程</h2>
            </div>
            <div class="cartCont">
                <div class="top">
                    <div class="csAbout">课程信息</div>
                </div>
                <div class="cont">
                	<c:forEach items="${result.data }" var="list"> 
                		<div class="item">
                        <div class="csAbout">
                        	<a href="${pageContext.request.contextPath }/course/courseDetail/${list.id }"> <img src="${pageContext.request.contextPath }/${list.pic}" width="160" height="90" alt="" ></a>
                            <div class="contInfo">
                                <p class="tit"><a href="${pageContext.request.contextPath }/course/courseDetail/${list.id }">${list.name }</a></span></p>
                                <p class="info">${list.content }</p>
                            </div>
                        </div>
                    </div>
                	</c:forEach>
                </div>
                
                <ul class="pagination"  style="border:0px red solid;">
				<li><a
					href="${pageContext.request.contextPath }/back/memeber/mycourse/${uid}?page=${result.page-1 <= 0 ? 1 : result.page-1}"
					aria-label="Previous"> <span aria-hidden="true">首页</span>
				</a></li>
				<li><a
					href="${pageContext.request.contextPath }/back/memeber/mycourse/${uid}?page=${result.page-1 <= 0 ? 1 : result.page-1 }">上一页</a></li>
				<li><a
					href="${pageContext.request.contextPath }/back/memeber/mycourse/${uid}?page=${result.page+1 >= result.totalPage ? result.totalPage : result.page+1}">下一页</a></li>
				<li><a
					href="${pageContext.request.contextPath }/back/memeber/mycourse/${uid}?page=${result.totalPage }"
					aria-label="Next"> <span aria-hidden="true">尾页</span>
				</a></li>
			</ul>
            </div>
        </div>
    </div>
    <!-- 页面底部 -->
    <!--底部版权-->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <div>
                        <!--<h1 style="display: inline-block">学成网</h1>--><img src="${pageContext.request.contextPath }/static/img/asset-logoIco.png" alt=""></div>
                    <div>学成网致力于普及中国最好的教育它与中国一流大学和机构合作提供在线课程。</div>
                    <div>© 2017年XTCG Inc.保留所有权利。-沪ICP备15025210号</div>
                    <input type="button" class="btn btn-primary" value="下 载" />
                </div>
                <div class="col-md-5 row">
                    <dl class="col-md-4">
                        <dt>关于学成网</dt>
                        <dd>关于</dd>
                        <dd>管理团队</dd>
                        <dd>工作机会</dd>
                        <dd>客户服务</dd>
                        <dd>帮助</dd>
                    </dl>
                    <dl class="col-md-4">
                        <dt>新手指南</dt>
                        <dd>如何注册</dd>
                        <dd>如何选课</dd>
                        <dd>如何拿到毕业证</dd>
                        <dd>学分是什么</dd>
                        <dd>考试未通过怎么办</dd>
                    </dl>
                    <dl class="col-md-4">
                        <dt>合作伙伴</dt>
                        <dd>合作机构</dd>
                        <dd>合作导师</dd>
                    </dl>
                </div>
            </div>
        </div>
    </footer>
    <!-- 页面 css js -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/js/bootstrap.js"></script>
    
</body>

</html>