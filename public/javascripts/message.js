//array chunk
function chunk(array, chunk){
    for(var x, i = 0, c = -1, l = array.length, n = []; i < l; i++)
        (x = i % chunk) ? n[c][x] = array[i] : n[++c] = [array[i]];
    return n;
}

//新增信息弹框
var newMessage = function(){
    $('.newMessage').click(function(){
        $( "#J-message_create" ).dialog( "open" );
	});
    $('#J-message_create').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                var content = $('#J-content').val();
                var category = $('#J-category').val();
                var creator = $('#J-creator').val();
                if(content.length === 0){
                    alert("请填写短信内容");
                    return false;
//                    showErrorTip(username, '请填写客户姓名',username);
                }else if(content.length>66){
                    alert("短信内容不能超过66字");
                    return false;
//                    showErrorTip(username, '客户姓名至少2个字符',username);
                }else if(category.length === 0){
                    alert("请填写联系电话");
                    return false;
//                    showErrorTip(phone, '请填写联系电话', phone);
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/messages",
                        dateType: "json",
                        async: false,
                        cache: false,
                        data: {
                            'message': {
                                'category': category,
                                'content': content,
                                'creator': creator
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.href="/messages";
                            },
                            403: function() {
                                window.location.href = "/home/forbidden";
                            },
                            422: function() {
                                alert('创建失败');
                            }
                        }
                    })
                }
                $(this).dialog("close");
			},
			"取消": function() {
				$(this).dialog("close");
			}
		}
	});
};
//编辑信息
var editMessage = function() {
    //保存当前href
    var href = window.location.pathname;
    $(".editMessage").click(function() {
        $("#J-message_update").dialog("open");
        $.ajax({
            url: window.location.pathname + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "category":
                            $("#U-category").attr('value', val);
                            break;
                        case "content":
                            $("textarea").text(val);
                            break;
                        case "creator":
                            $("#J-creator").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-message_update").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: href,
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'message': {
                            'category': $("#U-category").val(),
                            'content': $("U-content").val(),
                            'creator': $("#U-creator").val()
                        }
                    },
                    statusCode: {
                        200: function() {
                            window.location.reload(href);
                        },
                        403: function() {
                            window.location.href = "/home/forbidden";
                        },
                        422: function() {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
			"取消": function() {
				$(this).dialog("close");
			}
        }
    })
};
//编辑信息 index page
var editMessageLink = function() {
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function(e){
       e.stopPropagation();
    });
    $(".editMessageLink").click(function() {
        $("#J-message_update").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url: href + "/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "category":
                            $("#U-category").attr('value', val);
                            break;
                        case "content":
                            $("textarea").text(val);
                            break;
                        case "creator":
                            $("#U-creator").attr('value', val);
                            break;
                        case "id":
                            $("#U-message_id").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-message_update").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: href + $("#U-message_id").val(),
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'message': {
                            'category': $("#U-category").val(),
                            'content': $("#U-content").val(),
                            'creator': $("#U-creator").val()
                        }
                    },
                    statusCode: {
                        200: function() {
                            window.location.reload(href);
                        },
                        403: function() {
                            window.location.href = "/home/forbidden";
                        },
                        422: function() {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
			"取消": function() {
				$(this).dialog("close");
			}
        }
    })
};

var regAccount = function(message_account, message_password){
    $("#J-message_sign_in").click(function(){
//        var account = $("#J-message_account").val();
//        var password = $("#J-message_password").val();
        var password_md5 = $.md5(message_password);
        var href = "http://sms.pica.com/zqhdServer/reg.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" +
            "&CNAME=a" +
            "&CSNAME=a" +
            "&ENAME=a" +
            "&CSNAME=a" +
            "&ENTERPRISETYPEID=01&ADDR=a" +
            "&LINKTEL=a" +
            "&LINKMAN=a&EMAIL=a" +
            "&FAX=a" +
            "&POSTCODE=a" +
            "&MOBILETEL=a";
        // &CNAME=中文公司名&ENAME=英文公
        //司 名 &CSNAME= 中 文 简 称 &ESNAME= 英 文 简 称 &ENTERPRISETYPEID=01&ADDR= 联 系 地 址
        //&LINKTEL=联系电话&LINKMAN=&EMAIL=邮箱地址&FAX=传真&POSTCODE=邮编(6 字符长
        //度)&MOBILETEL=联系手机

        if (account.length === 0) {
            alert("没有输入帐号");
            return false;
        } else if (password.length === 0) {
            alert("没有输入密码");
            return false;
        } else {
            $.get(href, function(data) {
                $('#J-receive_content').append(data);
                window.location.href = "/messages";
            });
        }
    });
};
//send message
var sendMSG = function(message_account, message_password){
    $("#J-message_send").click(function() {
        var back_url = window.location.pathname;
        var current_user = $("#J-current_user").val();
        var phone = $("#J-message_phone").val();
        var receive_man = $("#J-message_name").val();
        var content_pro = $("#J-message_content").val();
        var content = ec_GBK(content_pro);

        var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

        reg = /^13[0-9]{9}|15[012356789][0-9]{8}|18[0256789][0-9]{8}|147[0-9]{8}$/;

        if ( phone.length != 11 ) {
            alert("手机号码位数不正确");
            return false;
        } else if ( !reg.test(phone)) {
            alert("手机号码不正确");
            return false;
        } else if (content.length === 0) {
            alert("没有输入短信内容");
            return false;
        } else {
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/messages/history",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'history': {
                        'send_man': current_user,
                        'receive_man': receive_man,
                        'content': content_pro
                    }
                },
                statusCode: {
                    0: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/customers";});
                    },
                    201: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/customers";});
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert('创建失败');
                    }
                }
            })
        }
    });
};
var multi_send_msg = function(message_account, message_password){
  var phone = $("J-message_phone").val();
  var content = $("J-message_content").val();
  $("J-message_multi_send").click(function(){
    $("#J-select_customers").dialog("open");
  });
  $("#J-select_customers").dialog({
    autoOpen: false,
    width: 550,
    modal: true,
    buttons: {
        "保存": function() {
              $.ajax({
                  url: "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
                              "&pwd=" + message_password +
                              "&phone=" + phone +
                              "&CONTENT=" + content +
                              "&extnum=1" +
                              "&level=1" +
                              "&schtime=null" +
                              "&reportflag=0" +
                              "&url=" +
                              "&smstype=0" +
                              "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  headers: {
                      'X-Transaction': 'POST Example',
                      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                  },
                  dataType: "json",
                  type: "get",
                  statusCode: {
                      200: function() {
                          window.location.reload(href);
                      },
                      403: function() {
                          window.location.href = "/home/forbidden";
                      },
                      422: function() {
                          alert("ERROR:422,内部数据错误，无法提交.");
                      }
                  }
              });
              $(this).dialog("close");
          },
        "取消": function() {
            $(this).dialog("close");
        }
      }
  })
};
//
var selectType = function(){
    $('#J-go_type').click(function() {
        if ($('input:radio:checked').val() === "公司") {
            window.location.href = "/messages/company_message";
        }
        else if ($('input:radio:checked').val() === "客户") {
            window.location.href = "/messages/customer_message";
        }
    });
};
var goSend = function(){
    $("#J-go_send").click(function() {
        var category_ids =  new Array();
        $('.selectCategory input:checkbox:checked').each(function() {
            category_ids.push($(this).attr('id'));
        });

        var group_ids = new Array();
        $('.selectDepart input:checkbox:checked').each(function() {
            group_ids.push($(this).attr('id'));
        });

        if ( category_ids.length > 0) {
            window.location.href = "/messages/multi_messages?category_ids=" + category_ids
        } else if ( group_ids.length > 0 ) {
            window.location.href = "/messages/multi_messages?group_ids=" + group_ids
        }
        else {
            alert("没有获取到客户或公司的分类ID");
            return false;
        }
    })
};
// multi message
var multi_message = function(message_account, message_password){
    $("#J-multi_message").click(function() {
        var current_user = $("#J-current_user").val();
        var phones = [];
        $("#J-people :checked").each(function() {
            phones.push($(this).val());
        });
        var men = [];

        $("#J-people :checked + label").each(function() {
            var str_men = $(this).text();
            str_men = $.trim(str_men);
            men.push(str_men);
        });

        var long_men = men.join(',');
        var content_pro = $("#J-message_content").val();
        var content = ec_GBK(content_pro);
        phones = jQuery.unique(phones);
        var l_phones = phones.length;
        var temparray = chunk(phones, 30);

        if (l_phones === 0) {
            alert("没有选择用户");
            return false;
        } else if ( content.length === 0 ){
            alert("没有输入短信内容");
            return false;
        } else {
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/messages/history",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'history': {
                        'send_man': current_user,
                        'receive_man': long_men,
                        'content': content_pro
                    }
                }
//                statusCode: {
//                    0: function() {
//                        $.get(href, function () {
//                            $('#J-receive_content').append(data);
//                        })
//                        .complete(function(){window.location.href = "/home/login";});
//                    },
//                    201: function() {
//                        $.get(href, function () {
//                            $('#J-receive_content').append(data);
//                        })
//                        .complete(function(){window.location.href = "/home/login";});
//                    },
//                    403: function() {
//                        window.location.href = "/home/forbidden";
//                    },
//                    422: function() {
//                        alert('创建失败');
//                    }
//                }
            });

            $.each(temparray, function(index, value){
                var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
                   "&pwd=" + message_password +
                   "&phone=" + value +
                   "&CONTENT=" + content +
                   "&extnum=1" +
                   "&level=1" +
                   "&schtime=null" +
                   "&reportflag=0" +
                   "&url=" +
                   "&smstype=0" +
                   "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

                setTimeout(function(){
                    $.get(href, function() {
                        $('#J-receive_content').append(data);
                    });
                }, 200)
            });
            $("#J-multi_message").attr("disabled", true);
            setTimeout(function(){
                window.location.href = "/messages/history";
            }, 2000);
        }
    })
};

