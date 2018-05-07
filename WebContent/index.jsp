<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>图片识别网站</title>
		<!--  
		<link rel="stylesheet" href="${pageContext.request.contextPath }/WEB-INF/css/jquery.mobile-1.4.5.css" />
		<script src="${pageContext.request.contextPath }/WEB-INF/js/jquery.mobile-1.4.5.min.js"></script>
		-->
		<script type='text/javascript' src='http://libs.baidu.com/jquery/2.1.4/jquery.min.js' charset='utf-8'></script>
	</head>
	<body onload="init()">
		 <!-- 
		<form action="${pageContext.request.contextPath }/uploadfile" method="post" enctype="multipart/form-data">
			<input type="file" id = "file" name="file"><br>
			<input type="submit" value="上传">
		</form>
		-->
		<div data-role="page" id="page">
			<div data-role="main" class="ui-content">
				<div class="ui-input-text ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c">
					<form id="uploadForm" method="post" enctype="multipart/form-data">
						<input type="file" id = "myfile1" name="myfile"><br>
						<input type="button" id="uploadbutton" value="上传">
					</form>
				</div>
			</div>
		</div>
		  
		<script type="text/javascript">
		
			function init(){
				var jquery_mobile_css = "/css/jquery.mobile-1.4.5.css";
				var jquery_mobile_js = "/js/jquery.mobile-1.4.5.min.js";
				requestLoadCSS(jquery_mobile_css);
				requestLoadJS(jquery_mobile_js);
				
				upload();
			}
			
			function upload(){
				var uploadbutton = $("#uploadbutton");
				uploadbutton.one("click",requestUpload)
			}
			
			function requestUpload(){
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath }/uploadfile",
					data: new FormData($('#uploadForm')[0]),
					processData: false,
				    contentType: false,
				    async: false,
					cache: false,                      // 不缓存
				    success:successUploadFunc
				});
			}
			
			function successUploadFunc(data){
				var json = eval(data);
				$.each(json, function(index){
					var log_id = json[index].log_id;
					var words_result = json[index].words_result;
					var words_result_num = json[index].words_result_num;
					alert("log_id: "+log_id+"words_result: "+words_result+"words_result_num: "+words_result_num);
				});
			}
			
			function requestLoadJS(rs_url){
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath }/GetResourceFromWF",
					data: {
						"url":rs_url,
					},          
				    success:function(data){
				    	console.log("data:"+data);

						var js_element=document.createElement("script");
						js_element.setAttribute("type","text/javascript");
						js_element.innerHTML = data;
						document.getElementsByTagName("head")[0].appendChild(js_element);
				    }
				});
			}
			
			function requestLoadCSS(rs_url){
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath }/GetResourceFromWF",
					data: {
						"url":rs_url,
					},          
				    success:function(data){
				    	console.log("data:"+data);

						var js_element=document.createElement("style");
						js_element.setAttribute("type","text/css");
						js_element.innerHTML = data;
						document.getElementsByTagName("head")[0].appendChild(js_element);
				    }
				});
			}
			
			
		</script>
	</body>
</html>
