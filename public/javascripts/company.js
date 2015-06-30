//新增弹框
var newCompany = function(){
    $('.newCompany, #newCompany').click(function(){
        $( "#createCompany" ).dialog( "open" );
	});
    $('#createCompany').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                var name = $('#name').val();
                var simply = $('#simply').val();
                var state = $('#state').val();
                var address = $('#address').val();
                var phone = $('#phone').val();
                var company_code = $('#company_code').val();
                if(name.length === 0){
                    alert('公司名称不能为空');
                    return false;
                }else if(name.length<2){
                    alert('公司名称太短');
                    return false;
                }else if(simply.length === 0){
                    alert('公司简称不能为空');
                    return false;
                }else if(company_code.length === 0){
                    alert('公司代码不能为空');
                    return false;
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/admin/companies",
                        dateType: "json",
                        cache: false,
                        data: {
                            'company': {
                                'name': name,
                                'simply': simply,
                                'state': state,
                                'address': address,
                                'phone': phone,
                                'company_code': company_code
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.reload(true);
                            },
                            422: function() {
                                alert("错误:422, 内部数据有错误");
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
//公司添加维修工
var increaseRepaire = function(){
    $('#J-add_repairers').click(function(){
        //get all checked users
        var user_ids = new Array();
        $('#leftBox>div>input:checkbox').each(
            function(){
                user_ids.push($(this).attr('id'));
            }
        );
        $.ajax({
            type: "POST",
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: "/admin/companies/" + $("#J-company_id").val() + "/create_repairers/",
            dataType: "json",
            cache: false,
            data: {
                "user_ids": user_ids
            },
            statusCode: {
                201: function() {
                    window.location.reload(true);
//                    parent.history.back(-1);
                },
                422: function() {
                    alert("错误:422, 传输数据格式正确,但内部数据有错误");
                }
            }
        });
    });
};
//公司添加业务员
var increaseSalesman = function(){
    $('#J-add_salesmen').click(function(){
        //get all checked users
        var user_ids = new Array();
        $('#leftBoxSalesman>div>input:checkbox').each(
            function(){
                user_ids.push($(this).attr('id'));
            }
        );
        $.ajax({
            type: "POST",
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: "/admin/companies/" + $("#J-company_id").val() + "/create_salesmen/",
            dataType: "json",
            cache: false,
            data: {
                "user_ids": user_ids
            },
            statusCode: {
                201: function() {
                    window.location.reload(true);
//                    parent.history.back(-1);
                },
                422: function() {
                    alert("错误:422, 传输数据格式正确,但内部数据有错误");
                }
            }
        });
    });
};
//移动选中的checkbox到左侧box
var toLeftSalesman = function(){
    $('#toLeftSalesman').click(function(){
        var name = $('h2').text()
        $('#rightBoxSalesman>.userBox>input:checkbox:checked').each(
            function(){
                $('#leftBoxSalesman').append('<div class="userBox"><input type="checkbox"' +
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
//移动选中的checkbox到左侧box
var toLeft = function(){
    $('#toLeft').click(function(){
        var name = $('h2').text()
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
var toRightSalesman = function(){
    $('#toRightSalesman').click(function(){
        $('#leftBoxSalesman>.userBox>input:checkbox:checked').each(
            function(){
//                alert($(this).val());
                $('#rightBoxSalesman').append('<div class="userBox"><input type="checkbox"' +
                    'class="userCheckbox" id="' + $(this).attr("id") + '"' +
                    'value="' + $(this).val() + '" name=""/>' +
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
//选择tabs
//var selectTab = function(){
//    $('#J-companyShow').click(function(){
//        $('#J-company_show').show('fast');
//        $('#J-companyShow').addClass('tab_active');
//        $('#J-groupIndex').removeClass('tab_active');
//        $('#J-companyRepairer').removeClass('tab_active');
//        $('#J-companySalesman').removeClass('tab_active');
//        $('#J-companyWarehouse').removeClass('tab_active');
//        $('#J-group_index').hide('fast');
//        $('#J-company_repairer').hide('fast');
//        $('#J-company_salesman').hide('fast');
//        $("#J-company_warehouse").hide("fast");
//    });
//    $('#J-groupIndex').click(function(){
//        $('#J-group_index').show('fast');
//        $('#J-groupIndex').addClass('tab_active');
//        $('#J-companyShow').removeClass('tab_active');
//        $('#J-companyRepairer').removeClass('tab_active');
//        $('#J-companySalesman').removeClass('tab_active');
//        $('#J-companyWarehouse').removeClass('tab_active');
//        $('#J-company_show').hide('fast');
//        $('#J-company_repairer').hide('fast');
//        $('#J-company_salesman').hide('fast');
//        $("#J-company_warehouse").hide("fast");
//    });
//    $('#J-companyRepairer').click(function(){
//        $('#J-company_repairer').show('fast');
//        $('#J-companyRepairer').addClass('tab_active');
//        $('#J-companyShow').removeClass('tab_active');
//        $('#J-groupIndex').removeClass('tab_active');
//        $('#J-companySalesman').removeClass('tab_active');
//        $('#J-companyWarehouse').removeClass('tab_active');
//        $('#J-group_index').hide('fast');
//        $('#J-company_show').hide('fast');
//        $('#J-company_salesman').hide('fast');
//        $("#J-company_warehouse").hide("fast");
//    });
//    $('#J-companySalesman').click(function(){
//        $('#J-company_salesman').show('fast');
//        $('#J-companySalesman').addClass('tab_active');
//        $('#J-companyShow').removeClass('tab_active');
//        $('#J-groupIndex').removeClass('tab_active');
//        $('#J-companyRepairer').removeClass('tab_active');
//        $('#J-companyWarehouse').removeClass('tab_active');
//        $('#J-group_index').hide('fast');
//        $('#J-company_show').hide('fast');
//        $('#J-company_repairer').hide('fast');
//        $("#J-company_warehouse").hide("fast");
//    });
//    $('#J-companyWarehouse').click(function(){
//        $('#J-company_warehouse').show('fast');
//        $('#J-companyWarehouse').addClass('tab_active');
//        $('#J-companyShow').removeClass('tab_active');
//        $('#J-groupIndex').removeClass('tab_active');
//        $('#J-companyRepairer').removeClass('tab_active');
//        $('#J-companySalesman').removeClass('tab_active');
//        $('#J-group_index').hide('fast');
//        $('#J-company_show').hide('fast');
//        $('#J-company_repairer').hide('fast');
//        $('#J-company_salesman').hide('fast');
//    });
//};
// edit company button
var editCompany = function(){
    $('.editCompany').click(function(){
        var id = $(this).attr('id');
        window.location.href = '/admin/companies/' + id + '/edit'
    })
};
// edit current_Manager button
var editManager = function(){
    $('.editManager').click(function(){
        var id = $(this).attr('id');
        window.location.href = '/admin/managers/' + id + '/edit'
    })
};
// edit group button
var editGroup = function(){
    $('.editGroup').click(function(){
        var id = $(this).attr('id');
        var cid = $('#J-cid').val();
        window.location.href = '/admin/companies/' + cid + '/groups/' + id + '/edit';
    })
};
//
//新增配件库弹框
var newWarehouse = function(){
    $('#newWarehouse').click(function(){
        $( "#createWarehouse" ).dialog( "open" );
    });
    $('#createWarehouse').dialog({
        autoOpen: false,
        width: 550,
        modal: true,
        buttons: {
            "保存": function() {
                var name = $('#J-warehouse_name').val();
                var category = $("#J-warehouse_category>input:radio[checked]").val();
                var manager = $('#J-warehouse_manager').val();
                var parent_warehouse = $("J-parent_warehouse").val();
                var identifier = $("#J-identifier").val();
                var parent_id = $("#J-parent_warehouse>select option:selected").val();
                var company_id = $("#J_company_id").val();

                if(name.length === 0){
                    alert("请填写配件库名称");
                    return false;
                }else if(category === null){
                    alert("请选择配件库类别");
                    return false;
                }else if(identifier.length === null){
                    alert("请选择配件库类别");
                    return false;
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/admin/companies/" + company_id + "/warehouses",
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
                            0: function() {
                                window.location.reload("true");
                            },
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
    });
};

$(document).ready(function(){
    newCompany();
    editCompany();
    editManager();
    editGroup();
    increaseRepaire();
    toLeft();
    toRight();
//    selectTab();
    increaseSalesman();
    toLeftSalesman();
    toRightSalesman();
    newWarehouse();
    $("#J-company_tabs").tabs({
        ajaxOptions: {
            error: function( xhr, status, index, anchor ) {
                $( anchor.hash ).html(
                    "Couldn't load this tab. We'll try to fix this as soon as possible. " +
                    "If this wouldn't be a demo." );
            }
        }
	});
});