////添加直接破损旧件
//var directpartSave = function(){
//    $("#J-direct_save").click(function(){
//        var name = $('#J-name').val();
//        var category = $("#J-category>input:radio[checked]").val();
//        var handiner = $("#J-repairmen>input:radio[checked]").val();
//        var drawing = $('#J-drawing').val();
//        var factory = $('#J-factory').val();
//        var factory_code = $('#J-factory_code').val();
//        var count = $("#J-count").val();
//        var pattern = $("#J-pattern").val();
//        var depot = $('#J-depot').val();
//        var status = $("#J-status").val();
//        var running_number = $('#J-running_number').val();
//        var fault_desc = $('#J-fault_desc').val();
//        var wid = $('#J-workflow_id').val();
//        var fault_id = $('#J-fault_id').val();
//        if(name.length === 0){
//            alert("请填写旧件名称");
//        }else if(name.length<2){
//            alert("旧件名称过短");
//        }else if(drawing.length === 0){
//            alert("请填写旧件图号");
//            return false;
//        }else if(factory_code.length === 0){
//            alert("请填写厂家代码");
//            return false;
//        }else if(factory.length === 0){
//            alert("请填写厂家名称");
//            return false;
//        }else if($('input:radio:checked').length === 0){
//            alert("请选择旧件类别");
//            return false;
//        }else{
//            $.ajax({
//                type: 'POST',
//                headers: {
//                    'X-Transaction': 'POST Example',
//                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                },
//                url:  "/oldparts?wid=" + wid + "&fault_id=" + fault_id,
//                dateType: "json",
//                cache: false,
//                data: {
//                    'oldpart': {
//                        'fault_desc': fault_desc,
//                        'name': name,
//                        'drawing': drawing,
//                        'factory': factory,
//                        'factory_code': factory_code,
//                        'count': count,
//                        'pattern': pattern,
//                        'depot': depot,
//                        'status': status,
//                        'running_number': running_number,
//                        'category': category,
//                        'handiner': handiner
//                    }
//                },
//                statusCode: {
//                    201: function() {
//                        window.location.href="/workflows/workflow_flow";
//                    },
//                    403: function() {
//                        window.location.href = "/home/forbidden";
//                    },
//                    422: function() {
//                        alert("ERROR:422,内部数据错误，无法提交.");
//                    }
//                }
//            });
//
//        }
//    });
//};
////保存直接破损旧件并添加间接破损旧件
//var directpartContinue = function(){
//    $("#J-direct_continue").click(function(){
//        var name = $('#J-name').val();
//        var category = $("#J-category>input:radio[checked]").val();
//        var handiner = $("#J-repairmen>input:radio[checked]").val();
//        var drawing = $('#J-drawing').val();
//        var factory = $('#J-factory').val();
//        var factory_code = $('#J-factory_code').val();
//        var count = $("#J-count").val();
//        var pattern = $("#J-pattern").val();
//        var depot = $('#J-depot').val();
//        var status = $("#J-status").val();
//        var running_number = $('#J-running_number').val();
//        var fault_desc = $('#J-fault_desc').val();
//        var wid = $('#J-workflow_id').val();
//        var fault_id = $('#J-fault_id').val();
//        if(name.length === 0){
//            alert("请填写旧件名称");
//        }else if(name.length<2){
//            alert("旧件名称过短");
//        }else{
//            $.ajax({
//                type: 'POST',
//                headers: {
//                    'X-Transaction': 'POST Example',
//                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                },
//                url:  "/oldparts?wid=" + wid + "&fault_id=" + fault_id,
//                dateType: "json",
//                cache: false,
//                data: {
//                    'oldpart': {
//                        'fault_desc': fault_desc,
//                        'name': name,
//                        'drawing': drawing,
//                        'factory': factory,
//                        'factory_code': factory_code,
//                        'count': count,
//                        'pattern': pattern,
//                        'depot': depot,
//                        'status': status,
//                        'running_number': running_number,
//                        'category': category,
//                        'handiner': handiner
//                    }
//                },
//                statusCode: {
//                    201: function(data) {
//
//                        $('#J-directpart_id').attr('value', data.id);
//
//                        $('#J-oldpart_new').css({'top':0, 'left':'550px'});
//                        $('#J-oldpart_new').animate(
//                            {'left':'-620px'}, 500, function(){
//                                $('#J-ind_new').animate({'left':400}, 500);  //切换到ind
//                            }
//                        );
//                    },
//                    403: function() {
//                        window.location.href = "/home/forbidden";
//                    },
//                    422: function() {
//                        alert("ERROR:422,内部数据错误，无法提交.");
//                    }
//                }
//            });
//        }
//    })
//};
////添加间接破损旧件
//var indirectpartSave = function(){
//    $("#J-ind_save").click(function(){
//        var ind_name = $('#J-ind_name').val();
//        var ind_category = $("#J-ind_category>input:radio[checked]").val();
//        var ind_handiner = $("#J-ind_repairmen>input:radio[checked]").val();
//        var ind_drawing = $('#J-ind_drawing').val();
//        var ind_factory = $('#J-ind_factory').val();
//        var ind_factory_code = $('#J-ind_factory_code').val();
//        var ind_count = $("#J-ind_count").val();
//        var ind_pattern = $("#J-ind_pattern").val();
//        var ind_depot = $('#J-ind_depot').val();
//        var ind_status = $("#J-ind_status").val();
//        var ind_running_number = $('#J-ind_running_number').val();
//        var ind_fault_desc = $('#J-ind_fault_desc').val();
//        var direct_id = $('#J-directpart_id').val();
//        var wid = $('#J-workflow_id').val();
//        var fault_id = $('#J-fault_id').val();
//        if(direct_id === null){
//            alert('未获取到直接旧件ID');
//            return false;
//        }else if(ind_name.length === 0){
//            alert("请填写旧件名称");
//        }else if(ind_name.length<2){
//            alert("旧件名称过短");
//        }else{
//            $.ajax({
//                type: 'POST',
//                headers: {
//                    'X-Transaction': 'POST Example',
//                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                },
//                url:  "/oldparts?wid=" + wid + "&fault_id=" + fault_id + "&direct_id=" + direct_id,
//                dateType: "json",
//                cache: false,
//                data: {
//                    'indirectpart': {
//                        'ind_fault_desc': ind_fault_desc,
//                        'ind_name': ind_name,
//                        'ind_drawing': ind_drawing,
//                        'ind_factory': ind_factory,
//                        'ind_factory_code': ind_factory_code,
//                        'ind_count': ind_count,
//                        'ind_pattern': ind_pattern,
//                        'ind_depot': ind_depot,
//                        'ind_status': ind_status,
//                        'ind_running_number': ind_running_number,
//                        'ind_category': ind_category,
//                        'handiner': ind_handiner,
//                        'direct_id': direct_id
//                    }
//                },
//                statusCode: {
//                    201: function() {
//                        window.location.href="/workflows/workflow_flow";
//                    },
//                    403: function() {
//                        window.location.href = "/home/forbidden";
//                    },
//                    422: function() {
//                        alert("ERROR:422,内部数据错误，无法提交.");
//                    }
//                }
//            });
//
//        }
//    });
//};
////继续添加间接破损旧件
//var indirectpartContinue = function(){
//    $("#J-ind_continue").click(function(){
//        var ind_name = $('#J-ind_name').val();
//        var ind_category = $("#J-ind_category>input:radio[checked]").val();
//        var ind_handiner = $("#J-ind_repairmen>input:radio[checked]").val();
//        var ind_drawing = $('#J-ind_drawing').val();
//        var ind_factory = $('#J-ind_factory').val();
//        var ind_factory_code = $('#J-ind_factory_code').val();
//        var ind_count = $("#J-ind_count").val();
//        var ind_pattern = $("#J-ind_pattern").val();
//        var ind_depot = $('#J-ind_depot').val();
//        var ind_status = $("#J-ind_status").val();
//        var ind_running_number = $('#J-ind_running_number').val();
//        var ind_fault_desc = $('#J-ind_fault_desc').val();
//        var direct_id = $('#J-directpart_id').val();
//        var wid = $('#J-workflow_id').val();
//        var fault_id = $('#J-fault_id').val();
//        if(direct_id === null){
//            alert('未获取到直接旧件ID');
//            return false;
//        }else if(ind_name.length === 0){
//            alert("请填写旧件名称");
//        }else if(ind_name.length<2){
//            alert("旧件名称过短");
//        }else{
//            $.ajax({
//                type: 'POST',
//                headers: {
//                    'X-Transaction': 'POST Example',
//                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                },
//                url:  "/oldparts?wid=" + wid + "&fault_id=" + fault_id + "&direct_id=" + direct_id,
//                dateType: "json",
//                cache: false,
//                data: {
//                    'indirectpart': {
//                        'ind_fault_desc': ind_fault_desc,
//                        'ind_name': ind_name,
//                        'ind_drawing': ind_drawing,
//                        'ind_factory': ind_factory,
//                        'ind_factory_code': ind_factory_code,
//                        'ind_count': ind_count,
//                        'ind_pattern': ind_pattern,
//                        'ind_depot': ind_depot,
//                        'ind_status': ind_status,
//                        'ind_running_number': ind_running_number,
//                        'ind_category': ind_category,
//                        'handiner': ind_handiner
//                    },
//                    'direct_id': {
//                        'direct_id': direct_id
//                    }
//                },
//                statusCode: {
//                    201: function() {
//                        // require clear form
//                        $('#J-ind_new').css({'top':0, 'left':'550px'});
//                        $('#J-ind_new').animate(
//                            {'left':'-620px'}, 500, function(){
//                                $('#J-ind_new').css({'top':150, 'left':'550px'});
//                                $('#J-ind_new').animate({'left':400}, 500);
//                            }
//                        );
//                    },
//                    403: function() {
//                        window.location.href = "/home/forbidden";
//                    },
//                    422: function() {
//                        alert("ERROR:422,内部数据错误，无法提交.");
//                    }
//                }
//            });
//        }
//    })
//};
//编辑旧件信息
var editOldpart = function() {
    //保存当前href
    var href = window.location.pathname;
    $(".editOldpart").click(function() {
        $("#J-Oldpart_edit").dialog("open");
        $.ajax({
            url: window.location.pathname + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "fault_desc":
                            $("#J-fault_desc").attr('value', val);
                            break;
                        case "name":
                            $("#J-name").attr('value', val);
                            break;
                        case "drawing":
                            $("#J-drawing").attr('value', val);
                            break;
                        case "price":
                            $("#J-price").attr('value', val);
                            break;
                        case "factory_code":
                            $("#J-factory_code").attr('value', val);
                            break;
                        case "factory":
                            $("#J-factory").attr('value', val);
                            break;
                        case "count":
                            $("#J-count").attr('value', val);
                            break;
                        case "pattern":
                            $("#J-pattern").attr('value', val);
                            break;
                        case "depot":
                            $("#J-depot").attr('value', val);
                            break;
                        case "status":
                            $("#J-status").attr('value', val);
                            break;
                        case "running_number":
                            $("#J-running_number").attr('value', val);
                            break;
                        case "category":
                            $("#J-category").attr('value', val);
                            break;
                        case "note":
                            $("#J-note").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Oldpart_edit").dialog({
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
                        'oldpart': {
                            'fault_desc': $('#J-fault_desc').val(),
                            'name': $('#J-name').val(),
                            'drawing': $('#J-drawing').val(),
                            'price': $('#J-price').val(),
                            'factory': $('#J-factory').val(),
                            'factory_code': $('#J-factory_code').val(),
                            'count': $('#J-count').val(),
                            'pattern': $('#J-pattern').val(),
                            'depot': $('#J-depot').val(),
                            'status': $('#J-status').val(),
                            'note': $("#J-note").val(),
                            'running_number': $('#J-running_number').val(),
                            'category': $('#J-category').val()
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
//编辑旧件信息 index page
var editOldpartLink = function() {
    $("#J-oldpart_edit_save").click(function(){

        var oldpart_category = $('input[name=J-category]:radio:checked').val();
        var oldpart_name = $('#J-name').val();
        var oldpart_drawing = $('#J-drawing').val();
        var oldpart_price = $("#J-price").val();
        var oldpart_factory = $('#J-factory').val();
        var oldpart_factory_code = $('#J-factory_code').val();
        var oldpart_count = $('#J-count').val();
        var oldpart_desc = $('#J-fault_desc').val();
        var oldpart_status = $('#J-status').val();
        var oldpart_pattern = $('#J-pattern').val();
        var oldpart_running_number = $('#J-running_number').val();
        var oldpart_note = $("#J-note").val();

        if (oldpart_category == null){
            alert("请选择旧件品牌");
            return false;
        } else if(oldpart_name.length === 0){
            alert("请输入旧件名称");
            return false;
        } else if(oldpart_price.length === 0){
            alert("请输入旧件价格");
            return false;
        } else if (oldpart_drawing.length === 0) {
            alert("请输入旧件图号");
            return false;
        } else if (oldpart_desc.length === 0) {
            alert("请输入旧件故障简述");
            return false;
        } else {
            $.ajax({
                url: "/oldparts/" + $("#J-oldpart_id").val(),
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                dataType: "json",
                type: "PUT",
                data: {
                    'oldpart': {
                        'fault_desc': oldpart_desc,
                        'name': oldpart_name,
                        'drawing': oldpart_drawing,
                        'price': oldpart_price,
                        'factory': oldpart_factory,
                        'factory_code': oldpart_factory_code,
                        'count': oldpart_count,
                        'status': oldpart_status,
                        'pattern': oldpart_pattern,
                        'running_number': oldpart_running_number,
                        'note': note,
                        'category': oldpart_category
                    }
                },
                statusCode: {
                    200: function() {
                        window.location.href="/oldparts";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    })
};
////编辑间接损坏故障信息
//var editIndirectpart = function() {
//    //保存当前ind_id
//    var ind_id = $('#J-ind_id').val();
//    $(".editIndirectpart").click(function() {
//        $("#J-Indirectpart_edit").dialog("open");
//        $.ajax({
//            url: "/oldparts/ind_edit?id=" + ind_id,
//            type: "GET",
//            dateType: "json",
//            contentType: "application/json",
//            success: function(data) {
//                $.each(data, function(key, val) {
//                    switch (key) {
//                        case "ind_fault_desc":
//                            $("#J-ind_fault_desc").attr('value', val);
//                            break;
//                        case "ind_name":
//                            $("#J-ind_name").attr('value', val);
//                            break;
//                        case "ind_drawing":
//                            $("#J-ind_drawing").attr('value', val);
//                            break;
//                        case "ind_factory_ind_code":
//                            $("#J-ind_factory_code").attr('value', val);
//                            break;
//                        case "ind_factory":
//                            $("#J-ind_factory").attr('value', val);
//                            break;
//                        case "ind_count":
//                            $("#J-ind_count").attr('value', val);
//                            break;
//                        case "ind_pattern":
//                            $("#J-ind_pattern").attr('value', val);
//                            break;
//                        case "ind_depot":
//                            $("#J-ind_depot").attr('value', val);
//                            break;
//                        case "ind_status":
//                            $("#J-ind_status").attr('value', val);
//                            break;
//                        case "ind_running_number":
//                            $("#J-ind_running_number").attr('value', val);
//                            break;
//                        case "ind_category":
//                            $("#J-ind_category").attr('value', val);
//                            break;
//                        default:
//                            break;
//                    }
//                })
//            }
//        })
//    });
//    $("#J-Indirectpart_edit").dialog({
//		autoOpen: false,
//		width: 550,
//		modal: true,
//		buttons: {
//			"保存": function() {
//                $.ajax({
//                    url: "/oldparts/ind_update?id=" + ind_id,
//                    headers: {
//                        'X-Transaction': 'POST Example',
//                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                    },
//                    dataType: "json",
//                    type: "PUT",
//                    data: {
//                        'indirectpart': {
//                            'ind_fault_desc': $('#J-ind_fault_desc').val(),
//                            'ind_name': $('#J-ind_name').val(),
//                            'ind_drawing': $('#J-ind_drawing').val(),
//                            'ind_factory': $('#J-ind_factory').val(),
//                            'ind_factory_code': $('#J-ind_factory_code').val(),
//                            'ind_count': $('#J-ind_count').val(),
//                            'ind_pattern': $('#J-ind_pattern').val(),
//                            'ind_depot': $('#J-ind_depot').val(),
//                            'ind_status': $('#J-ind_status').val(),
//                            'ind_running_number': $('#J-ind_running_number').val(),
//                            'ind_category': $('#J-ind_category').val()
//                        }
//                    },
//                    statusCode: {
//                        200: function() {
//                            window.location.reload(true);
//                        },
//                        403: function() {
//                            window.location.href = "/home/forbidden";
//                        },
//                        422: function() {
//                            alert("ERROR:422,内部数据错误，无法提交.");
//                        }
//                    }
//                });
//                $(this).dialog("close");
//            },
//			"取消": function() {
//				$(this).dialog("close");
//			}
//        }
//    })
//};
////编辑间接损坏旧件信息 index page
//var editIndirectpartLink = function() {
//    $('td a').click(function(e){
//       e.stopPropagation();
//    });
//    $(".editIndirectpartLink").click(function() {
//        $("#J-Indirectpart_update").dialog("open");
//        var ind_id = $(this).attr('id');
//        $.ajax({
//            url: "/oldparts/ind_edit?id=" + ind_id,
//            type: "GET",
//            dateType: "json",
//            contentType: "application/json",
//            success: function(data) {
//                $.each(data, function(key, val) {
//                    switch (key) {
//                        case "ind_fault_desc":
//                            $("#U-ind_fault_desc").attr('value', val);
//                            break;
//                        case "ind_name":
//                            $("#U-ind_name").attr('value', val);
//                            break;
//                        case "ind_drawing":
//                            $("#U-ind_drawing").attr('value', val);
//                            break;
//                        case "ind_factory_code":
//                            $("#U-ind_factory_code").attr('value', val);
//                            break;
//                        case "ind_factory":
//                            $("#U-ind_factory").attr('value', val);
//                            break;
//                        case "ind_count":
//                            $("#U-ind_count").attr('value', val);
//                            break;
//                        case "ind_status":
//                            $("#U-ind_status").attr('value', val);
//                            break;
//                        case "ind_running_number":
//                            $("#U-ind_running_number").attr('value', val);
//                            break;
//                        case "ind_category":
//                            $("#U-ind_category").attr('value', val);
//                            break;
//                        case "id":
//                            $("#U-Indirectpart_id").attr('value', val);
//                            break;
//                        default:
//                            break;
//                    }
//                })
//            }
//        })
//    });
//    $("#J-Indirectpart_update").dialog({
//		autoOpen: false,
//		width: 550,
//		modal: true,
//		buttons: {
//			"保存": function() {
//                $.ajax({
//                    url: "/oldparts/ind_update?id=" + $("#U-Indirectpart_id").val(),
//                    headers: {
//                        'X-Transaction': 'POST Example',
//                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//                    },
//                    dataType: "json",
//                    type: "PUT",
//                    data: {
//                        'indirectpart': {
//                            'ind_fault_desc': $('#U-ind_fault_desc').val(),
//                            'ind_name': $('#ind_U-name').val(),
//                            'ind_drawing': $('#U-ind_drawing').val(),
//                            'ind_factory': $('#U-ind_factory').val(),
//                            'ind_factory_code': $('#U-ind_factory_code').val(),
//                            'ind_count': $('#U-ind_count').val(),
//                            'ind_status': $('#U-ind_status').val(),
//                            'ind_running_number': $('#U-ind_running_number').val(),
//                            'ind_category': $('#U-ind_category>input:radio[checked]').val()
//                        }
//                    },
//                    statusCode: {
//                        200: function() {
//                            window.location.reload(true);
//                        },
//                        403: function() {
//                            window.location.href = "/home/forbidden";
//                        },
//                        422: function() {
//                            alert("ERROR:422,内部数据错误，无法提交.");
//                        }
//                    }
//                });
//                $(this).dialog("close");
//            },
//			"取消": function() {
//				$(this).dialog("close");
//			}
//        }
//    })
//};

var newOldpartFromWarehouse = function(){
    $("#J-oldpart_new").click(function(){
        var name = $("#J-oldpart_name").val();
        var drawing = $("#J-oldpart_drawing").val();
        var price = $("#J-oldpart_price").val();
        var factory = $("#J-oldpart_factory_name").val();
        var factory_code = $("#J-oldpart_factory_code").val();
        var fault_desc = $("#J-oldpart_fault_desc").val();
        var count = $("#J-oldpart_count").val();
        var warehouse_id = $("#J-warehouse_id").val();
        var company_id = $("#J-company_id").val();
        var manager = $("#J-oldpart_manager").val();
        var handiner = $("#J-oldpart_handiner").val();
        var status = $("input:radio[name=J-oldpart_status]:checked").val();

        if (name.length === 0){
            alert("请填写旧件名称");
            return false;
        } else if (drawing.length === 0){
            alert("请填写旧件图号");
            return false;
        } else if (price.length === 0){
            alert("请填写旧件价格");
            return false;
        } else if (fault_desc.length === 0){
            alert("请填写旧件故障描述");
            return false;
        } else if (count.length === 0){
            alert("请填写旧件数量");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/warehouses/" + warehouse_id + "/oldparts/",
                dateType: "json",
                cache: false,
                data: {
                    'oldpart': {
                        'name': name,
                        'drawing': drawing,
                        'price': price,
                        'factory': factory,
                        'factory_code': factory_code,
                        'fault_desc': fault_desc,
                        'handiner': handiner,
                        'status': status,
                        'oldpart_manager': manager
                    },
                    'count': count
                },
                statusCode: {
                    201: function() {
                        window.location.reload("true");
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    })
};

var addOldpart = function(){
    $("#J-oldpart_save").click(function(){
        var category = $("#J-category input:radio[:name=category]:checked").val();
        var name = $("#J-part_name").val();
        var drawing = $("#J-drawing").val();
        var price = $("#J-price").val();
        var factory = $("#J-factory").val();
        var factory_code = $("#J-factory_code").val();
        var fault_desc = $("#J-fault_desc").val();
        var count = $("#J-count").val();
        var note = $("#J-note").val();

        if (category.length === 0){
            alert("请选择旧件品牌");
            return false;
        } else if (name.length === 0){
            alert("请填写旧件名称");
            return false;
        } else if (drawing.length === 0){
            alert("请填写旧件图号");
            return false;
        } else if (price.length === 0){
            alert("请填写旧件价格");
            return false;
        } else if (fault_desc.length === 0){
            alert("请填写旧件故障描述");
            return false;
        } else if (count.length === 0){
            alert("请填写旧件数量");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/warehouses/" + warehouse_id + "/oldparts",
                dateType: "json",
                cache: false,
                data: {
                    'oldpart': {
                        'category': category,
                        'name': name,
                        'drawing': drawing,
                        'price': price,
                        'factory': factory,
                        'factory_code': factory_code,
                        'fault_desc': fault_desc,
                        'note': note
                    },
                    'count': count
                },
                statusCode: {
                    201: function() {
                        window.location.href="/warehouses/" + warehouse_id + "#J-oldpart_info";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    })
};
//autocomplete
var autoComp = function(){
    $("#J-part_name").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/oldparts/oldpart_search?q=" + $("#J-part_name").val(),
                dataType: "json",
                data: {
                    featureClass: "P",
                    style: "full",
                    maxRows: 12,
                    name_startsWith: request.term
                },
                success: function( data ) {
                    response( $.map( data.oldparts, function( item ) {
                        return {
                            label: item,
                            value: item
                        }
                    }));
                }
            });
        },
        minLength: 1,
        open: function() {
            $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
        },
        close: function() {
            $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
        }
    });
};

//
var searchOldparts = function() {
  $("#oldparts th a, #oldparts .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#oldparts_search input").keyup(function() {
    $.get($("#oldparts_search").attr("action"), $("#oldparts_search").serialize(), null, "script");
    return false;
  });
};


$(document).ready(function(){
//    directpartSave();
//    directpartContinue();
//    indirectpartSave();
//    indirectpartContinue();
    editOldpart();
    editOldpartLink();
//    editIndirectpart();
//    editIndirectpartLink();
//    editOldpart();
    newOldpartFromWarehouse();
    addOldpart();
    searchOldparts();
    autoComp();
//    $('.J-oldpart_table').treeTable();
});