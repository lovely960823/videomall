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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-list.css" />
</head>

<body>
    <!-- 页面头部 -->
    <!--头部导航-->
     <jsp:include page="/include/top.jsp"></jsp:include>
     
    <div class="container">
        <div class="row">
            <div class="col-md-9 list-row-left">
                <div class="list-cont-left">
                    <div class="tab-content">
                        <div class="content-list">
                        	<c:forEach items="${list }" var="list">
                        		<div class="recom-item">
                                <a href="${pageContext.request.contextPath }/course/courseDetail/${list.id }">
                                    <p><img src="${pageContext.request.contextPath }/${list.pic}" width="100%" alt=""><span class="lab">HOT</span></p>
                                    <ul>
                                        <li>${list.name }</li>
                                        <li><span>${list.difficulty }</span> <em> · </em>${list.views }人在学习</li>
                                    </ul>
                                </a>
                            </div>
                        	</c:forEach>
                            <li class="clearfix"></li>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-3 list-row-rit">
                <div class="list-cont-right">
                    <div class="right-box">
                        <div class="tit">精品TOP榜</div>
                        <div class="contList">
                            <div class="contList-item">
                                <div class="box hov">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                            <div class="contList-item">
                                <div class="box">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                            <div class="contList-item">
                                <div class="box">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                            <div class="contList-item">
                                <div class="box">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                            <div class="contList-item">
                                <div class="box">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                            <div class="contList-item">
                                <div class="box">
                                    <div class="info">
                                        <p>Think PHP 5.0 博客系统实战项目演练</p>
                                        <li><span>高级</span> <em> · </em> 1125人在学习</li>
                                    </div>
                                    <div class="infoImg">
                                        <div><img src="${pageContext.request.contextPath }/static/img/widget-topBg.png" width="100%" height="110" alt=""></div>
                                        <div class="desc">通过对ThinkPHP框架基础，带领大家由浅入深轻松掌握ThinkPHP的理论基础，更加全面的掌握ThinkPHP框架运行机制……</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    <script>
        $('.list-box ol li').on('click', function() {
            $(this).addClass('active');
            $(this).siblings().removeClass('active');
        })


        $('.list-cont-left .nav-tabs li').on('click', function() {
            $(this).addClass("active").siblings().removeClass('active');
        })


        $('.contList-item').hover(function() {
            $(this).find('.box').addClass('hov').parent().siblings().find('.box').removeClass('hov')
        }, function() {
            $(this).siblings().first().find('.box').addClass('hov').parent().siblings().find('.box').removeClass('hov')
        })
    </script>
</body>