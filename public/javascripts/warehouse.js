//添加配件库弹窗
var addWarehouseDialog = function(){
    $("#J-add_warehouse").click(function(){
        $("#createWarehouse").dialog("open");
    });
    $("#createWarehouse").dialog({
        autoOpen: false,
        width: 550,
        modal: true,
        buttons: {
            "保存": function() {
                var name = $('#J-warehouse_name').val();
                var company_id = $('#J_company_id').val();
                var identifier = $("#J-identifier").val();
                var category = $("input:radio[name=warehouse_category]:checked").val();
                var parent_id = $("select:checked").val();

                if(name.length === 0){
                    alert('请填写组名称')
                }else if(name.length<2){
                    alert('组名称至少4个字符')
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/warehouses?company_id=" + company_id,
                        dateType: "json",
                        cache: false,
                        data: {
                            'warehouse': {
                                'name': name,
                                'category': category,
                                'identifier': identifier,
                                'parent_id': parent_id
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.reload("true");
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
    })
};

var addWarehouse = function(){
    $("#J-add_warehouse_save").click(function(){
        var name = $('#J-warehouse_name').val();
        var category = $("#J-warehouse_category>input:radio[checked]").val();
        var company = $("#J-warehouse_company>input:radio[checked]").val();
        var parent_warehouse = $("J-parent_warehouse").val();
        var identifier = $("#J-identifier").val();
        var parent_id = $("#J-parent_warehouse_id").val();
        var company_id = $("#J_company_id").val();

        if(name.length === 0){
            alert("请填写配件库名称");
            return false;
        }else if($('input:radio:checked').length === 0){
            alert("请选择配件库类别");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/warehouses?company_id=" + company_id,
                dateType: "json",
                cache: false,
                data: {
                    'warehouse': {
                        'name': name,
                        'category': category,
                        'company': company,
                        'identifier': identifier,
                        'parent_id': parent_id
                    }
                },
                statusCode: {
                    201: function() {
                        window.location.reload("true");
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR: 422, 内部数据错误，无法提交.");
                    }
                }
            });
        }
    });
};

var editWarehouse = function(){
    $(".editWarehouse").click(function(){
        var id = $("#J-warehouse_id").val();
        var company_id = $("#J-company_id").val();
        window.location.href="/warehouses/" + id + "/edit"
    })
};

var updateWarehouse = function(){
    $(".updateWarehouse").click(function(){
        var name = $("#J-warehouse_name").val();
        var category = $("input:radio[name=warehouse_category]:checked").val();
        var parent_warehouse_id = $("select:checked").val();
        var company_id = $("#J-company_id").val();
        var warehouse_id = $("#J-warehouse_id").val();

        if (name.length ===0){
            alert("请输入配件库名称");
            return false;
        }else if(category == null){
            alert("请选择配件库类别");
            return false;
        }else{
            $.ajax({
                url:"/warehouses/" + warehouse_id,
                headers:{
                    'X-Transaction':'POST Example',
                    'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                },
                dataType:"json",
                type:"PUT",
                data:{
                    'warehouse':{
                        'name':name,
                        'category':category,
                        'parent_id': parent_warehouse_id
                    }
                },
                statusCode:{
                    200:function () {
                        window.location.href="/admin/companies/" + company_id + "/setting";
                    },
                    403:function () {
                        window.location.href = "/home/forbidden";
                    },
                    422:function () {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            })
        }
    })
};
//To use part autocomplete
var warehouseComplete = function() {
    $('input.autocomplete').each(function(){
        var input = $(this);
        input.autocomplete(input.attr('autocomplete_url'));
    });
};
//search warehouses
var searchWarehouse = function() {
    $("#warehouses th a, #warehouses .pagination a").live("click", function() {
        $.getScript(this.href);
        return false;
    });
    $("#warehouses_search input").keyup(function() {
        $.get($("#warehouses_search").attr("action"), $("#warehouses_search").serialize(), null, "script");
        return false;
    });
};

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
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/create_users",
                dataType: "json",
                cache: false,
                data: {
                    "user_ids": user_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload("true");
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
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/create_users",
                dataType: "json",
                cache: false,
                data: {
                    "user_ids": user_ids
                },
                statusCode: {
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
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/create_roles",
                dataType: "json",
                cache: false,
                data: {
                    "role_ids": role_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload("true");
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
                url: "/warehouses/" + $("#J-warehouse_id").val() + "/create_roles",
                dataType: "json",
                cache: false,
                data: {
                    "role_ids": role_ids
                },
                statusCode: {
                    201: function() {
                        window.location.reload("true");
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            })
        }
    });
};

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

var toRight = function(){
    $('#toRight').click(function(){
        $('#leftBox>.userBox>input:checkbox:checked').each(
            function(){
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

$(document).ready(function(){
    addWarehouseDialog();
    addWarehouse();
    editWarehouse();
    updateWarehouse();
    warehouseComplete();
    searchWarehouse();
    increaseUser();
    increaseRole();
    toLeft();
    toRight();
});