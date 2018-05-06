<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>图片识别网站</title>
<script type='text/javascript' src='http://libs.baidu.com/jquery/2.1.4/jquery.min.js' charset='utf-8'></script>
</head>
<body onload="init()">
	 <!-- 
	<form action="${pageContext.request.contextPath }/uploadfile" method="post" enctype="multipart/form-data">
		<input type="file" id = "file" name="file"><br>
		<input type="submit" value="上传">
	</form>
	-->
	
	  
	<form id="uploadForm" method="post" enctype="multipart/form-data">
		<input type="file" id = "myfile1" name="myfile"><br>
		<input type="button" id="uploadbutton" value="上传">
	</form>
	<script type="text/javascript">
	
		function init(){
			upload();
		}
		
		function upload(){
			var uploadbutton = $("#uploadbutton");
			uploadbutton.one("click",request)
		}
		
		function request(){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath }/uploadfile",
				data: new FormData($('#uploadForm')[0]),
				processData: false,
			    contentType: false,
			    async: false,
				cache: false,                      // 不缓存
			    success:successFunc
			});
		}
		
		function successFunc(data){
			var json = eval(data);
			$.each(json, function(index){
				var log_id = json[index].log_id;
				var words_result = json[index].words_result;
				var words_result_num = json[index].words_result_num;
				alert("log_id: "+log_id+"words_result: "+words_result+"words_result_num: "+words_result_num);
			});
		}
		
	</script>
</body>
</html>
