//新增弹框
var newCustomer = function () {
    $('.newCustomer').click(function () {
        $("#J-Customer_create").dialog("open");
    });
    $('#J-Customer_create').dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
//                alert($("#J-datepicker").val());
//                return false;
                var username = $('#J-username').val();
                var gender = $("input:radio[name=gender]:checked").val();
                var birthday = $('#J-datepicker').val();
                var address = $('#J-address').val();
                var phone = $('#J-phone').val();
                var category = $("#J-select_category option:selected").val();
                reg = /^13[0-9]{9}|15[012356789][0-9]{8}|18[012356789][0-9]{8}|147[0-9]{8}$/;

                if (username.length === 0) {
                    alert("请填写客户姓名");
                    return false;
                } else if (username.length < 2) {
                    alert("客户姓名太短");
                    return false;
                } else if (phone.length != 11) {
                    alert("手机号码位数不正确");
                    return false;
                } else if (!reg.test(phone)) {
                    alert("手机号码不正确");
                    return false;
                } else {
                    $.ajax({
                        type:'POST',
                        headers:{
                            'X-Transaction':'POST Example',
                            'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                        },
                        url:"/customers",
                        dateType:"json",
                        async:false,
                        cache:false,
                        data:{
                            'customer':{
                                'fullname':username,
                                'gender':gender,
                                'birthday':birthday,
                                'address':address,
                                'phone':phone,
                                'category':category
                            }
                        },
                        statusCode:{
                            200:function () {
                                window.location.href = "/customers";
                            },
                            201:function () {
                                window.location.href = "/customers";
                            },
                            403:function () {
                                window.location.href = "/home/forbidden";
                            },
                            422:function () {
                                alert('内部数据错误，无法提交！');
                                return false;
                            }
                        }
                    })
                }
                $(this).dialog("close");
            },
            "创建问题":function () {
                var username = $('#J-username').val();
                var gender = $("input:radio[name=gender]:checked").val();
                var birthday = $('#J-datepicker').val();
                var address = $('#J-address').val();
                var phone = $('#J-phone').val();
                var category = $("#J-select_category option:selected").val();
                reg = /^13[0-9]{9}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}$/;

                if (username.length === 0) {
                    alert("请填写客户姓名");
                    return false;
                } else if (username.length < 2) {
                    alert("客户姓名太短");
                    return false;
                } else if (phone.length != 11) {
                    alert("手机号码位数不正确");
                    return false;
                } else if (!reg.test(phone)) {
                    alert("手机号码不正确");
                    return false;
                } else {
                    $.ajax({
                        type:'POST',
                        headers:{
                            'X-Transaction':'POST Example',
                            'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                        },
                        url:"/customers",
                        dateType:"json",
                        async:false,
                        cache:false,
                        data:{
                            'customer':{
                                'fullname':username,
                                'gender':gender,
                                'birthday':birthday,
                                'address':address,
                                'phone':phone,
                                'category':category
                            }
                        },
                        statusCode:{
                            200:function (data) {
                                window.location.href = "/questions/repair_new?customer_id=" + data.id;
                            },
                            201:function (data) {
                                window.location.href = "/questions/repair_new?customer_id=" + data.id;
                            },
                            403:function () {
                                window.location.href = "/home/forbidden";
                            },
                            422:function () {
                                alert('内部数据错误，无法提交！');
                                return false;
                            }
                        }
                    })
                }
                $(this).dialog("close");
            }
        }
    });
};
//编辑客户信息
var editCustomer = function () {
    //保存当前href
    var href = window.location.pathname;
    $(".editCustomer").click(function () {
        $("#J-Customer").dialog("open");
        $.ajax({
            url:window.location.pathname + "/edit",
            type:"GET",
            dateType:"json",
            contentType:"application/json",
            success:function (data) {
                $.each(data, function (key, val) {
                    switch (key) {
                        case "fullname":
                            $("#J-username").attr('value', val);
                            break;
                        case "phone":
                            $("#J-phone").attr('value', val);
                            break;
                        case "address":
                            $("#J-address").attr('value', val);
                            break;
                        case "birthday":
                            $("#J-datepicker").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });
    $("#J-Customer").dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
                $.ajax({
                    url:href,
                    headers:{
                        'X-Transaction':'POST Example',
                        'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                    },
                    dataType:"json",
                    type:"PUT",
                    data:{
                        'customer':{
                            'fullname':$("#J-username").val(),
                            'gender':$("input:radio[checked]").val(),
                            'birthday':$("#J-datepicker").val(),
                            'address':$("#J-address").val(),
                            'phone':$("#J-phone").val()
                        }
                    },
                    statusCode:{
                        200:function () {
                            window.location.reload(href);
                        },
                        403:function () {
                            window.location.href = "/home/forbidden";
                        },
                        422:function () {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    })
};
//编辑客户信息 index page
var editCustomerLink = function () {
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function (e) {
        e.stopPropagation();
    });
    $(".editCustomerLink").click(function () {
        $("#I-Customer_update_index").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url: "/customers/" + id + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function (data) {
                $.each(data, function (key, val) {
                    switch (key) {
                        case "fullname":
                            $("#I-username").attr('value', val);
                            break;
                        case "phone":
                            $("#I-phone").attr('value', val);
                            break;
                        case "gender":
//                            alert(val);
                            if (val == "男")
                                $("input:radio[name='gender'][value='男']").attr("checked", true);
                            else
                                $("input:radio[name='gender'][value='女']").attr("checked", true);
                            break;
                        case "category":
                            $("#I-select_category").val(val);
                            break;
                        case "address":
                            $("#I-address").attr('value', val);
                            break;
                        case "birthday":
                            $("#I-datepicker").attr('value', val);
                            break;
                        case "id":
                            $("#I-Customer_id").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });

//    return false;
    $("#I-Customer_update_index").dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
                $.ajax({
                    url: "/customers/" + $("#I-Customer_id").val(),
                    headers: {
                        'X-Transaction':'POST Example',
                        'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'customer':{
                            'fullname':$("#I-username").val(),
                            'gender':$("input:radio[checked]").val(),
                            'category':$("#I-select_category option:selected").val(),
                            'birthday':$("#I-datepicker").val(),
                            'address':$("#I-address").val(),
                            'phone':$("#I-phone").val()
                        }
                    },
                    statusCode: {
                        200:function () {
                            window.location.href = "/customers";
                        },
                        403:function () {
                            window.location.href = "/home/forbidden";
                        },
                        422:function () {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    })
};

//编辑客户信息 show page
var showCustomerEdit = function () {
    //保存当前href
    var href = window.location.pathname;

    $(".showCustomerEdit").click(function () {
        $("#S-Customer_update_show").dialog("open");
        $.ajax({
            url: href + "/edit",
            type: "GET",
            dateType: "json",
            contentType: "application/json",
            success: function (data) {
                $.each(data, function (key, val) {
                    switch (key) {
                        case "fullname":
                            $("#S-username").attr('value', val);
                            break;
                        case "phone":
                            $("#S-phone").attr('value', val);
                            break;
                        case "gender":
//                            alert(val);
                            if (val == "男")
                                $("input:radio[name='gender_show'][value='男']").attr("checked", true);
                            else
                                $("input:radio[name='gender_show'][value='女']").attr("checked", true);
                            break;
                        case "category":
//                            alert(val);
                            $("#S-select_category").val(val);
                            break;
                        case "address":
                            $("#S-address").attr('value', val);
                            break;
                        case "birthday":
                            $("#S-datepicker").attr('value', val);
                            break;
                        case "id":
                            $("#S-Customer_id").attr('value', val);
                            break;
                        default:
                            break;
                    }
                })
            }
        })
    });

    $("#S-Customer_update_show").dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
//                alert($("input:radio[name=gender_show]:checked").val());
//                return false;
                $.ajax({
                    url: "/customers/" + $("#S-Customer_id").val(),
                    headers: {
                        'X-Transaction':'POST Example',
                        'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                    },
                    dataType: "json",
                    type: "PUT",
                    data: {
                        'customer':{
                            'fullname':$("#S-username").val(),
                            'gender':$("input:radio[name=gender_show]:checked").val(),
                            'category':$("#S-select_category option:selected").val(),
                            'birthday':$("#S-datepicker").val(),
                            'address':$("#S-address").val(),
                            'phone':$("#S-phone").val()
                        }
                    },
                    statusCode:{
                        200:function () {
                            window.location.href = "/customers/"  + $("#S-Customer_id").val();
                        },
                        403:function () {
                            window.location.href = "/home/forbidden";
                        },
                        422:function () {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    })
};
//新建流程
var newWorkflow = function () {
    $('.newWorkflow').click(function () {
        $('td a').click(function (e) {
            e.stopPropagation();
        });
        $("#J-Workflow_create").dialog("open");
        var id = $(this).attr('id');
//        alert(id);
        $.ajax({
            type:"GET",
            url:"/customers/" + id + "/edit",
            dateType:"json",
            contentType:"application/json",
            success:function (data) {
                $.each(data, function (key, val) {
                    switch (key) {
                        case "fullname":
                            $("#J-username").attr('value', val);
                            break;
                        case "phone":
                            $("#J-phone").attr('value', val);
                            break;
                        case "phone_swap":
                            $("#J-phone_swap").attr('value', val);
                            break;
                        default:
                            break;
                    }
                });
            }
        });
    });
    $('#J-Workflow_create').dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
                var car_number = $('#J-car_number').val();
                var description = $('#J-description').val();
                var place = $('#J-place').val();
                var username = $('#J-username').val();
                var phone = $('#J-phone').val();
                var phone_swap = $('#J-phone_swap').val();
                $.ajax({
                    type:"POST",
                    url:"/workflows",
                    async:false,
                    headers:{
                        'X-Transaction':'POST Example',
                        'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                    },
                    dataType:"json",
                    data:{
                        'workflow':{
                            'status':"dispatch"
                        },
                        'faultdesc':{
                            'car_number':car_number,
                            'description':description,
                            'place':place
                        },
                        'customer':{
                            'fullname':username,
                            'phone':phone,
                            'phone_swap':phone_swap
                        }
                    },
                    statusCode:{
                        201:function () {
                            window.location.href = "/workflows/workflow_flow";
                        },
                        403:function () {
                            window.location.href = "/home/forbidden";
                        },
                        422:function () {
                            alert("ERROR: 内部数据错误无法提交！");
                        }
                    }
                });
                $(this).dialog("close")
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    })
};
//选择tabs
var selectCustomers = function () {
    $('#J-allShow').click(function () {
        $('#J-buy_car_show').show('fast');
        $('#J-buyCarShow').addClass('tab_active');
        $('#J-buyPartShow').removeClass('tab_active');
        $('#J-repairShow').removeClass('tab_active');
        $('#J-buy_part_show').hide('fast');
        $('#J-repair_show').hide('fast');
    });
    $('#J-repairShow').click(function () {
        $('#J-repair_show').show('fast');
        $('#J-repairShow').addClass('tab_active');
        $('#J-buyPartShow').removeClass('tab_active');
        $('#J-buyCarShow').removeClass('tab_active');
        $('#J-buy_part_show').hide('fast');
        $('#J-buy_car_show').hide('fast');
    });
    $('#J-buyPartShow').click(function () {
        $('#J-buy_part_show').show('fast');
        $('#J-buyPartShow').addClass('tab_active');
        $('#J-repairShow').removeClass('tab_active');
        $('#J-buyCarShow').removeClass('tab_active');
        $('#J-repair_show').hide('fast');
        $('#J-buy_car_show').hide('fast');
    });
    $('#J-buyCarShow').click(function () {
        $('#J-buy_car_show').show('fast');
        $('#J-buyCarShow').addClass('tab_active');
        $('#J-buyPartShow').removeClass('tab_active');
        $('#J-repairShow').removeClass('tab_active');
        $('#J-buy_part_show').hide('fast');
        $('#J-repair_show').hide('fast');
    });
};
// createworkflow
var createWorkflow = function () {
    $(".createWorkflow").click(function () {
        var car_number = $('input#J-faultdesc_car_number').val();
        var place = $('input#J-faultdesc_place').val();
        var faultdesc = $('textarea#J-faultdesc_description').val();
        if (car_number.length === 0) {
            alert("请填写故障车牌号");
            return false;
        } else if (place.length === 0) {
            alert("请填写故障地点");
            return false;
        } else if (faultdesc.length === 0) {
            alert("请填写故障描述");
            return false;
        } else {
            $.ajax({
                url:'/workflows',
                type:'POST',
                headers:{
                    'X-Transaction':'POST Example',
                    'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                },
                dataType:'json',
                async:false,
                cache:false,
                data:{
                    'workflow':{
                        'description':"",
                        'status':"dispatch"
                    },
                    'customer':{
                        'id':$(this).attr('id'),
                        'fullname':$('input#J-customer_name').val(),
                        'phone':$('input#J-customer_phone').val(),
                        'phone_swap':$('input#J-customer_phone_swap').val()
                    },
                    'faultdesc':{
                        'description':$('textarea#J-faultdesc_description').val(),
                        'car_number':$('input#J-faultdesc_car_number').val(),
                        'place':$('input#J-faultdesc_place').val()
                    }
                },
                statusCode:{
                    201:function () {
                        window.location.href = "/workflows/workflow_flow";
                    },
                    403:function () {
                        window.location.href = "/home/forbidden";
                    },
                    422:function () {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            });
        }
    })
};

//新增级别弹框
var newCategory = function () {
    $('.newCategory').click(function () {
        $("#J-category_create").dialog("open");
    });
    $('#J-category_create').dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
                var category = $('#J-category').val();
                if (category.length === 0) {
                    alert("请填写级别内容");
                    return false;
                } else {
                    $.ajax({
                        type:'POST',
                        headers:{
                            'X-Transaction':'POST Example',
                            'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                        },
                        url:"/customers/category",
                        dateType:"json",
                        async:false,
                        cache:false,
                        data:{
                            'category':{
                                'category':category
                            }
                        },
                        statusCode:{
                            200:function () {
                                window.location.reload("true");
                            },
                            201:function () {
                                window.location.reload("true");
                            },
                            403:function () {
                                window.location.href = "/home/forbidden";
                            },
                            422:function () {
                                alert('创建失败');
                            }
                        }
                    })
                }
                $(this).dialog("close");
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    });
};
//编辑信息 index page
var editCategoryLink = function () {
    //保存当前href
    var href = window.location.pathname;
    $('td a').click(function (e) {
        e.stopPropagation();
    });
    $(".editCategoryLink").click(function () {
        $("#J-category_update").dialog("open");
        var id = $(this).attr('id');
        $.ajax({
            url:href + "/" + "?id=" + id,
            type:"GET",
            dateType:"json",
            contentType:"application/json",
            success:function (data) {
                $.each(data, function (key, val) {
                    switch (key) {
                        case "category":
                            $("#U-category").attr('value', val);
                            break;
                        default:
                            break;
                    }
                });
                $("#U-category_id").attr('value', id);
            }
        })
    });
    $("#J-category_update").dialog({
        autoOpen:false,
        width:550,
        modal:true,
        buttons:{
            "保存":function () {
                $.ajax({
                    url:href + "/?id=" + $("#U-category_id").val(),
                    headers:{
                        'X-Transaction':'POST Example',
                        'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                    },
                    dataType:"json",
                    type:"PUT",
                    data:{
                        'category':{
                            'category':$("#U-category").val()
                        }
                    },
                    statusCode:{
                        200:function () {
                            window.location.reload(href);
                        },
                        403:function () {
                            window.location.href = "/home/forbidden";
                        },
                        422:function () {
                            alert("ERROR:422,内部数据错误，无法提交.");
                        }
                    }
                });
                $(this).dialog("close");
            },
            "取消":function () {
                $(this).dialog("close");
            }
        }
    })
};
//
var searchCustomer = function() {
  $("#customers th a, #customers .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#customers_search input").keyup(function() {
    $.get($("#customers_search").attr("action"), $("#customers_search").serialize(), null, "script");
    return false;
  });
};

$(document).ready(function () {
    newCustomer();
    editCustomer();
    editCustomerLink();
    showCustomerEdit();
    newWorkflow();
    selectCustomers();
    createWorkflow();
    newCategory();
    editCategoryLink();
    searchCustomer();
});