//添加费用
var newExpenseCreate = function() {
    $('.newExpense').click(function() {
        $("#J-Expense_create").dialog("open");
    });
    $("#J-Expense_create").dialog({
        autoOpen: false,
        width: 550,
        modal: true,
        buttons: {
            "保存": function() {
                var material_cost = $('#J-material_cost').val();
                var working_hours_cost = $('#J-working_hours_cost').val();
                var communication_cost = $('#J-communication_cost').val();
                var service_car_cost = $('#J-service_car_cost').val();
                var meal_cost = $('#J-meal_cost').val();
                var travel_expense = $('#J-travel_expense').val();
                var total = Number(material_cost) +
                            Number(working_hours_cost) +
                            Number(communication_cost) +
                            Number(service_car_cost) +
                            Number(meal_cost) +
                            Number(travel_expense)
                if (working_hours_cost.length === 0) {
                    alert("工时费不能为空");
                } else {
                    $.ajax({
                        url: "/expenses",
                        type: "POST",
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        dateType: "json",
                        cache: false,
                        data: {
                            'expense': {
                                'material_cost': material_cost,
                                'working_hours_cost': working_hours_cost,
                                'communication_cost': communication_cost,
                                'service_car_cost': service_car_cost,
                                'meal_cost': meal_cost,
                                'travel_expense': travel_expense,
                                'total': total
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.href = "/expenses";
                            },
                            403: function() {
                                window.location.href = "/home/forbidden";
                            },
                            422: function() {
                                alert("内部错误：提交的数据有错误");
                            }
                        }
                    });
                }
                $(this).dialog("close");
            },
            "取消": function() {
                $(this).dialog("close");
            }
        }
    });
};
//编辑费用
var editExpense = function(){
    //保存当前href
    var href = window.location.pathname;
    $(".editExpense").click(function() {
        $("#J-Expense_edit").dialog("open");
        $.ajax({
            url: window.location.pathname + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "material_cost":
                            $("#J-material_cost").attr('value', val);
                            break;
                        case "working_hours_cost":
                            $("#J-working_hours_cost").attr('value', val);
                            break;
                        case "communication_cost":
                            $("#J-communication_cost").attr('value', val);
                            break;
                        case "service_car_cost":
                            $("#J-service_car_cost").attr('value', val);
                            break;
                        case "meal_cost":
                            $("#J-meal_cost").attr('value', val);
                            break;
                        case "travel_expense":
                            $('#J-travel_expense').attr('value', val);
                            break;
                        case "total":
                            $('#J-total').attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Expense_edit").dialog({
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
                        'expense': {
                            'material_cost': $("#J-material_cost").val(),
                            'working_hours_cost': $("#J-working_hours_cost").val(),
                            'communication_cost': $("#J-communication_cost").val(),
                            'service_car_cost': $("#J-service_car_cost").val(),
                            'meal_cost': $("#J-meal_cost").val(),
                            'travel_expense': $("#J-travel_expense").val(),
                            'total': Number($("#J-material_cost").val()) +
                                     Number($("#J-working_hours_cost").val()) +
                                     Number($("#J-communication_cost").val()) +
                                     Number($("#J-service_car_cost").val()) +
                                     Number($("#J-meal_cost").val()) +
                                     Number($("#J-travel_expense").val()) +
                                     Number($("#J-travel_expense").val())
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
                            alert("内部错误：提交的数据有错误");
//                            showErrorTip(phone, '这个电话已经被占用了',phone);
                        }
                    }
                });
                $(this).dialog("close");
            },
			"取消": function() {
				$(this).dialog("close");
			}
        }
    });
};
//编辑费用----link
var editExpenseLink = function(){
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function(e){
       e.stopPropagation();
    });
    $(".editExpenseLink").click(function() {
        $("#J-Expense_update").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url: href + "/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "material_cost":
                            $("#U-material_cost").attr('value', val);
                            break;
                        case "working_hours_cost":
                            $("#U-working_hours_cost").attr('value', val);
                            break;
                        case "communication_cost":
                            $("#U-communication_cost").attr('value', val);
                            break;
                        case "service_car_cost":
                            $("#U-service_car_cost").attr('value', val);
                            break;
                        case "meal_cost":
                            $("#U-meal_cost").attr('value', val);
                            break;
                        case "travel_expense":
                            $("#U-travel_expense").attr('value', val);
                            break;
                        case "total":
                            $("#U-total").attr('value', val);
                            break;
                        case "id":
                            $('#U-Expense_id').attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Expense_update").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: href + "/" + $("#U-Expense_id").val(),
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'expense': {
                            'material_cost': $("#U-material_cost").val(),
                            'working_hours_cost': $("#U-working_hours_cost").val(),
                            'communication_cost': $("#U-communication_cost").val(),
                            'service_car_cost': $("#U-service_car_cost").val(),
                            'meal_cost': $("#U-meal_cost").val(),
                            'travel_expense': $("#U-travel_expense").val(),
                            'total': Number($("#U-material_cost").val()) +
                                     Number($("#U-working_hours_cost").val()) +
                                     Number($("#U-communication_cost").val()) +
                                     Number($("#U-service_car_cost").val()) +
                                     Number($("#U-service_car_cost").val()) +
                                     Number($("#U-meal_cost").val()) +
                                     Number($("#U-travel_expense").val())
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
                            alert("内部错误：提交的数据有错误");
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
//通过流程添加费用
var expenseFromFlow = function(){
    $('#J-expense_submit').click(function(){
        var wid = $('#J-wid').val();
        var service_regist_number = $('#J-service_regist_number').val();
        var service_process_number = $('#J-service_process_number').val();
        var material_cost = $('#J-material_cost').val();
        var working_hours_cost = $('#J-working_hours_cost').val();
        var communication_cost = $('#J-communication_cost').val();
        var service_car_cost = $('#J-service_car_cost').val();
        var meal_cost = $('#J-meal_cost').val();
        var travel_expense = $('#J-travel_expense').val();

        $.ajax({
            type: "POST",
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            url: "/expenses?wid=" + wid,
            dataType: "json",
            data: {
                'report': {
                    'service_regist_number': service_regist_number,
                    'service_process_number': service_process_number
                },
                'expense': {
                    'material_cost': material_cost,
                    'working_hours_cost': working_hours_cost,
                    'communication_cost': communication_cost,
                    'service_car_cost': service_car_cost,
                    'meal_cost': meal_cost,
                    'travel_expense': travel_expense,
                    'total': Number($("#J-material_cost").val()) +
                                     Number($("#J-working_hours_cost").val()) +
                                     Number($("#J-communication_cost").val()) +
                                     Number($("#J-service_car_cost").val()) +
                                     Number($("#J-service_car_cost").val()) +
                                     Number($("#J-meal_cost").val()) +
                                     Number($("#J-travel_expense").val())
                }
            },
            statusCode: {
                0 : function(){
                  window.location.href = "/workflows/workflow_flow"
                },
                201: function(){
                    alert("code: 201")
                    window.location.href = "/workflows/workflow_flow"
                },
                403: function(){
                    window.location.href = "/home/forbidden"
                },
                422: function(){
                    alert("Error: 422, 内部数据错误，无法提交")
                }
            }
        })
    })
};

$(document).ready(function() {
    newExpenseCreate();
    editExpense();
    editExpenseLink();
    expenseFromFlow();
});