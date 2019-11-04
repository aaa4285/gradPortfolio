function resetHtml(targetId,list) {
	// 초기화
	$("[for='"+targetId+"']").html("");
	list.forEach(function(data,i){
		data["_list_idx_"] = i;
		appendHtml(targetId,data);
	})
}
function appendHtml(targetId,data) {
	// 타겟 html
	var html = $("#"+targetId).html();
	// 매핑 id 추출
	var idArr = html.match( /(#([^#]+)#)/ig );
	// 데이터 id 매핑
	idArr.forEach(function(d){
		// 함수 포멧 적용
		var value = getFormatData(d,data);//data[d.substring(1,d.length-1)];
		html = html.replace(d,(value==undefined||value==null?"":value));
	})
	// append
	$("[for='"+targetId+"']").append(html);
}
function getFormatData(d,data){
	if (!/(#fn\{([^\}]+)\}#)/.test(d)) {
		return data[d.substring(1,d.length-1)];
	}
	var tmpArr = d.substring(4,d.length-2).split(":");
	if (tmpArr.length != 2) {
		return "N/A";
	}
	var fn = tmpArr[0];
	var id = tmpArr[1];
	if (!window[fn]) {
		return "function not found";
	}
	if (!id) {
		return "id is null";
	}
	return window[fn](data[id]);
}
function yyyyMMddFormat(str,c){
	// 구분자
	if (!c) {
		c = "-";
	}
	// 값 유효성 체크
	if (!str || new String(str).length!=8 || isNaN(new Number(str))) {
		return null;
	}
	str = new String(str)
	var y = str.substring(0,4);
	var m = str.substring(4,6);
	var d = str.substring(6,8);
	return y+c+m+c+d;
}