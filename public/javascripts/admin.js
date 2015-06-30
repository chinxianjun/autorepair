/**
 *按钮链接跳转函数
 * @param {String} url 点击后弹出或跳转的地址
 * @param {Boolean} newwin 为true则弹出，否则本页刷新
 */
function buttonGo(url,newwin){
	if (url){
		if (newwin){
			window.open(url);
		}else{
			window.location.href = url;
		}

	}
}
//普通用户登录弹框
var userSignIn = function(){
    $('#UserSignIn').click(function(){
        $( "#User" ).dialog( "open" );
       // userLogin();
	});
    $('#User').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
//                buttonGo('/workflows/workflow_flow');
			},
			"取消": function() {
				$(this).dialog("close");
			}
		}
	});
};
//管理员登录弹框
var managerSignIn = function(){
    $('#ManagerSignIn').click(function(){
        $( "#Manager" ).dialog( "open" );
        //managerLogin();
	});
    $('#Manager').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                buttonGo('/companies/');
			},
			"取消": function() {
				$(this).dialog("close");
			}
		}
	});
};


$(document).ready(function(){
    userSignIn();
    managerSignIn();
});

