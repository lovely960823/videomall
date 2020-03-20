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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-article.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/lay/modules/layer.js"></script>
    <style type="text/css">
	/*  点击加载更多    */
	.clickbtn {
		border: 0px red solid;
		text-align: center;
		width: 100%;
		height: 40px;
		line-height: 40px;
		margin-top: 10px;
		margin-bottom: 20px
	}
	
	.clickbtn .clickbtn_btn {
		display: none;
		border: 0px red solid;
		background: #fafafa;
		margin: 0px auto;;
		width: 120px;
		height: 40px;
		line-height: 40px
	}
	
	.clickbtn .clickbtn_btn_nomore {
		display: none;
		border: 0px red solid;
		background: #fafafa;
		margin: 0px auto;;
		width: 120px;
		height: 40px;
		line-height: 40px
	}
	
	.clickbtn .clickbtn_btn:hover {
		cursor: pointer;
		color: #0a7840
	}
	
	/*  加载 动画  */
	.clickbtn .loading {
		border: 0px solid #D0D0D0;
		text-indent: 20px;
		margin: 0px auto;
		display: none;
		width: 125px;
		height: 32px;
		line-height: 32px;
		color: #494A5F;
		font-size: 12px;
		background: url("${pageContext.request.contextPath }/static/img/loading.gif") no-repeat 8px 8px;
	}
	</style>
</head>

