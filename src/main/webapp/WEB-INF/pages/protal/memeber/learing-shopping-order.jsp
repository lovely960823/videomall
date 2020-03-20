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
                <h2>订单提交</h2>
            </div>
            <div class="cartCont">
                <div class="top">
                    <div class="csAbout">课程信息</div>
                </div>
                <div class="cont">
                	<%-- <c:forEach items="${shopList }" var="list"> 
                		<div class="item"><input type="checkbox"  name="myselect" value="${list.id }=${list.discountPrice }" onclick="eachPrice(this)">
                        <div class="csAbout">
                        	<a href="${pageContext.request.contextPath }/course/courseDetail/${list.id }" target="_blank"> <img src="${pageContext.request.contextPath }/${list.pic}" width="160" height="90" alt=""></a>
                            <div class="contInfo">
                                <p class="tit"><a href="${pageContext.request.contextPath }/course/courseDetail/${list.id }" > ${list.name }</a></span></p>
                                <p class="info">${list.content }</p>
                            </div>
                        </div>
                        <div class="sumMon">
                            <p><strong>原价</strong> ￥ <span>${list.price }</span></p>
                            <p><strong>现价</strong> ￥ <span>${list.discountPrice }</span></p>
                        </div>
                    </div>
                	</c:forEach> --%>
                </div>
                <div class="bot">
                    <div class="sumMon">
                    	全选：<input  id="allselect" type="checkbox" name="allselect" onclick="selectAll()" >
                        <p><strong>总计：</strong><span>￥ <i id="totalPrice">0</i></span></p>
                    </div>
                    <div class="subBut">
                        <span onclick="wechatPay()">微信支付</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span onclick="removeShopcar()">移除购物车</span>
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
	<form action="${pageContext.request.contextPath }/weChatPay" target="_blank" method="post" id="myForm">
		<input name="ids" id="needIds" type="hidden" >
		<input name="prices" id="needPrices" type="hidden" >
	</form>
    <!-- 页面 css js -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/js/bootstrap.js"></script>
    <script>
    	var countPrice=0;
        //全选和反选
        function selectAll(){
        	var o=document.getElementsByName('myselect');
        	if($('#allselect').is(':checked')){//全选
        		for(var i=0;i<o.length;i++){
        			o[i].checked=event.srcElement.checked;
        		}
        		//把所有的物品价格计算出来
        		countPrice=0;
        		var select=$("input[name='myselect']:checked");
        		for(var i=0;i<select.length;i++){
        			var str= select.eq(i).val().split('=');
        			countPrice+=Number(str[1]);
                }
        		
        	}else{//反选
        		//总价为0
        		countPrice=0;
        		for(var i=0;i<o.length;i++){
        			o[i].checked=event.srcElement.dischecked;
        		}
        	}
    		$('#totalPrice').html(countPrice);
        }
        //没有全部被选中，则全选取消选中状态，并计算总价
        function eachPrice(obj){
        	if(obj.checked){
        		//$('#allselect').prop('checked',true);
        	}else{//取消全选的状态
        		$('#allselect').prop('checked',false);
        	}
        	var select=$("input[name='myselect']:checked");
        	if(select.length==0){
        		$('#totalPrice').html('0');
            }
        	countPrice=0;
        	var arr= new Array();
            for(var i=0;i<select.length;i++){
            	var str= select.eq(i).val().split('=');
            	arr.push(str[1]);
            }
            var m=arr;
            for(var i=0;i<arr.length;i++){
            	countPrice+=Number(arr[i]);
            }
            $('#totalPrice').html(countPrice);
        }
        
        
        //微信支付
       function wechatPay(){
        	var select=$("input[name='myselect']:checked");
            if(select.length==0){
            	layer.open({
    				time:800,
    				content:"<span>请选择要结算的物品</span>"
    			})
            	return false;
            }
            var needPrice=$('#totalPrice').html();//需要付的价钱
            var priceArr= new Array();//当时的价格,可能存在以后修改价格了，不能根据id查询现在的价格对吧
            var idArr = new Array();//物品id
            for(var i=0;i<select.length;i++){
            	var str= select.eq(i).val().split('=');
            	idArr.push(str[0]);
            	priceArr.push(str[1]);
            }
            //进行支付
            $('#needIds').val(idArr);
            $('#needPrices').val(priceArr.toString());
            document.getElementById("myForm").submit()
       }
        
        //购物车列表
        function shopList(){
        	var id='${sessionScope.loginUser.id}';
        	$('.cont').html('');
        	$.ajax({
            	url:"${pageContext.request.contextPath }/back/memeber/myshopcarList",
            	data:{"uid":id},
            	type:"GET",
            	success:function(data){
            		console.log(data.length);
            		if(data.length>0){
            			var result='';
            			for(var i=0;i<data.length;i++){
            				result+='<div class="item"><input type="checkbox"  name="myselect" value="'+data[i].id+'='+data[i].discountPrice+'" onclick="eachPrice(this)">'
            					+'<div class="csAbout">'
            					+'<a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'" target="_blank"> <img src="${pageContext.request.contextPath }/'+data[i].pic+'" width="160" height="90" alt=""></a>'
            					+'<div class="contInfo">'
            					+'<p class="tit"><a href="${pageContext.request.contextPath }/course/courseDetail/'+data[i].id+'" > '+data[i].name+'</a></span></p>'
            					+'<p class="info">${list.content }</p>'
            					+'</div>'
            					+'</div>'
            					+'<div class="sumMon">'
            					+'<p><strong>原价</strong> ￥ <span>'+data[i].price+'</span></p>'
            					+'<p><strong>现价</strong> ￥ <span>'+data[i].discountPrice+'</span></p>'
            					+'</div>'
            					+'</div>'
            			}
            			$('.cont').html(result);
            		}else if(data.length==0){
            			result='<h1 align="center">暂无信息</h1>';
            			$('.cont').html(result);
            			$('.bot').hide();
            		}
            	},
            	error:function(){
            		alert("服务器忙");
            	},
            	dataType:"json"
            });
        }
        shopList();
        
        //移除购物车
        function removeShopcar(){
        	var id='${sessionScope.loginUser.id}';
        	var select=$("input[name='myselect']:checked");
            if(select.length==0){
            	layer.open({
    				time:800,
    				content:"<span>请选择要结算的物品</span>"
    			})
            	return false;
            }
            var idArr = new Array();//物品id
            for(var i=0;i<select.length;i++){
            	var str= select.eq(i).val().split('=');
            	idArr.push(str[0]);
            }
        	$.ajax({
            	url:"${pageContext.request.contextPath }/back/memeber/removeShopCar",
            	data:{"uid":id,"idArr":idArr.toString()},
            	type:"GET",
            	success:function(data){
            		if(data>0){
            			shopList();
            		}
            	},
            	error:function(){
            		alert("服务器忙");
            	},
            	dataType:"json"
            });
        }
    </script>
</body>

</html>