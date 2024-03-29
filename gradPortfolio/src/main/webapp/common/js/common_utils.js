function ajax(url,data,callback,loding){
	var ajaxData = "";
	var contentType = "application/x-www-form-urlencoded; charset=UTF-8";
	loding = (loding == null || loding == undefined)? true : loding;
	if (data != null && data != undefined) {
		if (typeof data == "object") {
			// form element
			console.log("isForm?",data instanceof HTMLFormElement);
			if (data instanceof HTMLFormElement) {
				ajaxData = data.serialize();
			}
			else {
				ajaxData = data;
			}
		} else if (typeof data == "string") {
			ajaxData = data;
			try {
				JSON.parse(data);
				contentType = "application/json;charset=UTF-8";
			} catch (e) {
				// json parse오류 발생시 form serialize로 간주
			}
		}
	}
	console.log(typeof ajaxData,ajaxData);
	console.log(contentType);
	if (loding) {
		loder_show();
	}
	$.ajax({
		type:"POST",
		url:url,
		contentType:contentType,
		dataType:"json",
		data:ajaxData,
		success : function(data){
			if (loding) {
				loder_hide();
			}
			if (callback && typeof callback == "function") {
				callback(data);
			}
		},
		error: function(request,status,error){
			if (loding) {
				loder_hide();
			}
            alert("code:"+request.status+"\n"+"error:"+error);
        }
 
	});
}
function setLoderTop() {
	var loader = $("html > div.loader");
	console.log(loader);
	if (loader.length == 1) {
		var h = loader.height();
		var iH = window.innerHeight;
		var hh = (iH/2+h);
		console.log($(document).scrollTop()+hh);
		loader.css("top",$(document).scrollTop()+hh+"px");
	}
}
function loder_show(){
	$('body').addClass('overlay-layer');
	if ($("html>div.loader").length < 1) {
		$("html").append('<div class="loader"></div>');
		setLoderTop();
	}
	//$('html').addClass('loader');
}
function loder_hide(){
	$('body').removeClass('overlay-layer');
	$("html>div.loader").remove();
	//$('html').removeClass('loader');
}

