<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Calendar calendar = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String end = sdf.format(new Date());
calendar.setTime(new Date());
calendar.add(Calendar.MONTH, -1);
String start = sdf.format(calendar.getTime());

%>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title></title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
        <link rel="icon" href="${pageContext.request.contextPath }/static/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
        <script src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/echarts-4.2.1/dist/echarts.js"></script>
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
          <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
          <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <blockquote class="layui-elem-quote">欢迎您：
                                <span class="x-red">${loginUser.username }</span> ！<span id="nowTime"></sapn>
                            </blockquote>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-md12">
                    <div class="layui-card" >
                        <div class="layui-card-body">
                            <div id="main" style="width: 100%;height:400px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            layui.use(['form', 'layer', 'laydate'],
	            function() {
	                $ = layui.jquery;
	                var form = layui.form,
	                laydate = layui.laydate,
	                layer = layui.layer;
	                //日期
	                  laydate.render({
	                    elem: '#startTime'
	                  });
	                  
	                  laydate.render({
	                    elem: '#endTime'
	                  });
              });
            
            //获取系统时间
			var newDate = '';
			getLangDate();
			//值小于10时，在前面补0
			function dateFilter(date){
			    if(date < 10){return "0"+date;}
			    return date;
			}
			function getLangDate(){
			    var dateObj = new Date(); //表示当前系统时间的Date对象
			    var year = dateObj.getFullYear(); //当前系统时间的完整年份值
			    var month = dateObj.getMonth()+1; //当前系统时间的月份值
			    var date = dateObj.getDate(); //当前系统时间的月份中的日
			    var day = dateObj.getDay(); //当前系统时间中的星期值
			    var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
			    var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
			    var hour = dateObj.getHours(); //当前系统时间的小时值
			    var minute = dateObj.getMinutes(); //当前系统时间的分钟值
			    var second = dateObj.getSeconds(); //当前系统时间的秒钟值
			    var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午
			    newDate = dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second);
			    document.getElementById("nowTime").innerHTML = "当前时间为： "+newDate+"　"+week;
			    setTimeout("getLangDate()",1000);
			}
			
        </script>
    </body>
</html>