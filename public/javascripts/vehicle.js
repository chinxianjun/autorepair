//新增弹框
var newVehicle = function(){
    $('#J-addVehicle').click(function(){
        // user_info column
        var owner_name = $('#J-owner_name').val();
//        var owner_number = $('#J-owner_number').val();
        var owner_phone = $('#J-owner_phone').val();
//        var address = $("#J-address").val();
        var workplace = $('#J-workplace').val();
        // warranty info
        var warranty_card = $('#J-warranty_card').val();
        var purchase_on = $('#J-purchase_on').val();
        var driving_range = $('#J-driving_range').val();

        // engine column
        var engine = $('#J-engine').val();
        var engine_number = $('#J-engine_number').val();
        var order_number = $('#J-order_number').val();
        // gearbox column
        var gearbox_drawing = $("#J-gearbox_drawing").val();
        var gearbox_type = $("#J-gearbox_type").val();
        var user_number = $('#J-user_number').val();
        // car column
        var model = $('#J-model').val();
        var chassis_number = $('#J-chassis_number').val();
        var car_number = $("#J-car_number").val();
        // transmission column
        var first_drive_shaft_drawing = $("#J-first_drive_shaft_drawing").val();
        var first_drive_shaft_code = $("#J-first_drive_shaft_code").val();
        var second_drive_shaft_drawing = $("#J-second_drive_shaft_drawing").val();
        var second_drive_shaft_code = $("#J-second_drive_shaft_code").val();
        var third_drive_shaft_drawing = $("#J-third_drive_shaft_drawing").val();
        var third_drive_shaft_code = $("#J-third_drive_shaft_code").val();
        // tank & spring column
        var tank_drawing = $("#J-tank_drawing").val();
        var tank_code = $("#J-tank_code").val();
        var spring_drawing = $("#J-spring_drawing").val();
        var spring_code = $("#J-spring_code").val();
        // bridge column
        var first_bridge = $('#J-first_bridge').val();
        var second_bridge = $('#J-second_bridge').val();
        var third_bridge = $('#J-third_bridge').val();


        if(owner_name.length === 0){
            alert("请填写车主姓名");
            return false;
        }else if(owner_phone.length === 0){
            alert("请填写车主联系电话");
            return false;
        }else if(workplace.length === 0){
            alert("请填写车辆作业地点");
            return false;
        }else if(driving_range.length === 0){
            alert("请填写车辆行驶里程");
            return false;
        }else if(purchase_on.length === 0){
            alert("请填写车辆购车日期");
            return false;
        }else if(engine_number.length === 0){
            alert("请填写发动机编号");
            return false;
        }else if(engine.length === 0){
            alert("请填写发动机型号");
            return false;
        }else if(chassis_number.length === 0){
            alert("请填写底盘号");
            return false;
        }else if(model.length === 0){
            alert("请填写车型");
            return false;
        }else{
            $.ajax({
                url: '/vehicles',
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                dataType:   'json',
                cache: false,
                data: {
                    'owner': {
                        'fullname': owner_name,
                        'phone': owner_phone,
                        'workplace': workplace
                    },
                    'vehicle': {
                        'engine': engine,
                        'engine_number': engine_number,
                        'order_number': order_number,
                        'gearbox_type': gearbox_type,
                        'gearbox_drawing': gearbox_drawing,
                        'user_number': user_number,
                        'model': model,
                        'chassis_number': chassis_number,
                        'car_number': car_number,
                        'first_drive_shaft_drawing': first_drive_shaft_drawing,
                        'first_drive_shaft_code': first_drive_shaft_code,
                        'second_drive_shaft_drawing': second_drive_shaft_drawing,
                        'second_drive_shaft_code': second_drive_shaft_code,
                        'third_drive_shaft_drawing': third_drive_shaft_drawing,
                        'third_drive_shaft_code': third_drive_shaft_code,
                        'warranty_card': warranty_card,
                        'purchase_on': purchase_on,
                        'workplace': workplace,
                        'driving_range': driving_range,
                        'tank_drawing': tank_drawing,
                        'tank_code': tank_code,
                        'spring_drawing': spring_drawing,
                        'spring_code': spring_code,
                        'first_bridge': first_bridge,
                        'second_bridge': second_bridge,
                        'third_bridge': third_bridge,
                        'fullname': owner_name,
                        'phone': owner_phone
                    }
                },
                statusCode: {
                    0: function(){
                        window.location.href="/vehicles";
                    },
                    201: function(){
                        window.location.href="/vehicles";
                    },
                    403: function(){
                        window.location.href = "/home/forbidden";
                    },
                    422: function(){
                       alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
	});
};
//编辑车辆信息
var editVehicle = function() {
    //保存当前href
    var href = window.location.pathname;
    //alert(href);
    $(".editVehicle").click(function() {
      window.location.href= href + "/edit"
    })
};
//edit vehicle
var editVehicleSubmit = function(){
    $("#J-editVehicleSubmit").click(function(){
        var vid = $("#J-vehicle_id").val();
        var wid = $("#J-workflow_id").val();
        // user_info column
        var owner_name = $('#J-owner_name').val();
//        var owner_number = $('#J-owner_number').val();
        var owner_phone = $('#J-owner_phone').val();
//        var address = $("#J-address").val();
        var workplace = $('#J-workplace').val();
        // warranty info
        var warranty_card = $('#J-warranty_card').val();
        var purchase_on = $('#J-purchase_on').val();
        var driving_range = $('#J-driving_range').val();

        // engine column
        var engine = $('#J-engine').val();
        var engine_number = $('#J-engine_number').val();
        var order_number = $('#J-order_number').val();
        // gearbox column
        var gearbox_drawing = $("#J-gearbox_drawing").val();
        var gearbox_type = $("#J-gearbox_type").val();
        var user_number = $('#J-user_number').val();
        // car column
        var model = $('#J-model').val();
        var chassis_number = $('#J-chassis_number').val();
        var car_number = $("#J-car_number").val();
        // transmission column
        var first_drive_shaft_drawing = $("#J-first_drive_shaft_drawing").val();
        var first_drive_shaft_code = $("#J-first_drive_shaft_code").val();
        var second_drive_shaft_drawing = $("#J-second_drive_shaft_drawing").val();
        var second_drive_shaft_code = $("#J-second_drive_shaft_code").val();
        var third_drive_shaft_drawing = $("#J-third_drive_shaft_drawing").val();
        var third_drive_shaft_code = $("#J-third_drive_shaft_code").val();
        // tank & spring column
        var tank_drawing = $("#J-tank_drawing").val();
        var tank_code = $("#J-tank_code").val();
        var spring_drawing = $("#J-spring_drawing").val();
        var spring_code = $("#J-spring_code").val();
        // bridge column
        var first_bridge = $('#J-first_bridge').val();
        var second_bridge = $('#J-second_bridge').val();
        var third_bridge = $('#J-third_bridge').val();


        if(owner_name.length === 0){
            alert("请填写车主姓名");
            return false;
        }else if(owner_phone.length === 0){
            alert("请填写车主联系电话");
            return false;
        }else if(workplace.length === 0){
            alert("请填写车辆作业地点");
            return false;
        }else if(driving_range.length === 0){
            alert("请填写车辆行驶里程");
            return false;
        }else if(purchase_on.length === 0){
            alert("请填写车辆购车日期");
            return false;
        }else if(engine_number.length === 0){
            alert("请填写发动机编号");
            return false;
        }else if(engine.length === 0){
            alert("请填写发动机型号");
            return false;
        }else if(chassis_number.length === 0){
            alert("请填写底盘号");
            return false;
        }else if(model.length === 0){
            alert("请填写车型");
            return false;
        }else{
            $.ajax({
                url: '/vehicles/' + vid + '?wid=' + wid,
                type: 'PUT',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                dataType: 'json',
                cache: false,
                data: {
                    'owner': {
                        'fullname': owner_name,
                        'phone': owner_phone,
                        'workplace': workplace
                    },
                    'vehicle': {
                        'engine': engine,
                        'engine_number': engine_number,
                        'order_number': order_number,
                        'gearbox_type': gearbox_type,
                        'gearbox_drawing': gearbox_drawing,
                        'user_number': user_number,
                        'model': model,
                        'chassis_number': chassis_number,
                        'car_number': car_number,
                        'first_drive_shaft_drawing': first_drive_shaft_drawing,
                        'first_drive_shaft_code': first_drive_shaft_code,
                        'second_drive_shaft_drawing': second_drive_shaft_drawing,
                        'second_drive_shaft_code': second_drive_shaft_code,
                        'third_drive_shaft_drawing': third_drive_shaft_drawing,
                        'third_drive_shaft_code': third_drive_shaft_code,
                        'warranty_card': warranty_card,
                        'purchase_on': purchase_on,
                        'workplace': workplace,
                        'driving_range': driving_range,
                        'tank_drawing': tank_drawing,
                        'tank_code': tank_code,
                        'spring_drawing': spring_drawing,
                        'spring_code': spring_code,
                        'first_bridge': first_bridge,
                        'second_bridge': second_bridge,
                        'third_bridge': third_bridge,
                        'fullname': owner_name,
                        'phone': owner_phone
                    }
                },
                statusCode: {
                    200: function(){
                        if (wid > 0)
                            window.location.href="/vehicles/vehicle_flow";
                        else
                            window.location.href="/vehicles";
                    },
                    403: function(){
                        window.location.href = "/home/forbidden";
                    },
                    422: function(){
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    });
};

//新建车主信息
var newOwner = function(){
    $('.newOwner').click(function(){
        $( "#J-Owner_new" ).dialog( "open" );
	});
    $('#J-Owner_new').dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                var fullname = $('#J-fullname').val();
                var workplace = $('#J-workplace').val();
                var phone = $('#J-phone').val();
                var id = $('#J-vehicle_id').val();
//                alert(id);
                if(fullname.length === 0){
                    alert("请填写客户姓名");
//                    showErrorTip(username, '请填写客户姓名',username);
                }else if(fullname.length>18){
                    alert("用户名太长了");
//                    showErrorTip(username, '客户姓名至少2个字符',username);
                }else{
                    $.ajax({
                        type: 'POST',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        url:  "/vehicles/" + id + "/owner_create",
                        dateType: "json",
                        cache: false,
                        data: {
                            'owner': {
                                'fullname': fullname,
                                'workplace': workplace,
                                'phone': phone
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.reload($(this).href);
                            },
                            403: function() {
                                window.location.href = "/home/forbidden";
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
//编辑车主信息
var editOwner = function() {
    //保存当前href
//    var href = window.location.pathname;
    var id = $("#J-vehicle_id").val();
    $(".editOwner").click(function() {
        $("#J-Owner_edit").dialog("open");
        $.ajax({
            url: "/vehicles/" + id + "/owner_edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "fullname":
                            $("#U-fullname").attr('value', val);
                            break;
                        case "phone":
                            $("#U-phone").attr('value', val);
                            break;
                        case "workplace":
                            $("#U-workplace").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Owner_edit").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: "/vehicles/" + id + "/owner_update",
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'owner': {
                            'fullname': $("#U-fullname").val(),
                            'workplace': $("#U-workplace").val(),
                            'phone': $("#U-phone").val()
                        }
                    },
                    statusCode: {
                        200: function() {
                            window.location.reload(true);
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
// add vehicle from workflow
var addOwnerVehicle = function(){
    $('#J-add_vehicle_submit').click(function(){
        var wid = $('#J-wid').val();
        // user_info column
        var owner_name = $('#J-owner_name').val();
//        var owner_number = $('#J-owner_number').val();
        var owner_phone = $('#J-owner_phone').val();
//        var address = $("#J-address").val();
        var workplace = $('#J-workplace').val();
        // warranty info
        var warranty_card = $('#J-warranty_card').val();
        var purchase_on = $('#J-purchase_on').val();
        var driving_range = $('#J-driving_range').val();

        // engine column
        var engine = $('#J-engine').val();
        var engine_number = $('#J-engine_number').val();
        var order_number = $('#J-order_number').val();
        // gearbox column
        var gearbox_drawing = $("#J-gearbox_drawing").val();
        var gearbox_type = $("#J-gearbox_type").val();
        var user_number = $('#J-user_number').val();
        // car column
        var model = $('#J-model').val();
        var chassis_number = $('#J-chassis_number').val();
        var car_number = $("#J-car_number").val();
        // transmission column
        var first_drive_shaft_drawing = $("#J-first_drive_shaft_drawing").val();
        var first_drive_shaft_code = $("#J-first_drive_shaft_code").val();
        var second_drive_shaft_drawing = $("#J-second_drive_shaft_drawing").val();
        var second_drive_shaft_code = $("#J-second_drive_shaft_code").val();
        var third_drive_shaft_drawing = $("#J-third_drive_shaft_drawing").val();
        var third_drive_shaft_code = $("#J-third_drive_shaft_code").val();
        // tank & spring column
        var tank_drawing = $("#J-tank_drawing").val();
        var tank_code = $("#J-tank_code").val();
        var spring_drawing = $("#J-spring_drawing").val();
        var spring_code = $("#J-spring_code").val();
        // bridge column
        var first_bridge = $('#J-first_bridge').val();
        var second_bridge = $('#J-second_bridge').val();
        var third_bridge = $('#J-third_bridge').val();
        //send information to server
        if(owner_name.length === 0){
            alert("请填写车主姓名");
            return false;
        }else if(owner_phone.length === 0){
            alert("请填写车主联系电话");
            return false;
        }else if(workplace.length === 0){
            alert("请填写车辆作业地点");
            return false;
        }else if(driving_range.length === 0){
            alert("请填写车辆行驶里程");
            return false;
        }else if(purchase_on.length === 0){
            alert("请填写车辆购车日期");
            return false;
        }else if(engine_number.length === 0){
            alert("请填写发动机编号");
            return false;
        }else if(engine.length === 0){
            alert("请填写发动机型号");
            return false;
        }else if(chassis_number.length === 0){
            alert("请填写底盘号");
            return false;
        }else if(model.length === 0){
            alert("请填写车型");
            return false;
        }else{
            $.ajax({
                url: '/vehicles?wid=' + wid,
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                dataType:   'json',
                cache: false,
                data: {
                    'owner': {
                        'fullname': owner_name,
                        'phone': owner_phone,
                        'workplace': workplace
                    },
                    'vehicle': {
                        'engine': engine,
                        'engine_number': engine_number,
                        'order_number': order_number,
                        'gearbox_type': gearbox_type,
                        'gearbox_drawing': gearbox_drawing,
                        'user_number': user_number,
                        'model': model,
                        'chassis_number': chassis_number,
                        'car_number': car_number,
                        'first_drive_shaft_drawing': first_drive_shaft_drawing,
                        'first_drive_shaft_code': first_drive_shaft_code,
                        'second_drive_shaft_drawing': second_drive_shaft_drawing,
                        'second_drive_shaft_code': second_drive_shaft_code,
                        'third_drive_shaft_drawing': third_drive_shaft_drawing,
                        'third_drive_shaft_code': third_drive_shaft_code,
                        'warranty_card': warranty_card,
                        'purchase_on': purchase_on,
                        'workplace': workplace,
                        'driving_range': driving_range,
                        'tank_drawing': tank_drawing,
                        'tank_code': tank_code,
                        'spring_drawing': spring_drawing,
                        'spring_code': spring_code,
                        'first_bridge': first_bridge,
                        'second_bridge': second_bridge,
                        'third_bridge': third_bridge,
                        'fullname': owner_name,
                        'phone': owner_phone
                    }
                },
                statusCode: {
                    0: function(){
                        window.location.href="/workflows/workflow_flow";
                    },
                    201: function(){
                        window.location.href="/workflows/workflow_flow";
                    },
                    403: function(){
                        window.location.href = "/home/forbidden";
                    },
                    422: function(){
                       alert("ERROR:422,车辆信息已存在，无法提交.");
                    }
                }
            });
        }
    });
};
//
var searchVehicle = function() {
  $("#vehicles th a, #vehicles .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#vehicles_search input").keyup(function() {
    $.get($("#vehicles_search").attr("action"), $("#vehicles_search").serialize(), null, "script");
    return false;
  });
};


$(document).ready(function(){
    newVehicle();
    editVehicle();
    newOwner();
    editOwner();
    addOwnerVehicle();
    searchVehicle();
    editVehicleSubmit();
});