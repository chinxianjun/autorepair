//添加成员
var increaseMember = function(){
    $('.addMember').click(function(){
        //get all checked users
        var user_ids = new Array();
        var group_ids = new Array();
        var role_ids = new Array();

        $('input:checkbox[name="user"]:checked').each(
            function(){
                user_ids.push($(this).attr('value'));
            }
        );

        $('input:checkbox[name="group"]:checked').each(
            function(){
                group_ids.push($(this).attr('value'));
            }
        );

        $('input:checkbox[name="role"]:checked').each(
            function(){
                role_ids.push($(this).attr('value'));
            }
        );

        if (user_ids.length === 0 && group_ids.length === 0){
            alert("至少要选择一个员工或部门");
            return false;
        }else if(role_ids.length === 0){
            alert("至少要选择一个角色");
            return false;
        }else{
            $.ajax({
                type: "POST",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/members",
                dataType: "json",
                cache: false,
                data: {
                    "membership":{
                        "user_ids": user_ids,
                        "group_ids": group_ids,
                        "role_ids": role_ids
                    }
                },
                statusCode: {
                    200: function() {
                        window.location.reload("true");
                    },
                    201: function() {
                        window.location.reload("true");
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    });
};

//delete member
var deleteMember = function(){
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

var editMember = function(){
    $(".updateMember").click(function(){
        var role_ids = new Array();
        $('input:checkbox[name="role"]:checked').each(
            function(){
                role_ids.push($(this).attr('value'));
            }
        );

        if(role_ids.length === 0){
            alert("至少要选择一个角色");
            return false;
        }else{
            $.ajax({
                type: "PUT",
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/members/" + $("#J-member_id").val(),
                dataType: "json",
                cache: false,
                data: {
                    "role_ids": role_ids
                },
                statusCode: {
                    200: function() {
                        window.location.href = "/warehouses/" + $("#J-warehouse_id").val() + "/members/";
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    })
};

$(document).ready(function(){
    deleteMember();
    increaseMember();
    editMember();
});