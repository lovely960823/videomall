<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>扫码支付</title>
 <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath }/static/js/jquery.qrcode.min.js" type="text/javascript" ></script>
<script type="text/javascript">
var code = '${code_url}';
</script>
<style type="text/css">
</style>
</head>
<body style="width: 99%">
<div style="margin-left: 30%;margin-top: 10%">
	<img alt="" src="${pageContext.request.contextPath }/static/img/wechatpay.jpg" style="width: 150px;height: 100px;">
</div>
<!-- 二维码 -->
<div id="qrImage" style="width: 80;text-align: center;margin-top: 1%">

</div>
<div style="text-align: center">
	<p style="color: red">请用微信扫一扫支付</p>
</div>
</body>
<script type="text/javascript">
var code = '${code_url}';
$("#qrImage").qrcode({
    width:200,
    height:200,
    text:code,
})
</script>
<script type="text/javascript">

var x= '${sessionScope.loginUser.id}';
//alert(x);
//订单查询状态
var orderId='${orderId}';
setTimeout("queryPayState()",1000);
function queryPayState(){
	 $.ajax({
     	url:"${pageContext.request.contextPath }/pay/state/"+orderId,
     	data:{},
     	type:"GET",
     	success:function(data){
     		if(data==0){
     			setTimeout("queryPayState()",1000);
     		}else if(data==1){//支付成功，并刷新父窗口
     			//window.close();
     			//window.opener.location.href = window.opener.location.href;
     			makeorder();
     		}else{
     			alert("服务器忙");
     		}
     	},
     	error:function(){
     		alert("服务器忙");
     	},
     	dataType:"json"
     }); 
} 
function makeorder(){
	$.ajax({
     	url:"${pageContext.request.contextPath }/order/makeorder",
     	data:{},
     	type:"GET",
     	success:function(data){
     		if(data==1){
     			window.close();
     			window.opener.location.href = window.opener.location.href;
     		}else{
     			alert('发生错误');
     		}
     	},
     	error:function(){
     		alert("服务器忙");
     	},
     	dataType:"json"
     });
}

</script>
</html>