var dispatching = function() {
    $('#J-dispatch_update').click(function() {
        var customer_name = $('#J-customer_name').val();
        var customer_phone = $('#J-customer_phone').val();
        var customer_phone_swap = $('#J-customer_phone_swap').val();
        var faultdesc_desc = $('#J-faultdesc_desc').val();
        var faultdesc_car_number = $('#J-faultdesc_car_number').val();
        var faultdesc_place = $('#J-faultdesc_place').val();
        var id = $('#J-dispatch_id').val();
        var dispatcher = $('#J-dispatcher').val();
        var service_car_number = $('J-service_car_number').val();
        var repairer = new Array();
        var property = $('input:radio:checked').val();
//        alert("test");
        $('input:checkbox:checked').each(function() {
            repairer.push($(this).attr('id'));
        });

        if ($('input:checkbox:checked').length === 0) {
            alert("请选择维修工程师");
            return false;
        } else if ($('input:radio:checked').length === 0) {
            alert("请选择维修性质");
            return false;
        } else if (($('input:radio:checked').val() === 'rescue') &&
            (service_car_number.length === 0)) {
            alert("请填写服务车牌号");
        } else {
            $.ajax({
                url: "/dispatchings/" + id,
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                dataType: "json",
                type: "PUT",
                data: {
                    'dispatching': {
                        'customer_name': customer_name,
                        'customer_phone': customer_phone,
                        'customer_phone_swap': customer_phone_swap,
                        'faultdesc_desc': faultdesc_desc,
                        'faultdesc_car_number': faultdesc_car_number,
                        'faultdesc_place': faultdesc_place,
                        'dispatcher': dispatcher,
                        'service_car_number': service_car_number,
                        'property': property
                    },
                    'repairman_ids': repairer
                },
                statusCode: {
                    0: function() {
                        window.location.href = "/workflows/workflow_flow";
                    },
                    200: function() {
                        window.location.href = "/workflows/workflow_flow";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR: 422, 内部数据错误，无法提交");
                    }

                }
                //            error: function(xhr, status) {
                //                alert(xhr.status);
                //                alert(xhr.statusText);
                //            }
            })
        }
    });
};
var showServiceCar = function() {
    $('#J-property1').click(function() {
        if ($('input:radio:checked').val() === "into_factory") {
            $('#J-service_car').hide('fast');
        }
        else {
            $('#J-service_car').show('fast');
        }
    });
    $('#J-property2').click(function() {
        if ($('input:radio:checked').val() === "rescue") {
            $('#J-service_car').show('fast');
        }
        else {
            $('#J-service_car').hide('fast');
        }
    });
};
//显示费用估算
//var showCost = function(){
//    $("#J-three_bags_yes").click(function() {
//        if ($("input:radio:checked").val() === "三包" ) {
//            $("#J-show_cost").hide("fast");
//        }
//        else {
//            $("#J-show_cost").show("fast");
//        }
//    });
//    $("#J-three_bags_no").click(function() {
//        if ($("input:radio:checked").val() === "社会" ) {
//            $("#J-show_cost").show("fast");
//        }
//        else {
//            $("#J-show_cost").hide("fast");
//        }
//    })
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
            $.getJSON("/newparts", {category: $(this).val()}, function(data) {
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
            $.getJSON("/newparts", {name: $(this).val()}, function(data) {
                var options = '';
                var results = data.drawings;
                var price = data.prices;
                for (var key in results) {
                    if (results.hasOwnProperty(key)) {
                        options += '<option value="' + results[key] + '">' + results[key] + '</option>';
                    }
                }
                $("#J-drawing").html(options);
                $("#J-drawing option:[value='0']").attr('selected', 'selected');
                for (var k in price) {
                    if (price.hasOwnProperty(key)){
                        $("#J-part_price").attr('value', price[k]);
                    }
                }
            })
        });
};
//添加预算件
var addBudgetPart = function(){
    $('#J-add_budget_part').click(function(){
        var three_bags = $("input:radio[name=J-three_bags]:checked").val();
        var work_hour_cost = $("#J-work_hour_cost option:selected").val();
        $("#J-expense_count").text(work_hour_cost);
        var dispatching_id = $("#J-dispatch_id").val();
        var partCategory = $("#J-category option:selected").val();
        var partName = $("#J-name option:selected").val();
        var partDrawing = $("#J-drawing option:selected").val();
        var partCount = $("#J-part_count").val();
        var partPrice = $("#J-part_price").val();
        var expense_count = $("#J-expense_count").text();
        var cost_total = parseInt(partPrice) * parseInt(partCount) + parseInt(expense_count);
//        alert(expense_count);
//        var columns = '';
//        columns += ['<li><div class="workflow-item clrfix">' +
//                    '<span class="consultingQuestion">',partCategory,'</span>' +
//                    '<span class="consultingAnswer">',partName,'</span>' +
//                    '<span class="consultingDate">',partDrawing,'</span>' +
//                    '<span class="customer">',partPrice,'</span>' +
//                    '<span class="phone">',partCount,'</span>' +
//                    '<span class="tool">' +
//                    '<a href="javascript:void(0)" class="delete-workflow">删除</a></span></div>' +
//                    '<div class="workflowEditor"></div></li>'].join('');
//        $('#J-consult').append(columns);
        $('#J-expense_count').text(cost_total);
        if (partCategory === "0") {
            alert("请选择配件品牌");
            return false;
        }
        else if (partName === "0") {
            alert("请选择配件名称");
            return false;
        }
        else if (partDrawing === "0") {
            alert("请选择配件图号");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/dispatchings/" + dispatching_id + "/budget",
                dateType: "json",
                cache: false,
                data: {
                    'budget': {
                        'three_bags': three_bags,
                        'working_hours_cost': work_hour_cost,
                        'category': partCategory,
                        'name': partName,
                        'drawing': partDrawing,
                        'count': partCount,
                        'price': partPrice
                    }
                },
                statusCode: {
                    200: function() {
                        window.location.reload(true);
                    },
                    201: function() {
                        window.location.reload(true);
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("内部数据错误，无法提交");
                        return false;
                    }

                }
            });
            $("#J-add_budget_part").ajaxComplete(function(){
                $('#J-add_budget_part').attr('disabled',false);
            })
        }
    })
};
// 删除配件
var deleteOldpart = function(){
    $('.delete-workflow').click(function(){
        $(this).parent().parent().remove();
    })
};

