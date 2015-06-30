//添加新件弹窗
var newpartCreate = function() {
    $('.newPart').click(function() {
        $("#J-Newpart_create").dialog("open");
    });
    $("#J-Newpart_create").dialog({
        autoOpen: false,
        width: 550,
        modal: true,
        buttons: {
            "保存": function() {
                var category = $("#J-category input:radio:checked").val();
                var name = $('#J-name').val();
                var drawing = $('#J-drawing').val();
                var factory = $('#J-factory').val();
                var factory_code = $('#J-factory_code').val();
                var running_number = $('#J-running_number').val();
                var count = $('#J-count').val();
                var price = $('#J-price').val();
                if (name.length === 0) {
                    alert("新件名称不能为空")
                } else {
                    $.ajax({
                        url: "/newparts",
                        type: "POST",
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        dateType: "json",
                        cache: false,
                        data: {
                            'newpart': {
                                'category': category,
                                'name': name,
                                'drawing': drawing,
                                'factory': factory,
                                'factory_code': factory_code,
                                'running_number': running_number,
                                'count': count,
                                'price': price
                            }
                        },
                        statusCode: {
                            201: function() {
                                window.location.href = "/newparts";
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
                $(this).dialog("close");
            },
            "取消": function() {
                $(this).dialog("close");
            }
        }
    });
};
//编辑新建
var editNewpart = function(){
    //保存当前href
    var href = window.location.pathname;
    $(".editNewpart").click(function() {
        $("#J-Newpart_edit").dialog("open");
        $.ajax({
            url: window.location.pathname + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "name":
                            $("#U-name").attr('value', val);
                            break;
                        case "drawing":
                            $("#U-drawing").attr('value', val);
                            break;
                        case "factory":
                            $("#U-factory").attr('value', val);
                            break;
                        case "factory_code":
                            $("#U-factory_code").attr('value', val);
                            break;
                        case "running_number":
                            $("#U-running_number").attr('value', val);
                            break;
                        case "count":
                            $('#J-count').attr('value', val);
                            break;
                        case "price":
                            $('#J-price').attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Newpart_edit").dialog({
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
                        'newpart': {
                            'category': $("input:radio:checked").val(),
                            'name': $("#U-name").val(),
                            'drawing': $("#U-drawing").val(),
                            'factory': $("#U-factory").val(),
                            'factory_code': $("#U-factory_code").val(),
                            'running_number': $("#U-running_number").val(),
                            'count': $("#U-count").val(),
                            'price': $("#U-price").val()
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
//编辑新件----link
var editNewpartLink = function(){
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function(e){
       e.stopPropagation();
    });
    $(".editNewpartLink").click(function() {
        $("#J-Newpart_update").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url: href + "/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "name":
                            $("#U-name").attr('value', val);
                            break;
                        case "drawing":
                            $("#U-drawing").attr('value', val);
                            break;
                        case "factory":
                            $("#U-factory").attr('value', val);
                            break;
                        case "factory_code":
                            $("#U-factory_code").attr('value', val);
                            break;
                        case "running_number":
                            $("#U-running_number").attr('value', val);
                            break;
                        case "count":
                            $("#U-count").attr('value', val);
                            break;
                        case "price":
                            $("#U-price").attr('value', val);
                            break;
                        case "id":
                            $('#U-Newpart_id').attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Newpart_update").dialog({
		autoOpen: false,
		width: 550,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: href + "/" + $("#U-Newpart_id").val(),
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'newpart': {
                            'category': $("input:radio:checked").val(),
                            'name': $("#U-name").val(),
                            'drawing': $("#U-drawing").val(),
                            'factory': $("#U-factory").val(),
                            'factory_code': $("#U-factory_code").val(),
                            'running_number': $("#U-running_number").val(),
                            'count': $("#U-count").val(),
                            'price': $("#U-price").val()
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
//添加校对件
var directContinue = function(){
    $("#J-direct_continue").click(function(){
//        var category = $('#J-category').val();
        var name = $('#J-name').val();
        var category = $("input:radio[checked]").val();
        var drawing = $('#J-drawing').val();
        var factory = $('#J-factory').val();
        var factory_code = $('#J-factory_code').val();
        var running_number = $('#J-running_number').val();
        if(name.length === 0){
            alert("请填写旧件名称");
        }else if(name.length<2){
            alert("旧件名称过短");
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/newparts/contrast_create?contrast=oldpart",
                dateType: "json",
                cache: false,
                data: {
                    'oldpart': {
                        'name': name,
                        'drawing': drawing,
                        'factory': factory,
                        'factory_code': factory_code,
                        'running_number': running_number,
                        'category': category
                    }
                },
                statusCode: {
                    201: function(data) {

                        $('#J-oldpart_id').attr('value', data.id);

                        $('#J-oldpart_new').css({'top':0, 'left':'550px'});
                        $('#J-oldpart_new').animate(
                            {'left':'-620px'}, 500, function(){
                                $('#J-ind_new').animate({'left':400}, 500);  //切换到ind
                            }
                        );
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
//添加新件
var newpartSave = function(){
    $("#J-newpart_save").click(function(){
        var new_name = $('#J-part_name').val();
        var new_category = $("#J-category input:radio[name=category]:checked").val();
        var new_drawing = $('#J-drawing').val();
        var new_factory = $('#J-factory').val();
        var new_factory_code = $('#J-factory_code').val();
        var new_running_number = $('#J-running_number').val();
        var new_price = $('#J-price').val();
        var new_count = $("#J-count").val();
        if(new_category.length === 0){
            alert('请选择新件品牌');
            return false;
        }else if(new_name.length === 0){
            alert("请填写新件名称");
            return false;
        }else if(new_drawing.length === 0){
            alert("请填写新件图号");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/newparts",
                dateType: "json",
                cache: false,
                data: {
                    'newpart': {
                        'name': new_name,
                        'drawing': new_drawing,
                        'factory': new_factory,
                        'factory_code': new_factory_code,
                        'running_number': new_running_number,
                        'category': new_category,
                        'price': new_price,
                        'count': new_count
                    }
                },
                statusCode: {
                    201: function() {
                        window.location.href="/newparts";
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
    });
};
//继续添加新件
var newpartContinue = function(){
    $("#J-new_continue").click(function(){
        var new_name = $('#J-new_name').val();
        var new_category = $("input:radio[checked]").val();
        var new_drawing = $('#J-new_drawing').val();
        var new_factory = $('#J-new_factory').val();
        var new_factory_code = $('#J-new_factory_code').val();
        var new_running_number = $('#J-new_running_number').val();
        var new_price = $('#J-new_price').val();
        var oldpart_id = $('#J-oldpart_id').val();
        if(oldpart_id === null){
            alert('未获取到直接旧件ID');
            return false;
        }else if(new_name.length === 0){
            alert("请填写新件名称");
        }else if(new_drawing.length === 0){
            alert("请填写新件图号");
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/newparts/contrast_create?contrast=newpart&oldpart_id=" + oldpart_id,
                dateType: "json",
                cache: false,
                data: {
                    'newpart': {
                        'name': new_name,
                        'drawing': new_drawing,
                        'factory': new_factory,
                        'factory_code': new_factory_code,
                        'running_number': new_running_number,
                        'category': new_category,
                        'price': new_price
                    },
                    'oldpart_id': {
                        'oldpart_id': oldpart_id
                    }
                },
                statusCode: {
                    201: function() {
                        // require clear form
                        $('#J-ind_new').css({'top':0, 'left':'550px'});
                        $('#J-ind_new').animate(
                            {'left':'-620px'}, 500, function(){
                                $('#J-ind_new').css({'top':150, 'left':'550px'});
                                $('#J-ind_new').animate({'left':400}, 500);
                            }
                        );
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
//
var receivetNewpart = function(){
    var wid = $('#J-wid').val();
    $(".newPartReceive").click(function(){
        $("#J-newpart_receive").dialog("open");
        var alltd = $(this).parent().parent();
        alltd.each(function(){
            $("#J-name").attr("value", $(this).children('td').eq(2).html());
            $("#J-drawing").attr("value", $(this).children('td').eq(3).html());
            $("#J-count").attr("value", $(this).children('td').eq(4).html());
            $("#J-factory").attr("value", $(this).children('td').eq(5).html());
            $("#J-factory_code").attr("value", $(this).children('td').eq(6).html());
        })
    });

    $("#J-newpart_receive").dialog({
        autoOpen: false,
        width: 550,
        modal: true,
        buttons: {
            "保存": function() {
                $.ajax({
                    url: "/newparts/receive_finish",
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        "wid": wid,
                        "newpart": {
                            "category": $("input:radio[checked]").val(),
                            "name": $("#J-name").val(),
                            "drawing": $("#J-drawing").val(),
                            "count": $("#J-count").val(),
                            "factory": $("#J-factory").val(),
                            "factory_code": $("#J-factory_code").val(),
                            "running_number": $("#J-running_number").val()
                        }
                    },
                    statusCode: {
                        0: function() {
                            window.location.href = "/workflow/workflow_flow";
                        },
                        200: function() {
                            window.location.href= "/workflows/workflow_flow";
                        },
                        403: function() {
                            window.location.href = "/home/forbidden";
                        },
                        416: function() {
                            alert("警告：配件-" + $("#J-name").val() + "图号-" + $("#J-drawing").val() + "配件库存不足！" );
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
//autocomplete
var autoComp = function(){
    $("#J-part_name").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/newparts/newpart_search?q=" + $("#J-part_name").val(),
                dataType: "json",
                data: {
                    featureClass: "P",
                    style: "full",
                    maxRows: 12,
                    name_startsWith: request.term
                },
                success: function( data ) {
                    response( $.map( data.newparts, function( item ) {
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

$(document).ready(function() {
    newpartCreate();
    editNewpart();
    editNewpartLink();
    directContinue();
    newpartContinue();
    newpartSave();
    receivetNewpart();
    autoComp();
});