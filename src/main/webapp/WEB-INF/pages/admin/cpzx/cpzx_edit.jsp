<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% response.setHeader("Set-Cookie", "cookiename=value;Path=/;Domain=domainvalue;Max-Age=seconds;HTTPOnly"); %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>农业育种机械装备网</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath }/static/css/xadmin.css">
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath }/static/lib/layui/lay/modules/layer.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath }/static/js/editor/kindeditor.js"></script>
        <script charset="utf-8" src="${pageContext.request.contextPath }/static/js/editor/lang/zh_CN.js"></script>
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
            <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
            <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <script type="text/javascript">
            var editor;
            KindEditor.ready(function(K) {
                editor = K.create('textarea[name="cptd"]', {
                    //uploadJson : '${pageContext.request.contextPath }/manager/news/uploadImage',
                    uploadJson: '${pageContext.request.contextPath }/js/static/editor/jsp/upload_json.jsp',
                    fileManagerJson: '${pageContext.request.contextPath }/js/static/editor/jsp/file_manager_json.jsp', //可以不写
                    allowFileManager: false,
                    width: "90%",
                    height: "420px",
                    resizeType: 1,
                    filePostName: 'file',
                    items: [
                        'source', 'preview', '|', 'undo', 'redo', '|', 'copy', 'paste',
                        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                        'justifyfull', '|', 'media', 'insertfile', 'table', '|', '/',
                        'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                        'italic', 'underline', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                        '|', 'emoticons', '|', 'about'
                    ],
                    afterBlur: function() {
                        this.sync();
                    }
                });
            }); //resizeType : 0,是否可改变编辑器大小0不可以，1可改高度，2都可以。默认为2
        </script>
        
        <script type="text/javascript">
            var editor_jscs;
            KindEditor.ready(function(K) {
                editor_jscs = K.create('textarea[name="described"]', {
                    //uploadJson : '${pageContext.request.contextPath }/manager/news/uploadImage',
                    uploadJson: '${pageContext.request.contextPath }/js/static/editor/jsp/upload_json.jsp',
                    fileManagerJson: '${pageContext.request.contextPath }/js/static/editor/jsp/file_manager_json.jsp', //可以不写
                    allowFileManager: false,
                    width: "90%",
                    height: "420px",
                    resizeType: 1,
                    filePostName: 'file',
                    items: [
                        'source', 'preview', '|', 'undo', 'redo', '|', 'copy', 'paste',
                        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                        'justifyfull', '|', 'media', 'insertfile', 'table', '|', '/',
                        'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                        'italic', 'underline', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
                        '|', 'emoticons', '|', 'about'
                    ],
                    afterBlur: function() {
                        this.sync();
                    }
                });
            }); //resizeType : 0,是否可改变编辑器大小0不可以，1可改高度，2都可以。默认为2
        </script>
        <form class="layui-form" id="cpzxForm">
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title" id="tab_my" style="text-align: center;">
                    <li class="layui-this" lay-id="101">产品特点</li>
                    <li lay-id="102">技术参数</li>
                    <li lay-id="103">产品图片</li>
                    <li lay-id="104">作业视频</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-form-item">
                            <input name="id"  type="hidden" value="${map.cpzx.id}"/>
                            <input name="jscsId"  type="hidden" value="${map.jscsId}"/>
                            <input name="picId"  type="hidden" value="${map.picId}"/>
                            <input name="videoId"  type="hidden" value="${map.videoId}"/>
                            <label for="contents" class="layui-form-label"><span class="x-red">*</span>名称</label>
                            <div class="layui-input-block" style="width: 40%;">
                               <input type="text" id="" name="name" value="${map.cpzx.name}" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item" >
                            <label for="contents" class="layui-form-label"><span class="x-red">*</span>配图</label>
                            <div class="layui-input-inline">
                               <input type="file" name="ptPicFile" class="layui-input"/>&nbsp;&nbsp;
                            </div>
                            <div class="layui-input-inline">
                                <button type="button" class="layui-btn layui-btn-xs demo-reload" onclick="ylPic('${map.cpzx.cpPic}')">查看</button>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="contents" class="layui-form-label"><span class="x-red">*</span>内容</label>
                            <div class="layui-input-block">
                                <textarea name="cptd" required lay-verify="required" class="layui-textarea" required="" id="editor"
                                 placeholder="内容">${map.cpzx.cptd}</textarea>
                            </div>
                        </div>
                        <div class="layui-form-item" style="text-align:center">
		                    <button class="layui-btn btn-margR15" lay-filter="edit" lay-submit="">
		                                                                            修改
		                    </button>
		                    <button class="layui-btn layui-btn-danger" type="button" onclick="xadmin.close();">
		                                                                            返回</button>
		                </div>
                    </div>
                    <div class="layui-tab-item">
                        
                        <div class="layui-form-item">
                            <br /><br />
                            <label for="editor_jscs" class="layui-form-label"><span class="x-red">*</span>技术参数</label>
                            <div class="layui-input-block">
                                <textarea name="described" required lay-verify="required" class="layui-textarea" required="" id="editor_jscs"
                                 placeholder="内容">${map.jscs.described}</textarea>
                            </div>
                        </div>
                        
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-upload" style="width:70%;margin: 0 auto;">
						  <button type="button" class="layui-btn layui-btn-normal" id="testPicList">选择多图片</button> 
						  <div class="layui-upload-list">
						    <table class="layui-table">
						      <thead>
						        <tr><th>文件名</th>
						        <th>大小</th>
						        <th>上传进度</th>
						        <th>状态</th>
						        <th>操作</th>
						      </tr></thead>
						      <tbody id="demoPicList">
						          <c:forEach items="${map.picList }" var="pic">
						              <tr>
						                  <td>${pic.picOldName}</td>
						                  <td></td>
						                  <td></td>
						                  <td>上传成功</td>
						                  <td>
						                      <button type="button" class="layui-btn layui-btn-xs demo-reload" onclick="ylPic('${pic.pic}')">预览</button>
                                              <button type="button" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="delPic(this,'${pic.pic}','${pic.picOldName}')">删除</button>
						                  </td>
						              </tr>
						          </c:forEach>
						      </tbody>
						    </table>
						  </div>
						  <button type="button" class="layui-btn" id="testPicListAction" onclick="">开始上传</button>
						  <div id="cpPic">
						      <c:forEach items="${map.picList }" var="pic">
							      <input type='hidden' name='pics' value='${pic.pic}'>    
	                              <input type='hidden' name='picOldName' value='${pic.picOldName}'>
	                          </c:forEach>
						  </div>
						</div> 
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-upload" style="width:70%;margin: 0 auto;">
                          <button type="button" class="layui-btn layui-btn-normal" id="testVideoList">选择多视频</button> 
                          <div class="layui-upload-list">
                            <table class="layui-table">
                              <thead>
                                <tr><th>文件名</th>
                                <th>大小</th>
                                <th>上传进度</th>
                                <th>状态</th>
                                <th>操作</th>
                              </tr></thead>
                              <tbody id="demoVideoList">
                                    <c:forEach items="${map.videoList }" var="video">
                                      <tr>
                                          <td>${video.videoOldName}</td>
                                          <td></td>
                                          <td></td>
                                          <td>上传成功</td>
                                          <td>
                                              <button type="button" class="layui-btn layui-btn-xs demo-reload" onclick="ylVideo('${video.video}')">预览</button>
                                              <button type="button" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="delPic(this,'${video.video}','${video.videoOldName}')">删除</button>
                                          </td>
                                      </tr>
                                  </c:forEach>
                              </tbody>
                            </table>
                          </div>
                          <button type="button" class="layui-btn" id="testVideoListAction" onclick="">开始上传</button>
                          <div id="cpVideo">
                              <c:forEach items="${map.videoList }" var="video">
                                  <input type='hidden' name='videos' value='${video.video}'>  
                                  <input type='hidden' name='videoOldName' value='${video.videoOldName}'>
                              </c:forEach>
                          </div>
                        </div>
                    </div>

                </div>
                
            </div>
        </form>

    </body>
    <script type="text/javascript">
           var xhrOnProgress=function(fun) {
		      xhrOnProgress.onprogress = fun; //绑定监听
		      //使用闭包实现监听绑
		      return function() {
		         //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
		         var xhr = $.ajaxSettings.xhr();
		         //判断监听函数是否为函数
		         if (typeof xhrOnProgress.onprogress !== 'function')
		            return xhr;
		         //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
		         if (xhrOnProgress.onprogress && xhr.upload) {
		            xhr.upload.onprogress = xhrOnProgress.onprogress;
		         }
		         return xhr;
		      }
		   }
		   
        layui.use(['form', 'element', 'upload', 'layer'], function() {
            $ = layui.jquery;
            var form = layui.form,
                element = layui.element,
                layer = layui.layer,
                upload = layui.upload;

            //多文件列表示例
          var countPic = 0;
		  var demoListView = $('#demoPicList')
		  ,uploadListIns = upload.render({
		    elem: '#testPicList'
		    ,url: 'uploadImg'
		    ,accept: 'image'
		    ,method:'post'
		    ,multiple: true
		    ,xhr:xhrOnProgress
		    ,before: function(input){
			  //返回的参数item，即为当前的input DOM对象
			   var flag = 0;
	            $("#demoPicList tr").each(function(){
	                 var te =  $(this).find(".layui-bg-blue").attr("lay-percent");  //layui-progress-bar
	                 if(te != null && te != undefined){
	                    if(te == '100%'){
	                        flag = 1;
	                     }else{
	                        flag = 0;
	                     }
	                 }else{
	                   flag = 0;
	                 }
	            });
	            if(flag == '0'){
	               layer.msg('文件正在上传中', {icon: 16,time:false });
	               $('button').addClass('layui-btn-disabled');
	               $('button').attr('disabled',true);
	            }
			   
			 }
            ,progress:function(value,obj){//上传进度回调 value进度值
                $("#demoPicList").find('.layui-progress ').each(function () {
                if( $(this).attr("file")==obj.name){
                var progressBarName =  $(this).attr("lay-filter");
                var percent=Math.floor((value.loaded / value.total)*100);//计算百分比
                element.progress(progressBarName, percent+'%')//设置页面进度条
                }
                })
                        
             }
		    //设置图片上传的大小
	        , size: 102400
	        //禁用自动上传
		    ,auto: false
		    ,bindAction: '#testPicListAction'
		    ,choose: function(obj){   
		      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
		      //读取本地文件
		      obj.preview(function(index, file, result){
		        var tr = $(['<tr id="uploadPic-'+ index +'">'
		          ,'<td>'+ file.name +'</td>'
		          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
		          ,'<td>'
                  +'<div  file="'+file.name+'" class="layui-progress layui-progress-big" lay-showpercent="true"   lay-filter="progressBar'+countPic+'">'
                  +'<div  class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>'
                  +'</div>'
                  +'</td>'
		          ,'<td>等待上传</td>'
		          ,'<td>'
		            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
		            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
		          ,'</td>'
		        ,'</tr>'].join(''));
		        
		        //单个重传
		        tr.find('.demo-reload').on('click', function(){
		          obj.upload(index, file);
		        });
		        
		        //删除
		        tr.find('.demo-delete').on('click', function(){
		          delete files[index]; //删除对应的文件
		          tr.remove();
		          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
		        });
		        
		        demoListView.append(tr);
		      });
		    }
		    ,done: function(res, index, upload){
		      if(res.code == 0){ //上传成功
		        layer.closeAll();
		        var tr = demoListView.find('tr#uploadPic-'+ index)
		        ,tds = tr.children();
		        
		        tds.eq(2).html('<div  class="layui-progress layui-progress-big" lay-filter="demoPro" lay-showpercent="true" >'
                  +'<div  class="layui-progress-bar layui-bg-blue" lay-percent="100%"></div>'
                  +'</div>'); //清空操作
		        element.init();
                element.progress('demoPro', '100%');
                
		        tds.eq(3).html('<span style="color: #5FB878;">上传成功</span>');
		        $("#cpPic").append("<input type='hidden' name='pics' value='"+res.data+"'>    <input type='hidden' name='picOldName' value='"+res.filename+"'>");
		        tds.eq(4).html('<button type="button" class="layui-btn layui-btn-xs demo-reload" onclick="ylPic(\''+res.data+'\')">预览</button>'+
		                       '<button type="button" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="delPic(this,\''+res.data+'\',\''+res.filename+'\')">删除</button>'); //预览操作
		        $('button').removeClass('layui-btn-disabled');
                $('button').removeAttr('disabled');
		        return delete this.files[index]; //删除文件队列已经上传成功的文件
		      }
		      this.error(index, upload);
		    }
		    ,error: function(index, upload){
		      var tr = demoListView.find('tr#uploadPic-'+ index)
		      ,tds = tr.children();
		      tds.eq(3).html('<span style="color: #FF5722;">上传失败</span>');
		      tds.eq(4).find('.demo-reload').removeClass('layui-hide'); //显示重传
		      $('button').removeClass('layui-btn-disabled');
              $('button').removeAttr('disabled');
		    }
		  }); 
		  
		    //多文件列表示例
		  var count=0;
          var demoVideoListView = $('#demoVideoList')
          ,uploadListIns = upload.render({
            elem: '#testVideoList'
            ,url: 'uploadImg'
            ,accept: 'video'
            ,method:'post'
            ,multiple: true
            ,xhr:xhrOnProgress
            ,before: function(input){
              //返回的参数item，即为当前的input DOM对象
               var flag = 0;
                $("#demoVideoList tr").each(function(){
                     var te =  $(this).find(".layui-bg-blue").attr("lay-percent");  //layui-progress-bar
                     if(te != null && te != undefined){
                        if(te == '100%'){
                            flag = 1;
                         }else{
                            flag = 0;
                         }
                     }else{
                       flag = 0;
                     }
                });
                if(flag == '0'){
                   layer.msg('文件正在上传中', {icon: 16,time:false });
                   $('button').addClass('layui-btn-disabled');
                   $('button').attr('disabled',true);
                }
               
             }
		    ,progress:function(value,obj){//上传进度回调 value进度值
		        $("#demoVideoList").find('.layui-progress ').each(function () {
		        if( $(this).attr("file")==obj.name){
		        var progressBarName =  $(this).attr("lay-filter");
		        var percent=Math.floor((value.loaded / value.total)*100);//计算百分比
		        element.progress(progressBarName, percent+'%')//设置页面进度条
		        }
		        })
		                
		     }
            //设置视频上传的大小
            , size: 102400
            //禁用自动上传
            ,auto: false
            ,bindAction: '#testVideoListAction'
            ,choose: function(obj){   
              var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
              //读取本地文件
              obj.preview(function(index, file, result){
                var tr = $(['<tr id="uploadVideo-'+ index +'">'
                  ,'<td>'+ file.name +'</td>'
                  ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
                  ,'<td>'
                  +'<div  file="'+file.name+'" class="layui-progress layui-progress-big" lay-showpercent="true"   lay-filter="progressBar'+count+'">'
                  +'<div  class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>'
                  +'</div>'
                  +'</td>'
                  ,'<td>等待上传</td>'
                  ,'<td>'
                    ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                    ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                  ,'</td>'
                ,'</tr>'].join(''));
                
                //单个重传
                tr.find('.demo-reload').on('click', function(){
                  obj.upload(index, file);
                });
                
                //删除
                tr.find('.demo-delete').on('click', function(){
                  delete files[index]; //删除对应的文件
                  tr.remove();
                  uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                });
                
                demoVideoListView.append(tr);
              });
            }
            ,done: function(res, index, upload){
              if(res.code == 0){ //上传成功
                layer.closeAll();
                var tr = demoVideoListView.find('tr#uploadVideo-'+ index)
                ,tds = tr.children();
                
                tds.eq(2).html('<div  class="layui-progress layui-progress-big" lay-filter="demoProV" lay-showpercent="true" >'
                  +'<div  class="layui-progress-bar layui-bg-blue" lay-percent="100%"></div>'
                  +'</div>'); //清空操作
                element.init();
                element.progress('demoProV', '100%');
                
                tds.eq(3).html('<span style="color: #5FB878;">上传成功</span>');
                $("#cpVideo").append("<input type='hidden' name='videos' value='"+res.data+"'>  <input type='hidden' name='videoOldName' value='"+res.filename+"'>");
                tds.eq(4).html('<button type="button" class="layui-btn layui-btn-xs demo-reload" onclick="ylVideo(\''+res.data+'\')">预览</button>'+
                               '<button type="button" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="delPic(this,\''+res.data+'\',\''+res.filename+'\')">删除</button>'); //预览操作
                $('button').removeClass('layui-btn-disabled');
                $('button').removeAttr('disabled');
                
                return delete this.files[index]; //删除文件队列已经上传成功的文件
              }
              this.error(index, upload);
            }
            ,error: function(index, upload){
              var tr = demoVideoListView.find('tr#uploadPic-'+ index)
              ,tds = tr.children();
              tds.eq(3).html('<span style="color: #FF5722;">上传失败</span>');
              tds.eq(4).find('.demo-reload').removeClass('layui-hide'); //显示重传
              $('button').removeClass('layui-btn-disabled');
              $('button').removeAttr('disabled');
            }
          });
           
           
           
           //监听提交
            form.on('submit(edit)',
            function(data) {
                var formData = new FormData(document.getElementById('cpzxForm'));  //cpzxForm  
                $.ajax({
                    url:"${pageContext.request.contextPath }/manageros/cpzx/update",
                    data:formData,
                    type:"POST",
                    contentType: false, //不设置内容类型
                    processData: false, //不处理数据
                    success:function(data){
                        if(data == '1'){
                            layer.alert("修改成功", {
                            icon : 6
                            }, function() {
                                //关闭当前frame
                                xadmin.close();
                                // 可以对父窗口进行刷新 
                                xadmin.father_reload();
                            });
                        }else{
                            layer.alert("修改失败");
                        }
                    },
                    error:function(data){
                        layer.alert("服务器忙，请稍后重试" );
                    },
                    dataType: "json"
                });
                
                return false;
            }); 
           
        });
        
         function delJscs(obj){
            $(obj).parent().parent().remove();
         }
         function addJscs(){
            $("#jscs").append('<tr>'+
                                  '<td><input type="text" name="project"  autocomplete="off" class="layui-input"></td> '+
                                  '<td><input type="text" name="company"  autocomplete="off" class="layui-input"></td> '+
                                  '<td><input type="text" name="described" autocomplete="off" class="layui-input"></td> '+
                                  '<td><button type="button" class="layui-btn layui-btn-danger" onclick="delJscs(this) ">删除</button></td> '+
                              '</tr>');
         }
         /**
         *图片预览操作
         */
         function ylPic(path){
            //xadmin.open('预览','../../manageros/cpzx/toyl?flag=1&path='+path);
            var img = '<img  src="${pageContext.request.contextPath }/'+path+'">'
            layer.open({
	            type: 1,//Page层类型
                area: ['80%', '80%'],
                title: '图片预览',
                shade: 0.6 ,//遮罩透明度
                fixed: false, //不固定
                maxmin: true, //开启最大化最小化按钮
                anim: 1 ,//0-6的动画形式，-1不开启
                content: img
		    });
         }
         /**
         *视频预览操作
         */
         function ylVideo(path){
            //xadmin.open('预览','../../manageros/cpzx/toyl?path='+path);
            var video = ' <video src="${pageContext.request.contextPath }/'+path+'" controls="controls" />'
            layer.open({
                type: 1,//Page层类型
                area: ['80%', '80%'],
                title: '图片预览',
                shade: 0.6 ,//遮罩透明度
                fixed: false, //不固定
                maxmin: true, //开启最大化最小化按钮
                anim: 1 ,//0-6的动画形式，-1不开启
                content: video
            });
         }
         /**
         *图片上传成功后的删除
         */
         function delPic(obj,path,filename){
            $.ajax({ 
                url:"../../manageros/cpzx/delFile",
                data:{"path":path},
                type:'POST',
                dataType:'json',
                success:function(data){
                    if(data > 0){
                          $(obj).parent().parent().remove();
                          $("#cpPic input[value='"+path+"']").remove();
                          $("#cpVideo input[value='"+path+"']").remove();
                          
                          $("#cpPic input[value='"+filename+"']").remove();
                          $("#cpVideo input[value='"+filename+"']").remove();
                    }else{
                        layer.alert('删除失败');
                    }
                },
                error:function(data){
                    layer.alert('服务器繁忙');
                }
            });
         }
         
    </script>
</html>