var registMSG = function(message_account, message_password){
    $("#J-registMSG").click(function(){
        window.location.href = "http://sms.pica.com/zqhdServer/reg.jsp?regcode=" + message_account +
            "&pwd=" + message_password + "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" +
            "&CNAME=1&ENAME=1&CSNAME=1&ESNAME=1&ENTERPRISETYPEID=01&ADDR=1&LINKTEL=1" +
            "&LINKMAN=1&EMAIL=1&FAX=1&POSTCODE=1&MOBILETEL=1"

    });
};
//余额
var getBalance = function(message_account, message_password){
    $("#J-getBalance").click(function(){
//        alert(message_account);
//        alert(message_password);
//        return false;
        window.location.href = "http://sms.pica.com/zqhdServer/getbalance.jsp?regcode="
            + message_account + "&pwd=" + message_password
            + "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    })
};
//历史记录
var getReport = function(message_account, message_password){
    $("#J-getReport").click(function(){
//        alert(message_account);
//        alert(message_password);
//        return false;
        window.location.href = "http://sms.pica.com/zqhdServer/getreport.jsp?regcode="
           + message_account + "&pwd=" + message_password
           + "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        this.target = "_blank";
    })
};

var worldCount = function(){
    $("#J-message_content").bind('focus keyup input paste',function(){
	    $('#number').text($(this).attr("value").length);
    });
};

$(document).ready(function(){
    var message_account = "ZXHD-SDK-0108-EBQNKI";
    var message_password = "93145133";
    message_password = $.md5(message_password);
    newMessage();
    editMessage();
    editMessageLink();
    regAccount(message_account, message_password);
    sendMSG(message_account, message_password);
    multi_send_msg(message_account, message_password);
    selectType();
    goSend();
    multi_message(message_account, message_password);
    registMSG(message_account, message_password);
    getBalance(message_account, message_password);
    getReport(message_account, message_password);
    worldCount();
});