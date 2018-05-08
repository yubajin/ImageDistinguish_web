function runjs() {
	//				var jquery_mobile_css = "/css/jquery.mobile-1.4.5.css";
	//				var jquery_mobile_js = "/js/jquery.mobile-1.4.5.min.js";
	//				requestLoadCSS(jquery_mobile_css);
	//				requestLoadJS(jquery_mobile_js);

	upload();
}
function upload() {
	var uploadbutton = $("#uploadbutton");
	uploadbutton.one("click", requestUpload)
}

function requestUpload() {
	$.ajax({
		type : "POST",
		url : "/ImageDistinguish_web/uploadfile",
		data : new FormData($('#uploadForm')[0]),
		processData : false,
		contentType : false,
		async : false,
		cache : false, // 不缓存
		success : successUploadFunc
	});
}

function successUploadFunc(data) {
	var json = eval(data);
	$.each(json, function(index) {
		var log_id = json[index].log_id;
		var words_results = json[index].words_result;
		var words_result_num = json[index].words_result_num;
		console.log("log_id: " + log_id + "words_results: " + words_results
				+ "words_result_num: " + words_result_num);
		$("#main").append('<p>识别结果如下：</p>');
		var word_result_obj = eval(words_results);
		$.each(word_result_obj, function(index) {
			var words_result = word_result_obj[index].words;
			addWordsList(words_result);
		});
	});
}

function addWordsList(words_result) {
	$("#main").append('<p>' + words_result + '</p>');

}

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

function requestLoadCSS(rs_url) {
	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath }/GetResourceFromWF",
		data : {
			"url" : rs_url,
		},
		success : function(data) {
			console.log("data:" + data);

			var js_element = document.createElement("style");
			js_element.setAttribute("type", "text/css");
			js_element.innerHTML = data;
			document.getElementsByTagName("head")[0].appendChild(js_element);
		}
	});
}

runjs();
