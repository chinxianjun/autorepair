//新增用户弹框
var addUser = function(){
    $('.newUser').click(function(){
        $( "#J-create_user" ).dialog( "open" );
	});
    $('#J-create_user').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                var user_name = $('#J-username').val();
                var full_name = $('#J-fullname').val();
                var password = $('#J-password').val();
                var phone = $("#J-phone").val();

                if(user_name.length === 0){
                    alert('请填写员工登录名');
                    return false;
                }else if(password.length === 0){
                    alert('请填写员工登录密码');
                    return false;
                }else if(full_name.length === 0){
                    alert('请填写员工姓名');
                    return false;
                }else if(phone.length === 0){
                    alert('请填写员工电话');
                    return false;
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/admin/users",
                        dateType: "json",
                        cache: false,
                        data: {
                            'user': {
                                'username': user_name,
                                'password': password,
                                'fullname': full_name,
                                'phone': phone,
                                'email': user_name + "@ht4s.com"
                            }
                        },
                        statusCode: {
                            0: function() {
                                window.location.href = "/admin/users";
                            },
                            201: function() {
                                window.location.href = "/admin/users";
                            },
                            422: function() {
                                alert('Error: 422,无法创建用户, ' + user_name + '已经存在');
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

var addUserFormAdmin = function(){
    $("#J-new_user").click(function(){

        var user_name = $('#J-username').val();
        var full_name = $('#J-fullname').val();
        var password = $('#J-password').val();
        var phone = $("#J-phone").val();

        if(user_name.length === 0){
            alert('请填写员工登录名');
            return false;
        }else if(password.length === 0){
            alert('请填写员工登录密码');
            return false;
        }else if(full_name.length === 0){
            alert('请填写员工姓名');
            return false;
        }else if(phone.length === 0){
            alert('请填写员工电话');
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/users",
                dateType: "json",
                cache: false,
                data: {
                    'user': {
                        'username': user_name,
                        'password': password,
                        'fullname': full_name,
                        'phone': phone,
                        'email': user_name + "@ht4s.com"
                    }
                },
                statusCode: {
                    0: function() {
                        window.location.href = "/admin/users";
                    },
                    201: function() {
                        window.location.href = "/admin/users";
                    },
                    422: function() {
                        alert('Error: 422,无法创建用户, ' + user_name + '已经存在');
                    }
                }
            })
        }
    })
};

var editUser = function(){
    $('.editUser').click(function(){
        var id = $(this).attr('id');
        window.location.href = '/admin/users/' + id + '/edit'
    })
};

var searchUser = function() {
  $("#users th a, #users .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
    return false;
  });
};

$(document).ready(function(){
    setCompany();
    addUser();
    editUser();
    searchUser();
    addUserFormAdmin();
});