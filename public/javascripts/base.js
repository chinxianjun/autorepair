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
};

//新增按钮样式
var addButton = function(){
    $('.tool-bar>button.add-btn').button({
        icons: {
            primary: "ui-icon-document"
        }
    });
};

//搜索按钮样式
var searchButton = function(){
    $('.tool-bar>button.search-btn').button({
        icons: {
            primary: "ui-icon-search"
        }
    });
};
//删除按钮样式
var deleteButton = function(){
    $('.tool-bar>button.delete-btn').button({
        icons: {
            primary: "ui-icon-trash"
        }
    });
    $('.delete-btn').click(function(e){
		e.preventDefault();
		var el = $(this);
        var href = window.location.pathname;
		if($('#dialog-confirm').size()===0){
			$('<div id="dialog-confirm" title="确定删除吗?">' +
                '<p style="padding:15px 0 0 0">' +
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">' +
                '</span>' +
                '注意： 数据删除后将不可恢复</p>' +
                '</div>').appendTo($('body'));
		}
		$( "#dialog-confirm" ).dialog({
            resizable: false,
            height:150,
            modal: true,
            buttons: {
                "确认删除": function() {
                    el.parents('tr').remove();
                    //$.ajax();
                    $.ajax({
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url: href.replace('/delete', ''),
                        type: 'post',
                        dataType: 'script',
                        data: { '_method': 'delete' },
                        success: function() {
                            //重新载入当前页
                            window.location.reload($(this).href);
                        }
                    });
                    $( "#dialog-confirm" ).dialog( "close" );
                },
                "取消": function() {
                    $( "#dialog-confirm" ).dialog( "close" );
                }
            }
		});
	});
};

//全选按钮样式
var checkButton = function(){
    $('.tool-bar>button.check-btn').button({
        icons: {
            primary: "ui-icon-bullet"
        }
    });
};

//反选按钮样式
var uncheckButton = function(){
    $('.tool-bar>button.uncheck-btn').button({
        icons: {
            primary: "ui-icon-radio-off"
        }
    });
};

//修改按钮样式
var editButton = function(){
    $('.tool-bar>button.edit-btn').button({
        icons: {
            primary: "ui-icon-pencil"
        }
    });
};

//提交按钮样式
var submitButton = function(){
    $('.tool-bar>button.submit-btn').button({
        icons: {
            primary: "ui-icon-disk"
        }
    });
};

//取消按钮样式
var cancelButton = function(){
    $('.tool-bar>button.cancel-btn').button({
        icons: {
            primary: "ui-icon-arrowreturnthick-1-w"
        }
    });
};
//注销按钮样式
var logoutButton = function(){
    $('.tool-bar>button.logout-btn').button({
        icons: {
            primary: "ui-icon-arrowreturnthick-1-w"
        }
    });
};

//单选/复选按钮样式
var radioCheckbox = function(){
    $( ".radio, .checkbox" ).buttonset();
};

//表格样式
var tableStyle = function(){
//    $('.admin-table>tbody>tr:nth-child(even)').addClass('even');
    if ($('.admin-table>tbody>tr:nth-child(even)').hasClass("td-color")){
    }else if ($('.admin-table>tbody>tr:nth-child(even)').hasClass("td-color_blue")) {
    }else{
//        $(this).addClass('even');
        $('.admin-table>tbody>tr:nth-child(even)').addClass("even");
    }
    $('.admin-table>tbody>tr').mouseover(function(){
        $(this).addClass('hover');
    }).mouseout(function(){
        $(this).removeClass('hover');
    });
};

//日期选择 --- datepicker --- jquery ui date function
var dateSelect = function(){
    $.datepicker.setDefaults( $.datepicker.regional[ "zh-CN" ] );

    $( ".datepicker" ).datepicker(
        {
            maxDate: '+0d',
//            minDate: new Date(2007, 1, 1),
            yearRange: '1950:c+0',  // c+0 => current + 0年
            changeMonth: true,
            changeYear: true
    });
};