function resetHtml(targetId,list,fn) {
	// 초기화
	$("[for='"+targetId+"']").html("");
	list.forEach(function(data,i){
		data["_list_idx_"] = i;
		appendHtml(targetId,data);
	})
	if (fn && typeof fn == "function") {
		fn(targetId,list);
	}
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

function objConcat(obj1,obj2,flag) {
	var tmp = {};
	for (var k in obj1) {
		tmp[k] = obj1[k];
	}
	for (var k in obj2) {
		if(flag === true){
			tmp[k] = obj2[k];
		} else {
			if(tmp[k]==undefined) tmp[k] = obj2[k];
		}
	}
	return tmp;
}

function getMapCodeInfo(cd){
	//var mapper = [{"name":"강원도","upr_cd":"6420000","map_id":"42"},{"name":"경기도","upr_cd":"6410000","map_id":"41"},{"name":"광주광역시","upr_cd":"6290000","map_id":"29"},{"name":"대구광역시","upr_cd":"6270000","map_id":"27"},{"name":"대전광역시","upr_cd":"6300000","map_id":"30"},{"name":"부산광역시","upr_cd":"6260000","map_id":"26"},{"name":"서울특별시","upr_cd":"6110000","map_id":"11"},{"name":"세종특별자치시","upr_cd":"5690000","map_id":"36"},{"name":"울산광역시","upr_cd":"6310000","map_id":"31"},{"name":"인천광역시","upr_cd":"6280000","map_id":"28"}];
	// key : upr_cd
	//var mapper = {"5690000":"36","6110000":"11","6260000":"26","6270000":"27","6280000":"28","6290000":"29","6300000":"30","6310000":"31","6410000":"41","6420000":"42"};
	// key : map_id
	//var mapper = {"11":"6110000","26":"6260000","27":"6270000","28":"6280000","29":"6290000","30":"6300000","31":"6310000","36":"5690000","41":"6410000","42":"6420000"};
	// key : upr_cd,map_id
	var mapper = {"11":{"upr_cd":"6110000","map_id":"11","name":"서울특별시","latitude":37.6,"longitude":127.002},"26":{"upr_cd":"6260000","map_id":"26","name":"부산광역시","latitude":35.25,"longitude":129},"27":{"upr_cd":"6270000","map_id":"27","name":"대구광역시","latitude":35.87222,"longitude":128.6025},"28":{"upr_cd":"6280000","map_id":"28","name":"인천광역시","latitude":37.55,"longitude":126.65},"29":{"upr_cd":"6290000","map_id":"29","name":"광주광역시","latitude":35.18,"longitude":126.85},"30":{"upr_cd":"6300000","map_id":"30","name":"대전광역시","latitude":36.3,"longitude":127.43},"31":{"upr_cd":"6310000","map_id":"31","name":"울산광역시","latitude":35.53889,"longitude":129.31},"36":{"upr_cd":"5690000","map_id":"36","name":"세종특별자치시","latitude":36.6,"longitude":127.28167},"41":{"upr_cd":"6410000","map_id":"41","name":"경기도","latitude":37.3,"longitude":127.3},"42":{"upr_cd":"6420000","map_id":"42","name":"강원도","latitude":37.7,"longitude":128.3},"5690000":{"upr_cd":"5690000","map_id":"36","name":"세종특별자치시","latitude":36.6,"longitude":127.28167},"6110000":{"upr_cd":"6110000","map_id":"11","name":"서울특별시","latitude":37.6,"longitude":127.002},"6260000":{"upr_cd":"6260000","map_id":"26","name":"부산광역시","latitude":35.25,"longitude":129},"6270000":{"upr_cd":"6270000","map_id":"27","name":"대구광역시","latitude":35.87222,"longitude":128.6025},"6280000":{"upr_cd":"6280000","map_id":"28","name":"인천광역시","latitude":37.55,"longitude":126.65},"6290000":{"upr_cd":"6290000","map_id":"29","name":"광주광역시","latitude":35.18,"longitude":126.85},"6300000":{"upr_cd":"6300000","map_id":"30","name":"대전광역시","latitude":36.3,"longitude":127.43},"6310000":{"upr_cd":"6310000","map_id":"31","name":"울산광역시","latitude":35.53889,"longitude":129.31},"6410000":{"upr_cd":"6410000","map_id":"41","name":"경기도","latitude":37.3,"longitude":127.3},"6420000":{"upr_cd":"6420000","map_id":"42","name":"강원도","latitude":37.7,"longitude":128.3}};
	return mapper[cd||""]||"";
}

var upkindArr = [417000,422400,429900];
var upkindObj = {417000:{cd:417000,name:"강아지",color:"rgb(82, 161, 243)"},422400:{cd:422400,name:"고앵이",color:"rgb(166, 123, 251)"},429900:{cd:429900,name:"기타",color:"rgb(144, 144, 144)"}};
//축종코드
function getUpkindNm(cd) {
	if (cd == "417000") {
		return "강아지";
	} else if (cd == "422400") {
		return "고양이";
	} else if (cd == "429900") {
		return "기타";
	}
	return "";
}

var com = {};

com.alert = function (msg, fn) {
	$.alert({
	    title: '알림',
	    content: msg,
	    boxWidth: '300px',
	    useBootstrap: false,
	    icon: 'fa fa-question',
	    theme: 'material',
	    closeIcon: true,
	    animation: 'scale',
	    type: 'orange',
	    buttons: {
	        okay: {
	            text: '확인',
	            btnClass: 'btn-blue',
            	action: function () {
                	if (typeof fn == 'function') {
						fn();
					}
                }
	        }
	    }
	});
};

com.signConfirm = function(msg, fn) {
    $.confirm({
    	boxWidth: '300px',
    	useBootstrap: false,
        icon: 'fa fa-smile-o',
        theme: 'modern',
        closeIcon: true,
        animation: 'scale',
        type: 'blue',
        title: 'Hello',
        titleClass: '',
        typeAnimated: true,
        draggable: true,
        dragWindowGap: 15,
        dragWindowBorder: true,
        animateFromElement: true,
        smoothContent: true,
        content: msg,
        buttons: {
            ok: {
                action: function () {
                	if (typeof fn == 'function') {
						fn();
					}
                }
            },
            close: {
                action: function () {
                }
            },
        },
    });
};

com.confirm = function(option, fn) {
    $.confirm({
    	boxWidth: '300px',
    	useBootstrap: false,
        icon: 'fa fa-warning',
        theme: 'modern',
        closeIcon: true,
        animation: 'scale',
        type: 'purple',
        title: option.title,
        titleClass: '',
        typeAnimated: true,
        draggable: true,
        dragWindowGap: 15,
        dragWindowBorder: true,
        animateFromElement: true,
        smoothContent: true,
        content: option.msg,
        buttons: {
            ok: {
                action: function () {
                	if (typeof fn == 'function') {
						fn();
					}
                }
            },
            close: {
                action: function () {
                }
            },
        },
    });
};