<body data-spy="scroll" data-target="#articleNavbar" data-offset="150">
    <!-- 页面头部 -->
    <!--头部导航-->
    <jsp:include page="/include/top.jsp"></jsp:include>
    
    <div class="article-banner">
        <div class="banner-bg"></div>
        <div class="banner-info">
            <div class="banner-left">
                <p>课程 <span>\ 编程入门</span></p>
                <p class="tit">${course.name }</p>
                <p class="pic"><span class="new-pic">特惠价格￥${course.discountPrice }</span> <span class="old-pic">原价￥${course.price }</span></p>
                <p class="info">
                    <a href="javascript:void(0)" onclick="studyNow()">马上学习</a>
                    <span><em>难度等级</em>${course.difficulty }</span>
                    <span><em>课程时长</em>${course.duration}</span>
                    <span><em>评分</em>4.7分</span>
                    <span><em>授课模式</em>录播</span>
                </p>
            </div>
            <div class="banner-rit">
                <p><a href="javascript:void(0)" onclick="studyNow()"> <img src="${pageContext.request.contextPath }/static/img/widget-video.png" alt=""> </a></p>
                <p class="vid-act"><span> <i class="i-heart"></i><a onclick="shoucang()">收藏</a>  </span> <span onclick="shareWb()">分享到微博<!-- <i class="i-weixin"></i><i class="i-qq" onclick="shareQQ()"></i> --></span></p>
            </div>
        </div>
    </div>
    <div class="article-cont">
        <div class="tit-list">
            <a href="javascript:;" id="articleClass" class="active">课程介绍</a>
            <a href="javascript:;" id="articleItem" onclick="showMulu()">目录</a>
            <a href="javascript:;" id="artcleCod">评价</a>
            <div class="down-fill">
                <span  onclick="addToCart()">加入购物车</span>
            </div>
        </div>
        <div class="article-box">
            <div class="articleClass" style="display: block">
                <div class="rit-title">评价</div>
                <div class="article-cont">
                    <div class="article-left-box">
                        <div class="content">
                            <div class="content-com about">
                                <div class="title"><span>课程介绍</span></div>
                                <div class="cont cktop">
                                    <div class="drop-down">
                                        <p>${course.content}</p>
                                    </div>
                                    <span class="on-off">更多 <i class="i-chevron-bot"></i></span>
                                </div>
                            </div>
                            <div class="content-com suit">
                                <div class="title"><span>适用人群</span></div>
                                <div class="cont cktop">
                                    <div class="drop-down">
                                        <p>本课程假设学生熟悉大多数入门课程所涉及的程序，但它被明确设计成不是一门特别高级的课程。学生应该熟悉变量，条件语句，数组，链表，栈，和递归（递归算法将审查和扩展），和一个接口和实现之间的区别。学生应该渴望用新的语言编写程序。本课程C部分分析了面向对象的基本概念和对比他们的其他语言，用java或密切相关的语言如此熟悉（例如，C #）可能有助于C部分，但它是没有必要的作业。本课程是基于专为第二和第三年本科生设计的课程：不是第一个计算机科学课程，但不是一个高级课程。因此，它当然不会涵盖在编程语言的美丽世界的一切，但它是一个坚实的介绍。它的目的是大开眼界和迷人的学习者寻求“第三或第四编程课程”，并为有更多的经验，谁正在寻找一个明确和精确的编程语言基础的学习者。课程中的作业设计是具有挑战性的，但课程内容需要你所需要的一切。</p>
                                    </div>
                                    <span class="on-off">更多 <i class="i-chevron-bot"></i></span>
                                </div>
                            </div>
                            <div class="content-com course">
                                <div class="title"><span>课程制作</span></div>
                                <div class="cont">
                                    <div class="img-box"><img src="${pageContext.request.contextPath }/${course.teacher.tPic}" alt="" width="120px;"height="120px;"></div>
                                    <div class="info-box">
                                        <p class="name">教学方：<em>${course.teacher.name }</em></p>
                                        <p class="lab">${course.teacher.tZc }&nbsp;${course.teacher.tJy }</p>
                                        <p class="info">${course.teacher.tContent }</p>
                                        <p><span>难度等级</span>${course.difficulty}</p>
                                        <p><span>课程时长</span>8-16小时/周，共4周</p>
                                        <p><span>如何通过</span>通过所有的作业及考核，作业共4份，考核为一次终极考核</p>
                                        <p><span>用户评分</span>平均用户评分 <em>4.9</em> <a href="#">查看全部评价</a></p>
                                        <p><span>课程价格</span>特惠价格<em>￥999</em> <i> 原价1999 </i></p>
                                    </div>
                                </div>
                            </div>
                            <div class="content-com prob">
                                <div class="title"><span>常见问题</span></div>
                                <div class="cont">
                                    <ul>
                                        <li class="item"><span class="on-off"><i class="i-chevron-bot"></i> 我什么时候能够访问课程视频与作业？</span>
                                            <div class="drop-down">
                                                <p>课程安排灵活，课程费用支付提供180天全程准入和资格证书。自定进度课程建议的最后期限，但你不会受到惩罚错过期限，只要你赚你的证书在180天内。以会话为基础的课程可能要求你在截止日期前保持正轨，但如果你落后了，你可以切换到以后的会议，你完成的任何工作将与你转移。</p>
                                            </div>
                                        </li>
                                        <li class="item"><span class="on-off"><i class="i-chevron-bot"></i> 如何需要额外的时间来完成课程会怎么样？</span>
                                            <div class="drop-down">
                                                <p>课程安排灵活，课程费用支付提供180天全程准入和资格证书。自定进度课程建议的最后期限，但你不会受到惩罚错过期限，只要你赚你的证书在180天内。以会话为基础的课程可能要求你在截止日期前保持正轨，但如果你落后了，你可以切换到以后的会议，你完成的任何工作将与你转移。</p>
                                            </div>
                                        </li>
                                        <li class="item"><span class="on-off"><i class="i-chevron-bot"></i> 我支付次课程之后会得到什么？</span>
                                            <div class="drop-down">
                                                <p>课程安排灵活，课程费用支付提供180天全程准入和资格证书。自定进度课程建议的最后期限，但你不会受到惩罚错过期限，只要你赚你的证书在180天内。以会话为基础的课程可能要求你在截止日期前保持正轨，但如果你落后了，你可以切换到以后的会议，你完成的任何工作将与你转移。</p>
                                            </div>
                                        </li>
                                        <li class="item"><span class="on-off"><i class="i-chevron-bot"></i> 退款条例是如何规定的？</span>
                                            <div class="drop-down">
                                                <p>课程安排灵活，课程费用支付提供180天全程准入和资格证书。自定进度课程建议的最后期限，但你不会受到惩罚错过期限，只要你赚你的证书在180天内。以会话为基础的课程可能要求你在截止日期前保持正轨，但如果你落后了，你可以切换到以后的会议，你完成的任何工作将与你转移。</p>
                                            </div>
                                        </li>
                                        <li class="item"><span class="on-off"><i class="i-chevron-bot"></i> 有助学金？</span>
                                            <div class="drop-down">
                                                <p>课程安排灵活，课程费用支付提供180天全程准入和资格证书。自定进度课程建议的最后期限，但你不会受到惩罚错过期限，只要你赚你的证书在180天内。以会话为基础的课程可能要求你在截止日期前保持正轨，但如果你落后了，你可以切换到以后的会议，你完成的任何工作将与你转移。</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="article-right-box">
                        <div class="comment">
                            <!--<div class="tit">评论</div>-->
                            <div class="com-cont" id="fivePl">
                            	<!-- 右边五条评价 -->
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="articleItem" style="display: none">
                <div class="article-cont-catalog">
                    <div class="article-left-box">
                        <div class="content" id="muluList">
                       		<!-- 目录列表 -->
                        </div>
                    </div>
                    <div class="article-right-box">
                        <div class="about-teach">
                            <div class="teach-info">
                                <img src="${pageContext.request.contextPath }/${course.teacher.tPic }" width="90px" alt="">
                                <div>
                                    <p>教学方：<span>${course.teacher.name }</span></p>
                                    <p class="about">${course.teacher.tZc }${course.teacher.tJy }</p>
                                </div>
                            </div>
                            <p><a href="#" class="">TA的课程</a></p>
                            <p class="synopsis">${course.teacher.tContent }</p>
                        </div>
                        <div class="learing-box">
                            <div class="tit">看过该课的同学也在看</div>
                            <div class="item-box">
                                <div class="item-list hov">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Linux 达人养成记</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Linux 达人养成记111</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Java消息中间件</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Hibernate Validator</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>ASP.NET-MVC网站开发</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Android架构模式详解之MVC…</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Web前端攻城狮培养计划</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Linux 达人养成记</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Java消息中间件</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Java消息中间件</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Java消息中间件</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>Hibernate Validator</a>
                                    </div>
                                </div>
                                <div class="item-list">
                                    <div class="infobox">
                                        <div class="morebox">
                                            <p class="top-tit">前端小白入门</p>
                                            <p class="top-lab">Java消息中间件</p>
                                            <p class="top-num">2589646次播放<span>4.8分</span></p>
                                        </div>
                                        <a>ASP.NET-MVC网站开发</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="artcleCod" style="display: none;">
                <div class="article-cont">
                    <div class="article-left-box">
                        <div class="comment-box">
                            <div class="evaluate">
                                <div class="eva-top">
                                    <div class="tit">课程评分 </div>
                                    <div class="star">
                                        <div class="score"><i>5</i></div>
                                    </div><span class="star-score"> <i id="coursescore">5</i> 分</span></div>
                                <div class="eva-cont">
                                    <div class="tit">学员评语 </div>
                                    <div class="text-box">
                                        <textarea class="form-control" rows="5" placeholder="扯淡、吐槽、表扬、鼓励......想说啥说啥！" id="coursecontent"></textarea>
                                        <div class="text-right"><span onclick="pubPl()">发表评论</span></div>
                                    </div>
                                </div>
                            </div>
                            <div class="course-evaluate">
                                <div class="top-cont">
                                    
                                </div>
                                <div class="comment-item-box" >
                                    <div class="title">评论 <span>12453条评论</span></div>
                                    
	                               <div id="pldata"><!-- 存放评论数据的容器 -->
	                               
                                   </div>
	                                 
	                                <!-- 加载查询 -->
									<div class="clickbtn">
										<div id="loading" class="loading">数据加载中...</div>
										<p class="clickbtn_btn" onclick="findAllplAjax('more')">点击加载更多</p>
									</div>
									<!-- 加载查询 -->
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="article-right-box">
                        <div class="about-teach">
                            <div class="teach-info">
                                <img src="${pageContext.request.contextPath }/${course.teacher.tPic}" width="90px" alt="">
                                <div>
                                    <p>教学方：<span>${course.teacher.name }</span></p>
                                    <p class="about">${course.teacher.tZc }&nbsp;${course.teacher.tJy }</p>
                                </div>
                            </div>
                            <p><a href="#" class="">TA的课程</a></p>
                            <p class="synopsis">${course.teacher.tContent }</p>
                        </div>
                        <div class="learing-box">
                            <div class="tit">看过该课的同学也在看</div>
                            <div class="item-box">
                                <div class="item-top">
                                    <p class="top-tit">前端小白入门</p>
                                    <p class="top-lab">Web前端攻城狮培养计划</p>
                                    <p class="top-num">2589646次播放<span>4.8分</span></p>
                                </div>
                                <div class="item-list">
                                    <a>Linux 达人养成记</a>
                                    <a>Java消息中间件</a>
                                    <a>Hibernate Validator</a>
                                    <a>ASP.NET-MVC网站开发</a>
                                    <a>Android架构模式详解之MVC…</a>
                                    <a>Linux 达人养成记</a>
                                    <a>Java消息中间件</a>
                                    <a>Hibernate Validator</a>
                                    <a>ASP.NET-MVC网站开发</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="popup-box">
        <div class="mask" id="mask"></div>
        <!--欢迎访问课程弹窗- start -->
        <div class="popup-course-box">
            <div class="title">程序设计语言 <span class="close-popup">×</span></div>
            <div class="content">
                <p>欢迎学习本课程，您现在可以访问课程材料了。</p>
                <p><a href="#">开始学习</a></p>
            </div>
        </div>
        <!--欢迎访问课程弹窗- end -->

        <!--支付弹窗- start -->
        <div class="popup-pay-box">
            <div class="title">${course.name } <span class="close-popup">×</span></div>
            <div class="content">
                <img src="./text.png" alt="">
                <div class="info">
                    <p class="info-tit">${course.name } <span>课程有效期:永久有效</span></p>
                    <p class="info-pic">课程价格 : <span>${course.price }</span></p>
                    <p class="info-new-pic">优惠价格 : <span>${course.discountPrice }</span></p>
                </div>
            </div>
            <div class="fact-pic">实际支付: <span>￥${course.discountPrice }</span></div>
            <div class="go-pay"><a href="javascript:void(0)" onclick="toPay()">去支付</a><a class="addCar" href="javascript:void(0)" onclick="addToCart()">加入购物车</a></div>
        </div>
        <!--支付弹窗- end -->
        <div class="popup-comment-box">

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
    //判断弹出框是否隐藏
    var isShopped='${isShopped}';
	if(isShopped==0){
		
	}
	if(isShopped==1){
		//document.getElementById("mask").style.display ='none';
		$('.popup-box').hide();
	}
    
        $('.vid-act').click(function() {
            $(this).find('.i-heart').css('background-position', '4px -55px')
        })


        $(function() {
            //点击下拉
            //用法：HTML 点击事件为more,父级使用overflow：hidden；限定高 more与要展开的内容为同级 要展开内容添加 drop-down的class
            function ckMove(target, ckgar, het, text, incr) {
                var inc = incr ? incr : 0;
                $(target).find(ckgar).on('click', function() {
                    var h = $(this).parent().find('.drop-down ul').height();
                    if (!$(this).hasClass('act')) {
                        $(this).addClass('act');
                        $(this).parent().find('.drop-down').css({
                            'height': (h + inc) + 'px'
                        });
                        $(this).find('i').removeClass('i-chevron-bot').addClass('i-chevron-top')
                    } else {
                        $(this).removeClass('act');
                        $(this).parent().find('.drop-down').css({
                            'height': het + 'px'
                        });
                        $(this).find('i').removeClass('i-chevron-top').addClass('i-chevron-bot')
                    }
                })
            }
            ckMove('.article-cont .article-left-box', '.title', 0);

            $('.learing-box .item-list').mouseover(function(e) {
                $(this).css({
                    'height': '140px'
                }).addClass('hov').siblings().css({
                    'height': '50px'
                })
                $(this).siblings().removeClass('hov')
            })
            $('.learing-box .item-box').mouseout(function() {
                $(this).find('.item-list:first').css({
                    'height': '140px'
                }).addClass('hov')
                $(this).find('.item-list:first').siblings().css({
                    'height': '50px'
                }).removeClass('hov')
            })
        })


        $(function() {
            $('.learing-box .item-list').mouseover(function(e) {
                $(this).css({
                    'height': '140px'
                }).addClass('hov').siblings().css({
                    'height': '50px'
                })
                $(this).siblings().removeClass('hov')
            })
            $('.learing-box .item-box').mouseout(function() {
                $(this).find('.item-list:first').css({
                    'height': '140px'
                }).addClass('hov')
                $(this).find('.item-list:first').siblings().css({
                    'height': '50px'
                }).removeClass('hov')
            })
        })


        $(function() {
            $('.active-box span').click(function() {
                $(this).css({
                    'color': '#00a4ff'
                })
                if ($(this).find('i').hasClass('i-laud')) {
                    $(this).find('.i-laud').css('background-position', '-80px -19px')
                } else if ($(this).find('i').hasClass('i-coll')) {
                    $(this).find('.i-coll').css('background-position', '1px -75px')
                }
            })
            $('.learing-box .item-list').mouseover(function(e) {
                $(this).css({
                    'height': '140px'
                }).addClass('hov').siblings().css({
                    'height': '50px'
                })
                $(this).siblings().removeClass('hov')
            })
            $('.learing-box .item-box').mouseout(function() {
                $(this).find('.item-list:first').css({
                    'height': '140px'
                }).addClass('hov')
                $(this).find('.item-list:first').siblings().css({
                    'height': '50px'
                }).removeClass('hov')
            })
        })


        $(function() {
            //评分
            $('.star .score').map(function(n, i) {
                var x = Number($(this).find('i').text());
                var w = 109 * (1 - x / 5);
                $(this).css('width', w + 'px');
            })
            //评论打分
            $('.evaluate .star').mousemove(function(e) {
                var startX = $(this).offset().left;
                var movX = e.clientX - startX + 0.5;
                var w = 145 * (1 - movX / 145);
                $(this).find('.score').css('width', w + 'px');
                $('.star-score i').text((movX / 145 * 5).toFixed(1))
            })
            //星级评分
            $('.grade').map(function(n, i) {
                var pret = $(this).find('.percent-num i').text();
                var wt = $(this).find('.grade-percent').width();
                $(this).find('.grade-percent span').css('width', wt * pret / 100);
            })



        })


        $(function() {
            //点击下拉
            function ckMove(target, het, text, incr) {
                var inc = incr ? incr : 0;
                $(target).find('.on-off').on('click', function() {
                    var h = $(this).parent().find('.drop-down p').height();
                    if (!$(this).hasClass('act')) {
                        $(this).addClass('act');
                        $(this).parent().find('.drop-down').css({
                            'height': (h + inc) + 'px'
                        });
                        $(this).find('i').removeClass('i-chevron-bot').addClass('i-chevron-top')
                    } else {
                        $(this).removeClass('act');
                        $(this).parent().find('.drop-down').css({
                            'height': het + 'px'
                        });
                        $(this).find('i').removeClass('i-chevron-top').addClass('i-chevron-bot')
                    }
                })
            }
            ckMove('.cktop', 60);
            ckMove('.cont .item', 0);
            //点击关闭弹窗
            $('.close-popup').click(function() {
                $('.popup-box').hide();
            })
            $('.tit-list a').click(function() {
                $(this).addClass('active').siblings().removeClass('active');
                var clasNod = '.' + $(this)[0].id
                $(clasNod).show().siblings().hide()
            })
            // 资料下载
            $('.down-fill span').click(function() {
                $('.down-fill ul').css({
                    display: 'block'
                });
            })
            $('.down-fill ul li').click(function() {
                $('.down-fill ul').css({
                    display: 'none'
                });
            })
        })
    </script>
    <script type="text/javascript">
    var id='${course.id}';//该课程id
    var uid='${sessionScope.loginUser.id}';
    var page = 1;
    	function showMulu(){
    		$('#muluList').html('');
    		var result='';
    		$.ajax({
            	url:"${pageContext.request.contextPath }/courseDetail/muluList",
            	data:{"id":id},
            	type:"GET",
            	success:function(data){
            		for(var i=0;i<data.length;i++){
            			result+='<div class="item">'
            				+'<div class="title"><i class="i-chevron-bot"></i><span  onclick="isView('+data[i].id+')">'+data[i].dname+'</span></div>'
            				+'<div class="about">'+data[i].dcontent+'</div>'
            				+'</div>'
            		}
                $('#muluList').append(result);
            	},
            	error:function(){
            		alert("服务器忙");
            	},
            	dataType:"json"
            });
    	}
    	
    	//评论发表
    	function pubPl(){
    		if(uid==null||uid==""){
    			layer.confirm('请您先登陆', function(index){
    	            window.location.href="${pageContext.request.contextPath }/toRegister";
              });
    			return ;
    		}
    		var score=$('#coursescore').html();
    		var contents=$('#coursecontent').val();
    		if(contents==null||contents==""){
    			layer.alert('请输入您想说的话');
    			return ;
    		}
    		$.ajax({
            	url:"${pageContext.request.contextPath }/pl/pubPl",
            	data:{"cid":id,"uid":uid,"score":score,"contents":contents},
            	type:"GET",
            	success:function(data){
            		if(data>0){
            			layer.open({
            				time:1000,
            				content:"<span>评论成功</span>"
            			})
            			$('#coursecontent').val('');
            			findAllplAjax('init');
            		}
            	},
            	error:function(){
            		alert("服务器忙");
            	},
            	dataType:"json"
            });
    	}
    	
    	//评论数据   再次点击会重复问题待解决
    	function findAllplAjax(flag) {
		if(flag =="init"){
            $("#pldata").html("");//查询数据前清空展示的ul
            page = 10;
        }
		var result = '';//要展示的信息
		$('#loading').show();//数据加载中loading展示
        $('.clickbtn_btn').hide();//加载更多按钮隐藏
		$.ajax({
			url : "${pageContext.request.contextPath }/pl/plMessage",
			data : {
				"page" : page,
				"limit" : 10,
				"cid" : id,
				"uid":uid
			},
			type : "POST",
			success : function(rs) {
				//数据写入
				page = rs.page + 1;
				var data = rs.data;
				if(data.length>0){
					  for (var i = 0; i < data.length; i++) {
		                      result+='<div class="item">'
		                      +'<div class="item-left">'
		                      +'<p><img src="'+data[i].user.img+'" width="60px" alt=""></p>'
		                      +'<p>'+data[i].user.username+'</p>'
		                      +'</div>'
		                      +'<div class="item-cent">'
		                      +'<p>'+data[i].content+'</p>'
		                      +'<p class="time">'+data[i].createTime+'</p>'
		                      +'</div>'
		                      +'<div class="item-rit">'
		                      +'<p>'
		                      +'<div class="star-show">'
		                      +'<div class="score"><i>5</i></div>'
		                      +'</div>'
		                      +'</p>'
		                      +'<p>评分 <span>'+data[i].score+'星</span></p>'
		                      +'</div>'
		                      +'</div>'
				 		  }
						  $('#pldata').append(result);//根据class获取第一个元素填充数据
	                      $('#loading').hide();//数据加载中loading隐藏
	                      $('.clickbtn_btn').show();//加载更多按钮展示
	                      if(data.length<10){
	                         $('.clickbtn').html("暂无更多数据");
	                      }  
				}else{
					 $('.clickbtn').html("暂无数据");
				 } 
			},
			error : function() {
				layer.alert("服务器忙");
			},
			dataType : "json"
		});

	}
	findAllplAjax('more');
	
	//添加购物车
	function addToCart(){
		if(uid==null||uid==""){
			/* layer.alert('请先登陆');
			return ; */
		 layer.confirm('请您先登陆', function(index){
	            window.location.href="${pageContext.request.contextPath }/toRegister";
          });
			return ;
		}
		$.ajax({
        	url:"${pageContext.request.contextPath }/back/car/shopcar",
        	data:{"cid":id,"uid":uid},
        	type:"GET",
        	success:function(data){
        		if(data==0){
        			layer.open({
        				time:800,
        				content:"<span>该商品已购买过</span>"
        			})
        		}else if(data==1){
        			layer.open({
        				time:800,
        				content:"<span>购物车已经存在该商品</span>"
        			})
        		}else if(data==2){
        			layer.open({
        				time:800,
        				content:"<span>已经添加到购物车当中</span>"
        			})
        		}
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
	
	//详情进来的时候加载的评价，取五条
	function findFivePl(){
		var result='';
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/fivePl",
        	data:{"cid":id},
        	type:"GET",
        	success:function(data){
        		if(data.length>0){
        			for(var i=0;i<data.length;i++){
        				result+=''
        	        		+'<div class="item">'
        	        		+'<div class="top-info"><img src="'+data[i].user.img+'" width="30px" alt="">'
        	        		+'<div class="info">'
        	        		+'<p>'+data[i].user.username+'</p>'
        	        		+'<p><i class="i-star"></i><i class="i-star"></i><i class="i-star"></i></p>'
        	        		+'</div>'
        	        		+'<div class="time">'+data[i].createTime+'</div>'
        	        		+'</div>'
        	        		+'<div class="but-info"><span>'+data[i].content+'</span></div>'
        	        		+'</div>'
        			}
        		}else{
	        		result+=''
	        		+'<div class="item">'
	        		+'<div class="top-info"><img src="${pageContext.request.contextPath }/static/img/widget-pic.png" width="30px" alt="">'
	        		+'<div class="info">'
	        		+'<p>毛老师</p>'
	        		+'<p><i class="i-star"></i><i class="i-star"></i><i class="i-star"></i></p>'
	        		+'</div>'
	        		+'<div class="time">2017-2-19</div>'
	        		+'</div>'
	        		+'<div class="but-info"><span>有趣的课程，可以对函数式编程产生初步的认识，值的一学。获得的毕业证书……</span></div>'
	        		+'</div>'
        		}
        		$('#fivePl').html(result);
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
	findFivePl();
	
	//收藏
	function shoucang(){
		if(uid==""||uid==null){
			layer.confirm('请您先登陆', function(index){
	            window.location.href="${pageContext.request.contextPath }/toRegister";
          });
			return ;
		}
		$.ajax({
        	url:"${pageContext.request.contextPath }/course/shoucang",
        	data:{"cid":id,"uid":uid},
        	type:"GET",
        	success:function(data){
        		if(data==true){
        			layer.open({
        				time:800,
        				content:"<span>已经取消收藏</span>"
        			})
        		}else if(data==false){
        			layer.open({
        				time:800,
        				content:"<span>收藏成功</span>"
        			})
        		}
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
	
	//点击看视频
	function isView(detailid){
		if(uid==null||uid==""){
			layer.confirm('请您先登陆', function(index){
	            window.location.href="${pageContext.request.contextPath }/toRegister";
          });
			return ;
		}
		$.ajax({
        	url:"${pageContext.request.contextPath }/back/isview",
        	data:{"cid":id,"uid":uid},
        	type:"GET",
        	success:function(data){
        		if(data==0){
        			window.open("${pageContext.request.contextPath }/course/courseVedio/"+detailid);
        		}else{
        			layer.alert('请先付费后再进行观看');
        		}
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
	//去支付
	function toPay(){
		if(uid==""||uid==null){
			layer.confirm('请您先登陆', function(index){
	            window.location.href="${pageContext.request.contextPath }/toRegister";
          });
			return ;
		}
		$.ajax({
        	url:"${pageContext.request.contextPath }/back/car/shopcar",
        	data:{"cid":id,"uid":uid},
        	type:"GET",
        	success:function(data){
        		if(data==0){
        			layer.open({
        				time:800,
        				content:"<span>该商品已购买过</span>"
        			})
        		}else if(data==1){
        			window.open("${pageContext.request.contextPath }/back/memeber/myshopcar/"+uid);
        		}else if(data==2){
        			window.open("${pageContext.request.contextPath }/back/memeber/myshopcar/"+uid);
        		}
        	},
        	error:function(){
        		alert("服务器忙");
        	},
        	dataType:"json"
        });
	}
	var sharepic='${sessionScope.loginUser.img}';
	function shareWb(){
		//新浪微博
		var title='网课商城';
		var url = window.location.href;
		window.open("http://v.t.sina.com.cn/share/share.php?appkey=4120396272&title=" + encodeURIComponent(title)+"&url="+encodeURIComponent(url));
	}
	
	//马上学习
	function studyNow(){
		var detailid = '${courseDetail.id}';
		isView(detailid);
	}
    </script>
</body>