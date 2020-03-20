<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 页面底部 -->
<div class="personal-nav pull-left">
            <div class="nav nav-stacked text-left">
                <div class="title">个人中心</div>
                <div class="my-ico">
                    <img src="${sessionScope.loginUser.img }" alt="">
                    <p>${sessionScope.loginUser.username }</p>
                </div>
                <div class="item">
                    <li ><a href="" class="glyphicon glyphicon-tower"> 我的课程<i class="pull-right">></i></a></li>
                    <li><a href="javascript:void(0)" onclick="myshopcar()" class="glyphicon glyphicon-shopping-cart"> 购物车<i class="pull-right">></i></a></li>
                    <li><a href=""  class="glyphicon glyphicon-list-alt"> 我的订单<i class="pull-right">></i></a> </li>
                    <li><a href="" class="glyphicon glyphicon-heart"> 我的收藏<i class="pull-right">></i></a> </li>
                    <li><a href="" class="glyphicon glyphicon-cog"> 个人设置<i class="pull-right">></i></a></li>
                    <li><a href="/back/memeber/logout" class="glyphicon glyphicon-log-out"> 退出<i class="pull-right">></i></a></li>
                </div>
            </div>
        </div>