//计算费用,显示派工
var countBudget = function(){
    $('#J-go_to_dispatch').click(function(){
        var material_cost = $('#J-material_cost').val();
        var work_hour_cost = $('#J-work_hour_cost').val();
        $('#J-add_budget').hide('fast');
        $('#J-add_dispatching').show('fast');
        var dispatch_id = $("#J-dispatch_id").val();
        window.location.href = "/dispatchings/" + dispatch_id + "/edit"
    })
};

// 隐藏派工div
var showDispatching = function(){
    $('#J-return_btn').click(function(){
        $('#J-add_budget').show('fast');
        $('#J-add_dispatching').hide('fast');
    })
};
// 创建派工
var dispatchingSave = function(){
    $('#J-dispatching_save').click(function(){
        var id = $('#J-dispatch_id').val();
        var dispatcher = $('#J-dispatcher').val();
        var warranty = $("#J-repair_warranty").val();

        var repairer = new Array();
//        alert("test");
        $("input:checkbox:checked").each(function() {
            repairer.push($(this).attr('id'));
        });
        $.ajax({
            url: "/dispatchings/" + id,
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: "json",
            type: "PUT",
            data: {
                'dispatching': {
                    'dispatcher': dispatcher
                },
                'repairman_ids': repairer,
                'warranty': warranty
            },
            statusCode: {
                0: function() {
                    window.location.href = "/workflows/workflow_flow";
                },
                200: function() {
                    window.location.href = "/workflows/workflow_flow";
                },
                403: function() {
                    window.location.href = "/home/forbidden";
                },
                422: function() {
                    alert("ERROR: 422, 内部数据错误，无法提交");
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

$(document).ready(function() {
    dispatching();
    showServiceCar();
    changeSelectPart();
//    addBudgetPart();
//    deleteOldpart();
    countBudget();
    showDispatching();
    dispatchingSave();
    autoComp();

//  budget for expenditure;
//  creator: rex lee
//
    var total_price = 0;

    var option = $("#J-part_price").val();
    var number_price = $("#part_count").val();
    var category = $("#J-category").val()
//            if(category == 0){
//                $("#J-part_name").val("");
//            }else{
//                $("#J-part_name").val(category);
//            }

    $("#J-part_name").focus(function(){
        var optionstring = "";
        $.getJSON("ajax.js", function(data){
            $.each(data,function(index,obj){
                $.each(obj,function(key,value){
                    optionstring += "<option>"+ value +"</option>";
                    $("#old_name").html(optionstring);
                });
            });
        })

    });
    //旧件名称
//            $("#J-category").change(function(){
//                var category_name = $(this).val();
//                $("#J-part_name").val(category_name);
//            })
//            var num = 001;
//              $("#J-part_name").blur(function(){
//                 var part_name = $("#J-part_name").val()
//                  var drawing = $("#J-drawing").length;
//                 for(num = 0;drawing<=num; num++){
//                     alert(num)
//                 }
//              })num
    //价格
    $("#J-part_price").attr("readonly","readonly");
    $("#J-drawing").change(function(){
        var part_price = $(this).val();
        $("#J-part_price").val(part_price);
//                $("#part_count").blur(function(){
//                    var number_price = $("#part_count").val();
//                    $("#total_price span").html(part_price*number_price);
//                })
    });
    $("#J-add_budget_part").click(function(event){
        var part_name = $("#J-part_name").val();
        var number_price = $("#part_count").val();
        var option = $("#J-part_price").val();

        if(part_name == " " || part_name.length == 0){
            alert("请输入旧件名称");
            return false;
        }



        var total_number= option*number_price;
        total_price += total_number;
        $("#total_price span").html(total_price);

        //生成列表
        var J_category = $("#J-category option:selected").text();
        var J_part_name = $("#J-part_name").val();
        var J_drawing = $("#J-drawing option:selected").text();
        var J_part_price = $("#J-part_price").val();
        var part_count = $("#J-part_count").val();
        if(J_part_price == 0){
            alert("图号单价不能为0");
            return false;
        }

        if(!(/^(\+|-)?\d+$/.test( part_count )) || part_count.length == 0){
            alert("必须输入正整数");
            $("#part_count").val("");
            return false;
        }
        $("#J-consult").append('<li class="clrfix">'
            +'<span class="consultingQuestion">'+J_category+'</span>'
            +'<span class="consultingAnswer">'+J_part_name+'</span>'
            +'<span class="consultingDate">'+J_drawing+'</span>'
            +'<span class="customer">'+J_part_price+'</span>'
            +'<span class="phone">'+part_count+'</span>'
            +'<span class="total">'+option*number_price+'</span>'
            +'<span class="tool"><a href="#">删除</a> </span>'
            +'</li>')
        $(".tool a").click(function(event){
            var total_number_price = $(this).parent().parent().find("span:eq(5)").text();
            total_price -= total_number_price
            $("#total_price span").html(total_price)
            $(this).parent().parent().detach()
            event.preventDefault().unbind();
        })
        event.preventDefault().unbind();
    })



});