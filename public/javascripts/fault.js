//新增故障
var faultSave = function(){
    $('#J-fault_save_1').click(function(){
        var workflow_id = $('#J-workflow_id').val();
        var measure = $("input:radio[checked]").val(); //处理措施： 调整、更换、检修
        var fault_analyse = $('#J-fault_analyse').val();

        var oldpart_category = $('#J-category option:selected').val();
        var oldpart_name = $('#J-name option:selected').val();
        var oldpart_drawing = $('#J-drawing option:selected').val();
//        var oldpart_category = $("#J-category").val();
//        var oldpart_name = $("#J-name").val();
//        var oldpart_drawing = $("#J-drawing").val();
        var oldpart_count = $("#J-part_count").val();
        var factory = $('#J-factory_name').val();
        var factory_code = $('#J-factory_code').val();

        if(fault_analyse.length === 0){
            alert("请填写故障分析");
            return false;
        }else if(fault_analyse.length<2){
            alert("分析内容过短");
            return false;
        }else if( measure.length === 0 ){
            alert("请选择处理措施");
            return false;
        }else if( oldpart_category.length === 0 ){
            alert("请输入旧件分类");
            return false;
        }else if( oldpart_name.length === 0 ){
            alert("请输入旧件名称");
            return false;
        }else if( oldpart_drawing.length === 0 ){
            alert("请输入旧件图号");
            return false;
        }else if( oldpart_count.length === 0 ){
            alert("请输入旧件数量");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/faults?wid=" + workflow_id,
                dateType: "json",
                cache: false,
                data: {
                    'fault': {
                        'fault_analyse': fault_analyse,
                        'measure': measure
                    },
                    'oldpart': {
                        'category': oldpart_category,
                        'name': oldpart_name,
                        'drawing': oldpart_drawing,
                        'count': oldpart_count,
                        'factory': factory,
                        'factory_code': factory_code
                    }
                },
                statusCode: {
                    201: function() {
                        window.location.href="/workflows/workflow_flow";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("内部错误：提交的数据有错误");
//                                showErrorTip(phone, '这个电话已经被占用了',phone);
                    }
                }
            })
        };
	});
};
//继续添加故障
var faultContinue = function(){
    $('#J-fault_save_continue').click(function(){
        var workflow_id = $('#J-workflow_id').val();
        var measure = $("input:radio[checked]").val(); //处理措施： 调整、更换、检修
        var fault_analyse = $('#J-fault_analyse').val();

        var oldpart_category = $('#J-category option:selected').val();
//        var oldpart_name = $('#J-name option:selected').val();
//        var oldpart_drawing = $('#J-drawing option:selected').val();
        var oldpart_category = $("#J-category").val();
        var oldpart_name = $("#J-name").val();
        var oldpart_drawing = $("#J-drawing").val();

        var oldpart_count = $("#J-part_count").val();
        var factory = $('#J-factory_name').val();
        var factory_code = $('#J-factory_code').val();

        if(fault_analyse.length === 0){
            alert("请填写故障分析");
            return false;
        }else if(fault_analyse.length<2){
            alert("分析内容过短");
            return false;
        }else if( measure.length === 0 ){
            alert("请选择处理措施");
            return false;
        }else if( oldpart_category.length === 0 ){
            alert("请输入旧件分类");
            return false;
        }else if( oldpart_name.length === 0 ){
            alert("请输入旧件名称");
            return false;
        }else if( oldpart_drawing.length === 0 ){
            alert("请输入旧件图号");
            return false;
        }else if( oldpart_count.length === 0 ){
            alert("请输入旧件数量");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/faults?wid=" + workflow_id + '&add_continue=true',
                dateType: "json",
                cache: false,
                data: {
                    'fault': {
                        'fault_analyse': fault_analyse,
                        'measure': measure
                    },
                    'oldpart': {
                        'category': oldpart_category,
                        'name': oldpart_name,
                        'drawing': oldpart_drawing,
                        'count': oldpart_count,
                        'factory': factory,
                        'factory_code': factory_code
                    }
                },
                statusCode: {
                    0: function(data) {
                        window.location.reload(true);
                    },
                    201: function(data) {
                        window.location.reload(true);
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("内部错误：提交的数据有错误");
                    //showErrorTip(phone, '这个电话已经被占用了',phone);
                    }
                }
            });
        }
    });
};
//添加间接故障弹框
var addIndirectFault = function(){
    $(".add-ind-fault").click(function() {
        var fault_id = $(this).attr('id');
        $("#J-fault_id").attr('value', fault_id);
        $("#I-add_ind_fault").dialog("open");
    });
    $("#I-add_ind_fault").dialog({
        autoOpen: false,
		width: 975,
		modal: true,
		buttons: {
			"保存": function() {
                var workflow_id = $('#J-workflow_id').val();
                var fid = $("#J-fault_id").val();
                //        var fault_desc = $('#J-fault_desc').val();
                var measure = $("input:radio[checked]").val(); //处理措施： 调整、更换、检修
                var fault_analyse = $('#I-fault_analyse').val();
                var indpart_category = $('#I-category').val();
                var indpart_name = $('#I-name').val();
                var indpart_drawing = $('#I-drawing').val();
                var indpart_count = $('#I-part_count').val();
                var factory = $('#I-factory_name').val();
                var factory_code = $('#I-factory_code').val();
                if(fault_analyse.length === 0){
                    alert("请填写故障分析");
                    return false;
                }else if(fault_analyse.length<2){
                    alert("分析内容过短");
                    return false;
                }else if( measure.length === 0 ){
                    alert("请选择处理措施");
                    return false;
                }else if( indpart_category.length === 0 ){
                    alert("请输入旧件分类");
                    return false;
                }else if( indpart_name.length === 0 ){
                    alert("请输入旧件名称");
                    return false;
                }else if( indpart_drawing.length === 0 ){
                    alert("请输入旧件图号");
                    return false;
                }else if( indpart_count.length === 0 ){
                    alert("请输入旧件数量");
                    return false;
                }else{
                    $.ajax({
                        url: '/faults/ind_fault_create',
                        headers: {
                            'X-Transaction': 'POST Example',
                            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                        },
                        dataType: "json",
                        type: "POST",
                        data: {
                            'ind_fault': {
                                'measure': measure,
                                'fault_analyse': fault_analyse
                            },
                            'ind_oldpart': {
                                'category': indpart_category,
                                'ind_name': indpart_name,
                                'ind_drawing': indpart_drawing,
                                'ind_count': indpart_count,
                                'ind_factory': factory,
                                'ind_factory_code': factory_code
                            },
                            'fault_id': fid
                        },
                        statusCode: {
                            201: function() {
                                window.location.reload(true);
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
                }
            },
			"取消": function() {
				$(this).dialog("close");
			}
        }
    })
};
// 编辑间接故障弹窗
var editIndFault = function() {
    $(".edit_ind_fault").click(function(){
        var ind_fault_id = $(this).attr('id');
        $("#U-ind_fault_id").attr('value', ind_fault_id);
//        var fid = $("#U-ind_fault_id").val();
//        alert(fid);
        $("#I-update_ind_fault").dialog("open");
        $.ajax({
            url: "/faults/ind_fault_edit?ind_fault_id=" + ind_fault_id,
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                if (data.indfault) {
                    $.each(data.indfault, function(key, val) {
                        switch (key) {
                            case "fault_analyse":
                                $("#I-update_fault_analyse").text(val);
                                break;
                            case "measure":
                                $("#J-measure").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    });
                    $.each(data.indirectpart, function(key, val){
                        switch (key) {
                            case "category":
                                $("#I-update_category").attr('value', val);
                                break;
                            case "ind_name":
                                $("#I-update_name").attr('value', val);
                                break;
                            case "ind_drawing":
                                $("#I-update_drawing").attr('value', val);
                                break;
                            case "ind_count":
                                $("#I-update_part_count").attr('value', val);
                                break;
                            case "ind_factory":
                                $("#I-update_factory_name").attr('value', val);
                                break;
                            case "ind_factory_code":
                                $("#I-update_factory_code").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    })
                }
                else{
                    $.each(data, function(key, val) {
                        switch (key) {
                            case "fault_analyse":
                                $("#I-update_fault_analyse").attr('value', val);
                                break;
                            case "measure":
                                $("#J-measure").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    })
                }
            }
        })
    });
    $("#I-update_ind_fault").dialog({
        autoOpen: false,
		width: 975,
		modal: true,
        buttons: {
            "保存": function() {
                var fid = $("#U-ind_fault_id").val();
                alert(fid);
                $.ajax({
                    url: "/faults/ind_fault_update?ind_fault_id=" + fid,
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'ind_fault': {
                            'measure': $("input:radio[checked]").val(),
                            'fault_analyse': $("#I-update_fault_analyse").val()
                        },
                        'indirectpart': {
                            'category': $('#I-category option:selected').val(),
                            'ind_name': $("#I-name option:selected").val(),
                            'ind_drawing': $("I-drawing option:selected").val(),
//                            'category': $('#I-update_category').val(),
//                            'ind_name': $("#I-update_name").val(),
//                            'ind_drawing': $("I-update_drawing").val(),
                            'ind_count': $("I-update_part_count").val(),
                            'ind_factory': $("I-update_factory_name").val(),
                            'ind_factory_code': $("I-update_factory_code").val()
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
    })
};
//编辑故障信息弹窗
var editFault = function() {
    //保存当前href
    $(".edit_fault").click(function() {
        var id = $(this).attr("id");
        $("#U-fault_id").attr("value", id);
        $("#U-update_fault").dialog("open");

        $.ajax({
            url: "/faults/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                if (data.fault){
                    $.each(data.fault, function(key,val){
                        switch (key) {
                            case "fault_analyse":
                                $("#U_fault_analyse").attr('value', val);
                                break;
                            case "measure":
                                $("#U-measure").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    });
                    $.each(data.oldpart, function(key, val){
                        switch (key) {
                            case "category":
                                $("#U-part_category").attr('value', val);
                                break;
                            case "name":
                                $("#U-part_name").attr('value', val);
                                break;
                            case "drawing":
                                $("#U-part_drawing").attr('value', val);
                                break;
                            case "count":
                                $("#U-part_count").attr('value', val);
                                break;
                            case "factory":
                                $("#U-factory_name").attr('value', val);
                                break;
                            case "factory_code":
                                $("#U-factory_code").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    })
                }else{
                    $.each(data, function(key, val) {
                        switch (key) {
                            case "fault_analyse":
                                $("#J-fault_analyse").attr('value', val);
                                break;
                            case "measure":
                                $("#J-measure").attr('value', val);
                                break;
                            default:
                                break;
                        }
                    })
                }
            }
        })
    });
    $("#U-update_fault").dialog({
		autoOpen: false,
		width: 975,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: "/faults/" + $("#U-fault_id").val(),
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'fault': {
                            'measure': $("input:radio[checked]").val(),
                            'fault_analyse': $("#U_fault_analyse").val()
                        },
                        'oldpart': {
                            'category': $('#U-category option:selected').val(),
                            'name': $('#U-name option:selected').val(),
                            'drawing': $('#U-drawing option:selected').val(),
//                            'category': $('#U-part_category').val(),
//                            'name': $('#U-part_name').val(),
//                            'drawing': $('#U-part_drawing').val(),
                            'factory': $('#U-factory_name').val(),
                            'factory_code': $('#U-factory_code').val()
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
    })
};
//编辑故障信息 index page
var editFaultLink = function() {
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function(e){
       e.stopPropagation();
    });
    $(".editFaultLink").click(function() {
        $("#J-Fault_update").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url: href + "/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function(data) {
                $.each(data, function(key, val) {
                    switch (key) {
                        case "fault_desc":
                            $("#U-fault_desc").attr('value', val);
                            break;
                        case "fault_analyse":
                            $("#U-fault_analyse").attr('value', val);
                            break;
                        case "measure":
                            $("#U-measure").attr('value', val);
                            break;
                        case "id":
                            $('#U-Fault_id').attr('value', val);
                            break;
                        default:
                            break
                    }
                })
            }
        })
    });
    $("#J-Fault_update").dialog({
		autoOpen: false,
		width: 905,
		modal: true,
		buttons: {
			"保存": function() {
                $.ajax({
                    url: href + "/" + $("#U-Fault_id").val(),
                    headers: {
                        'X-Transaction': 'POST Example',
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'fault': {
                            'measure': $("input:radio[checked]").val(),
                            'fault_analyse': $("#U-fault_analyse").val()
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
var newFaultLink = function(){
    $('.newFaultLink').click(function(){
        window.location.href = "/faults/new";
    });
};
//显示选择旧件
//var showOldpart = function(){
//    $('#J-measure2').click(function(){
//        $('#J-add_oldpart').show('fast');
//    });
//    $('#J-measure1').click(function(){
//        $('#J-add_oldpart').hide('fast');
//    });
//    $('#J-measure3').click(function(){
//        $('#J-add_oldpart').hide('fast');
//    });
//};
//select Part Category
jQuery.fn.extend({
    selectReturn:function(categories, names, JSON) {
        var category = [];
        var html_category = '';
        for (var m in JSON) {
            category.push(m)
        }
        if (category != '') {
            for (var i in category) {
                html_category = html_category + '<option>' + category[i] + '</option>'
            }
            $(categories).html(html_category);
        }
        $(categories).change(function() {
            var name = [];
            var html_name = '';
            $(names).html(html_name);
            var current_category = $(categories).val();
            $(names).attr('disabled', 'true');
            for (var n in JSON) {
                if (current_category == n) {
                    //获取分类数组
                    name = JSON[n][0];
                    if (name != '') {
                        for (var j in name) {
                            html_name = html_name + '<option>' + name[j] + '</option>'
                        }
                        $(names).html(html_name);
                        $(names).removeAttr('disabled')
                    }
                }
            }
        });
    }
});
var changeSelectPart = function() {
    $("select#J-category").change(
        function() {
            $.getJSON("/oldparts", {category: $(this).val()}, function(data) {
                var options = '';
                var results = data;

                for (var key in results) {
                    if (results.hasOwnProperty(key)) {
                        options += '<option value="' + results[key] + '">' + results[key] + '</option>';
                    }
                }
                $("#J-name").html(options);
                $("#J-name option:[value='0']").attr('selected', 'selected');
            })
        });

    $("select#J-name").change(
        function() {
            $.getJSON("/oldparts", {name: $(this).val()}, function(data) {
                var options = '';
                var results = data.drawings;
//                var price = data.prices;
                for (var key in results) {
                    if (results.hasOwnProperty(key)) {
                        options += '<option value="' + results[key] + '">' + results[key] + '</option>';
                    }
                }
                $("#J-drawing").html(options);
                $("#J-drawing option:[value='0']").attr('selected', 'selected');
            })
        });
};
//完成故障添加
var submitFault = function(){
    $("#J-fault_save").click(function(){
        $.ajax({
            url: "/faults/finished",
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: "json",
            type: "PUT",
            data: {
                "wid": $("#J-workflow_id").val()
            },
            statusCode: {
                200: function() {
                    window.location.href="/workflows/workflow_flow";
                },
                403: function() {
                    window.location.href = "/home/forbidden";
                },
                422: function() {
                    alert("内部错误：提交的数据有错误");
                }
            }
        })
    })
};
//autocomplete
var autoComp = function(){
    $("#J-part_name").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/faults/oldpart_search?q=" + $("#J-part_name").val(),
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
//selectmenu
//var selectMenu = function(){
//    $("#J-drawing").selectmenu();
//    withOverflow.selectmenu("menuWidget").addClass("overflow");
//};

$(document).ready(function(){
    newFaultLink();
    faultSave();
    addIndirectFault();
    editIndFault();
    faultContinue();
    editFault();
    editFaultLink();
//    showOldpart();
    changeSelectPart();
    submitFault();
//    selectMenu();

    $.fn.clearForm = function() {
      return this.each(function() {
        var type = this.type, tag = this.tagName.toLowerCase();
        if (tag == 'form')
          return $(':input',this).clearForm();
        if (type == 'text' || type == 'password' || tag == 'textarea')
          this.value = '';
        else if (type == 'checkbox' || type == 'radio')
          this.checked = false;
        else if (tag == 'select')
          this.selectedIndex = -1;
      });
    };
})