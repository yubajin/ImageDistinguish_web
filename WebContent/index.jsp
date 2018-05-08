<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>图片识别网站</title>
		<link rel="stylesheet" href="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.css">
		<script type='text/javascript' src='http://libs.baidu.com/jquery/2.1.4/jquery.min.js' charset='utf-8'></script>
		<script src="https://apps.bdimg.com/libs/jquerymobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

	</head>
	<body onload="init()">
		<div data-role="page" id="page">
			<div data-role="main" class="ui-content" id="main">
				<div class="ui-input-text ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c">
					<form id="uploadForm" method="post" enctype="multipart/form-data">
						<input type="file" id = "myfile1" name="myfile"><br>
						<input type="button" id="uploadbutton" value="上传">
					</form>
				</div>
			</div>
		</div>
		  
		<script type="text/javascript">
			function requestLoadJS(rs_url) {
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath }/GetResourceFromWF",
					data : {
						"url" : rs_url,
					},
					success : function(data) {
						console.log("data:" + data);
	
						var js_element = document.createElement("script");
						js_element.setAttribute("type", "text/javascript");
						js_element.innerHTML = data;
						document.getElementsByTagName("head")[0].appendChild(js_element);
					}
				});
			}
			function init(){
				var rs_url = "/js/upload.js";
				requestLoadJS(rs_url);
			}
			
		</script>
	</body>
</html>
