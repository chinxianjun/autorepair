//新增弹框
var newGroup = function(){
    $('#J-add_group').click(function(){
        $( "#createGroup" ).dialog( "open" );
	});
    $('#createGroup').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                var groupname = $('#groupname').val();
                var company_id = $('#J_company_id').val();
                if(groupname.length === 0){
//                    showErrorTip(groupname, '请填写组名称', groupname);
                    alert('请填写组名称')
                }else if(groupname.length<2){
//                    showErrorTip(groupname, '组名称至少4个字符', groupname);
                    alert('组名称至少4个字符')
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/admin/companies/" + company_id + "/groups",
                        dateType: "json",
                        cache: false,
                        data: {
                            'group': {
                                'name': groupname
                            }
                        },
                        statusCode: {
                            201: function() {
                               window.location.reload();
                            },
                            422: function() {
                                alert('Error: 422, 内部数据错误, 无法提交');
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
//组添加用户弹框
var dialogGroupAddUser = function(){
    $(".group_add_users").click(function(){
        $("#J-group_add_users").dialog("open");
    });
    $("#J-group_add_users").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {

        }
    })
};


//组添加用户
var increaseUser = function(){
    $('#addusers').click(function(){
        //get all checked users
        var user_ids = new Array();
        $('#leftBox>div>input:checkbox').each(
            function(){
                user_ids.push($(this).attr('id'));
            }
        );
        if (user_ids.length === 0){
            confirm("没有选择任何用户");
            $.ajax({
                type: "POST",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/admin/companies/" + $("#J-company_id").val() + "/groups/" + $("#J-group_id").val() + "/create_users",
                dataType: "json",
                cache: false,
                data: {
                    "user_ids": user_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload();
    //                    parent.history.back(-1);
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }else{
            $.ajax({
                type: "POST",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/admin/companies/" + $("#J-company_id").val() + "/groups/" + $("#J-group_id").val() + "/create_users",
                dataType: "json",
                cache: false,
                data: {
                    "user_ids": user_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload();
    //                    parent.history.back(-1);
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    });
};

//组添加角色
var increaseRole = function(){
    $('#addroles').click(function(){
        //get all checked users
        var role_ids = new Array();
        $('#leftBox>div>input:checkbox').each(
            function(){
                role_ids.push($(this).attr('id'));
            }
        );
        if (role_ids.length === 0){
            confirm("没有选择任何角色");
            $.ajax({
                type: "POST",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/admin/companies/" + $("#J-company_id").val() + "/groups/" + $("#J-group_id").val() + "/create_roles",
                dataType: "json",
                //contentType: "application/json",
                cache: false,
                data: {
                    "role_ids": role_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload();
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            })
        }
        else{
            $.ajax({
                type: "POST",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/admin/companies/" + $("#J-company_id").val() + "/groups/" + $("#J-group_id").val() + "/create_roles",
                dataType: "json",
                cache: false,
                data: {
                    "role_ids": role_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload();
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            })
        }
    });
};
//移动选中的checkbox到左侧box
var toLeft = function(){
    $('#toLeft').click(function(){
        var name = $('h2').text();
        $('#rightBox>.userBox>input:checkbox:checked').each(
            function(){
                $('#leftBox').append('<div class="userBox"><input type="checkbox"' +
                    'class="userCheckbox" id="' + $(this).attr("id") + '"' +
                    ' value="' + $(this).val() + '"' +
                    '  name="' + name + '"/>' +
                    '<label for="' + $(this).attr("id") + '">' + $(this).val() +
                    '</label></div>');
                $(this).parent().remove();
            }
        );
    })
};
//移动选中的checkbox到右侧box
var toRight = function(){
    $('#toRight').click(function(){
        $('#leftBox>.userBox>input:checkbox:checked').each(
            function(){
//                alert($(this).val());
                $('#rightBox').append('<div class="userBox"><input type="checkbox"' +
                    'class="userCheckbox" id="' + $(this).attr("id") + '"' +
                    'value="' + $(this).val() + '" name=""/>' +
                    '<label for="' + $(this).attr("id") + '">' + $(this).val() +
                    '</label></div>');
                $(this).parent().remove();
            }
        );
    })
};
//新建员工
var newStaff = function(){
    $('#newStaff').click(function(){
        window.location.href = "/admin/users/sign_up";
    })
};
//新建组
var newGroupButton = function(){
    $("#J-newGroupButton").click(function(){
        window.location.href = "/admin/groups/new"
    })
};
//delete group
var deleteGroup = function(){
    var cid = $('#J-cid').val();
    $('.deleteGroup').click(function(){
        var id = $(this).attr('id');
        $.ajax({
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: "/admin/companies/" + cid + "/groups/" + id,
            type: 'DELETE',
            dataType: 'script',
            data: { '_method': 'delete' },
            statusCode: {
                200: function() {
                    window.location.reload();
                },
                403: function() {
                    window.location.href = "/home/forbidden";
                }
            }
        })
    })
};

$(document).ready(function(){
    newGroupButton();
    newGroup();
    deleteGroup();
    increaseUser();
    increaseRole();
    toLeft();
    toRight();
    newStaff();
    dialogGroupAddUser();
});