//全选
var checkall = function(){
    $('.check-btn').click(function(){
//        alert("checkall");
        $(':checkbox').attr("checked", true);
        return false;
    })
};
//反选
var uncheckall = function(){
   $('.uncheck-btn').click(function(){
       $(":checkbox").attr("checked", false);
       return false;
   })
};
//返回上一页面
var cancel = function(){
  $('.cancel-btn').click(function(){
        parent.history.back();
        return false;
  })
};
//删除数据
var deleteItem = function(){
    $('a.deleteItem').click(function(event) {
        if ( confirm("注意：数据删除后将无法恢复") )
            $.ajax({
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: this.href.replace('/delete', ''),
                type: 'post',
                dataType: 'script',
                data: { '_method': 'delete' },
                statusCode: {
                        200: function() {
                            window.location.reload();
                        },
                        401: function() {
                            window.location.reload();
                        },
                        403: function() {
                            window.location.href = "/home/forbidden";
                        }
                }
            });

        return false;
    });
};
//新建管理员
var newAdmin = function(){
    $('#newAdmin').click(function(){
        window.location.href="/users/sign_up";
    });
};
//使用jQueryUI生成tabs
var jartaiTabs = function(){
  $( "#J-jartai-tabs" ).tabs({
    ajaxOptions:
    {
        error: function( xhr, status, index, anchor ) {
            $( anchor.hash ).html(
                    "生成tab失败." );
        }
    }
  });
};

//form clean
$.fn.clearForm = function() {
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    if (tag == 'form')
      return $(':input',this).clearForm();
    if (type == 'text' || type == 'password' || tag == 'textarea')
      this.value = '';
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    else if (tag == 'select')
      this.selectedIndex = -1;
  });
};
var workflowI18n = function(){
    var dictionary = {
        'dispatch':'派工',
        'vehicle':'车辆',
        'fault':'故障',
        'oldpart':'旧件',
        'newpart':'新件',
        'report':'上报',
        'expense':'费用'
    };
    $.each(dictionary, function(key, val){
        switch(key){
            case $('.workflow_status').text():
                $('.workflow_status').text(val);
                break;
            default:
                break;
        }
    })
};
//tooltip
var infoTip = function(){
    $(".tooltip").tooltip();
};
// logout when current user is login
var logout = function(){
    $(".logout-btn").click(function(){
        window.location.href = "/home/index";
    })
};

//选择公司
var setCompany = function(){
    $('#J-select_company').change(function(){
        // get current url
        var href = window.location.pathname;
        // get selected company id
        var id = $("select option:selected").val();

        window.location.href = href + "?JCompanyID=" + id;
    })
};

$(document).ready(function(){
    addButton();
    deleteButton();
    checkButton();
    uncheckButton();
    editButton();
    submitButton();
    cancelButton();
    searchButton();
    radioCheckbox();
    logoutButton();
    tableStyle();
    deleteItem();
    checkall();
    uncheckall();
    cancel();
    newAdmin();
    jartaiTabs();
    dateSelect();
    workflowI18n();
    logout();
    setCompany();


// Create two variable with the names of the months and days in an array
    var monthNames = [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月",
        "十月", "十一月", "十二月" ];
    var dayNames= ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]

    setInterval(function(){
        // Create a today() object
        var today = new Date();
        // Extract the current date from Date object
        today.setDate(today.getDate());
        var seconds = new Date().getSeconds();
        var minutes = new Date().getMinutes();
        var hours = new Date().getHours();
        seconds = checkTime(seconds);
        minutes = checkTime(minutes);
        hours = checkTime(hours);
        // Output the day, date, month and year
        $('#date').html(today.getFullYear() + "年 " + monthNames[today.getMonth()]
            + " " + today.getDate() + "日 " + dayNames[today.getDay()]
            + " " + hours
            + ":" + minutes);

    }, 1000);
    function checkTime(i)
    {
        if (i<10) 
        {
            i="0" + i
        }
        return i            
    }
});