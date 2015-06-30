//新增弹框
var newRole = function(){
    $('#newRole').click(function(){
        $( "#createRole" ).dialog( "open" );
	});
    $('#createRole').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                //需要提交表单
                //$(this).dialog("close");
                var rolename = $('#rolename').val();
                if(rolename.length === 0){
                    alert('请填写角色名称');
                    return false;
                }else if(rolename.length<2){
                    alert('名称至少4个字符');
                    return false;
                }else{
                    $.ajax({
                        type: 'POST',
                        beforeSend: function(xhr)
                        {
                            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                        },
                        url:  '/admin/roles',
                        //contentType: 'aplication/json',
                        dateType: 'json',
                        cache: false,
                        data: {
                            'role': {
                                'name': rolename
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.href = '/admin/roles';
                            },
                            422: function() {
                                alert("ERROR:422,内部数据错误，无法提交.");
                            }
                        }
                    })
                };
                $(this).dialog("close");
			},
			"取消": function() {
				$(this).dialog("close");
			}
		}
	});
};
//更新弹框
var editRole = function() {
    $('#editRole').click(function(){
        var rolename = $(this).text();
        alert(rolename);
        $( "#updateRole" ).dialog( "open" );
    });

    $('#updateRole').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                alert(rolename);
                $('input').attr({value:rolename});

                $(this).dialog("close");
			},
			"取消": function() {
				$(this).dialog("close");
			}
		}
	});
};
//Edit role button
var editRoleButton = function(){
    $('.editRole').click(function(){
        var id = $(this).attr('id');
        window.location.href = '/admin/roles/' + id + '/edit';
    })
};

$(document).ready(function(){
    newRole();
    editRole();
    editRoleButton();
});