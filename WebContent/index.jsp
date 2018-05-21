<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>图片识别网站</title>
		<link rel="stylesheet" href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
		<link rel="stylesheet" href="https://res.wx.qq.com/open/libs/weui/1.1.1/weui.min.css">
		<script type='text/javascript' src='http://libs.baidu.com/jquery/2.1.4/jquery.min.js' charset='utf-8'></script>
		<script src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
		<script type="text/javascript" src="https://res.wx.qq.com/open/libs/weuijs/1.1.2/weui.min.js"></script>

	</head>
	<body onload="init()">
		<div data-role="page" id="page">
			<div data-role="main" class="ui-content" id="main">
				<div>
					<form id="uploadForm" method="post" enctype="multipart/form-data">
						<input type="file" id = "myfile1" name="myfile"><br>
						<input type="button" id="uploadbutton" value="上传">
					</form>
				</div>
			</div>
		</div>
		  
		<script type="text/javascript">
			function init() {
				requestAddr();
				upload();
			}
			
			function requestAddr(){
				$.ajax({
					type : "POST",
					url : "/ImageDistinguish_web/uploadfile",
					data : "",
					success : function(data){
					}
				});
			}
			
			function upload() {
				var uploadbutton = $("#uploadbutton");
				uploadbutton.bind("click", requestUpload)
			}
	
			function requestUpload() {
				$.ajax({
					  type: 'POST',
					  url: "/ImageDistinguish_web/uploadfile",
					  data : new FormData($('#uploadForm')[0]),
					  processData : false,
					  contentType : false,
					  async : false,
					  cache : false, // 不缓存
					  //数据加载前调用的方法 beforeSend()
					  beforeSend: function(data){
					   //这里判断，如果没有加载数据，会显示loading    
					   if(data.readyState == 0){ 
					     weui.loading('loading');   
					   }
					  },
					  //数据加载成功调用的方法 sucess()
					  sucess: successUploadFunc,  
					  //数据加载成功后调用的方法  complete()
					  complete: function(data){
					    //这里判断，数据加载成功之后，loading 隐藏
					    if(data.status == 200){
					      setTimeout(function(){
					        weui.loading('loading').hide();
					      },500);
					    }
					  },
					  //数据加载错误后调用的方法 error()
					  error: function(data){
					    weui.topTips('数据加载失败！');
					  }
				})
				
			}

			
			function successUploadFunc(data) {
				var json = eval(data);
				$.each(json, function(index) {
					var log_id = json[index].log_id;
					var words_results = json[index].words_result;
					var words_result_num = json[index].words_result_num;
					
					clearWordList();
					$("#main").append('<p>识别结果如下：</p>');
					var word_result_obj = eval(words_results);
					alert(word_result_obj);
					$.each(word_result_obj, function(index) {
						var words_result = word_result_obj[index].words;
						addWordsList(words_result);
					});
				});
			}
			
			function addWordsList(words_result) {
				$("#main").append('<p>' + words_result + '</p>');
	
			}
	
			function clearWordList(){
				$("#main p").remove();
			}
		</script>
	</body>
</html>
