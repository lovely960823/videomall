<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/page-learing-sign.css" />
</head>

<body>
    <!-- 页面 -->
    <div class="register">
        <!--<img src="../../assets/img/logoico.png" alt="logo" width="200">-->
        <a href="./" class="backIndex">返回首页</a>
        <div class="register-body container text-center">
            <div class="signIco"><img src="${pageContext.request.contextPath }/static/img/asset-logoico.png" alt="logo" width="180"></div>
            <div class="signTit cl"><span class="sign">登录</span><span class="reg activ">注册</span></div>
            <div class="signItem">
            <form action="" id="loginForm">
                <div>
                    <p>账户名</p>
                    <p>
                        <input type="text" name="loginusername" id="loginusername" class="textInput" placeholder="请输入手机号">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div>
                    <p>登录密码</p>
                    <p>
                        <input type="password" name="loginpassword" id="loginpassword" class="textInput">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div class="setSing">
                    <label><a href="/memeber/qqLogin">QQ登录</a></label>
                    <label><a href="/memeber/wxLogin">微信登录</a></label>
                    <a href="#" class="forget">忘记密码</a>
                </div>
                <div class="submitBut" onclick="login()">登录</div>
            </form>
            </div>
            
            <form action="" id="form2">
            <div class="regItem show">
                <div class="phoneBox">
                    <p>手机号码</p>
                    <p>
                        <input type="text" name="tel" id="tel" class="textInput" placeholder="请输入11位手机号码" >
                        <input type="submit" class="codeSub" value="发送验证码" onmouseover="checktel();">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div>
                    <p>短信验证码</p>
                    <p>
                        <input type="text" name="phoneCode" id="phoneCode" class="textInput" placeholder="请输入短信验证码">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                
                 <div>
                    <p>用户名</p>
                    <p>
                        <input type="text" name="username" id="username" class="textInput" placeholder="请输入用户名">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div>
                    <p>设置密码</p>
                    <p>
                        <input type="password" name="password" id="password" class="textInput" placeholder="请输入密码">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div>
                    <p>确认密码</p>
                    <p>
                        <input type="password" name="conPassword" id="conPassword" class="textInput" placeholder="请再次输入密码">
                        <span class="proof cl-orange"></span>
                    </p>
                </div>
                <div class="setSing">
                    <label><input type="checkbox" name="agreement">同意协议并注册 </label><a href="#">《学成网注册协议》</a>
                    <span class="proof cl-orange"></span>
                </div>
                <div class="registerBut" onclick="doRegister()">注册</div>
            </div>
            </form>
            
        </div>
        <footer>
            <p><a href="#">关于我们</a><a href="#">联系我们</a><a href="#">客户服务</a><a href="#">管理团队</a><a href="#">新手指南</a><a href="#">合作伙伴</a></p>
            <p>地址：河南省信阳市</p>
        </footer>
    </div>
    <!-- 页面 css js -->
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/plugins/bootstrap/dist/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath }/static/js/page-learing-sign.js"></script>
    <script type="text/javascript">
    var random= Math.floor(Math.random()*(100000-999999))+999999;//产生四位随机数
		// 验证码
		function phoCde(){
			var myphonenumber=$('#tel').val();
			if(myphonenumber==null||myphonenumber==""){
				alert('输入手机号');
				return ;
			}
		  var mis = 300;
		  var _this = $(this);
		  _this.unbind('click')
			_this.attr('disabled','true')
			random= Math.floor(Math.random()*(100000-999999))+999999;//第二次及以后每点击一次发送，都重新赋值 否则random为null
		  var time = setInterval(function(){
			if(mis == 0){
				_this.val('重新发送')
				random='';//过期了 设为空
		    $('.codeSub').bind('click',phoCde)
		    _this.removeAttr('disabled')
		    clearInterval(time)
			}else{
		    _this.val(mis +' s')
		    mis--
			}
		  },500)
		  sendCodeToMyPhone(myphonenumber,random);//发送验证码
		}
		$('.codeSub').bind('click',phoCde);
		
		
		//发送验证码
    	 function sendCodeToMyPhone(myphonenumber,random){
			$.ajax({
		       	url:"${pageContext.request.contextPath }/receiveCodeToMyPhone",
		       	data:{"phoneNumber":myphonenumber,"randomCode":random},
		       	type:"POST",
		       	success:function(data){
		       		if(data==1){
		       			alert('短信验证码已经发送到您的手机上，请注意查收!');
		       		}else{
		       			alert('请稍后重试!');
		       		}
		       	},
		       	error:function(){
		       		alert("服务器忙");
		       	},
		       	dataType:"json"
		       });  
		} 
    	 
			//注册实现方法
    		function doRegister(){
        		var phoneCode=$('#phoneCode').val();
        		if($('#username').val()==null||$('#username').val()==""){
        			alert('请输入用户名！');
        			return ;
        		}
        		if(phoneCode==null||phoneCode==''){
    				 alert('请获取验证码');
    	        		return false;
    	        	}
    	       	if(phoneCode!=random){
    	       		alert('无效验证码');
    	       		return false;
    	       	}
        		$.ajax({
                	url:"${pageContext.request.contextPath }/doRegister",
                	data:$("#form2").serialize(),
                	type:"POST",
                	success:function(data){
                		if(data>0){
                			alert('注册成功');
                			window.location.reload();
                		}
                	},
                	error:function(){
                		alert("服务器忙");
                	},
                	dataType:"json"
                });  
        	}
			
			//登录
			function login(){
				var name=$('#loginusername').val();
				var pwd=$('#loginpassword').val();
				if(name==null||name==""){
					alert('请输入用户名');
					return ;
				}
				if(pwd==null||pwd==""){
					alert('请输入密码');
					return ;
				}
				$.ajax({
                	url:"${pageContext.request.contextPath }/doLogin",
                	data:{"name":name,"pwd":pwd},
                	type:"POST",
                	success:function(data){
                		if(data==1){
                			window.location.href="${pageContext.request.contextPath }/";
                		}
                		else{
                			alert('请检查用户名和密码是否正确');
                		}
                	},
                	error:function(){
                		alert("服务器忙");
                	},
                	dataType:"json"
                });
			}
			
			function checktel(){
				var phoneNum=$('#tel').val();
				$.ajax({
                	url:"${pageContext.request.contextPath }/checkTelNumber",
                	data:{"phoneNum":phoneNum},
                	type:"GET",
                	success:function(data){
                		if(data==1){
                			alert('该手机号已经被注册，请更换');
                			$('#tel').val('');
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