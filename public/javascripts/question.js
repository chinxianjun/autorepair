//show fault replace
var showFaultPlace = function () {
    $('#J-repair_type1').click(function () {
        if ($('input:radio[name=repair_type]:checked').val() === "进厂") {
            $('#J-repair_rescue').hide('fast');
        }
        else {
            $('#J-repair_rescue').show('fast');
        }
    });
    $('#J-repair_type2').click(function () {
        if ($('input:radio[name=repair_type]:checked').val() === "救援") {
            $('#J-repair_rescue').show('fast');
        }
        else {
            $('#J-repair_rescue').hide('fast');
        }
    });
};

//select tabs
var selectQuestions = function () {
    var customer_id = $("#J-customer_id").val();
    $('#J-flowCreate').click(function () {
        window.location.href="/questions/repair_new?customer_id=" + customer_id;
    });
    $('#J-carBuying').click(function () {
        window.location.href="/questions/buy_car_new?customer_id=" + customer_id;
    });
    $('#J-partBuying').click(function () {
        window.location.href="/questions/buy_part_new?customer_id=" + customer_id;
    });
    $('#J-consulting').click(function () {
        window.location.href="/questions/consulting_new?customer_id=" + customer_id;
    });
    $('#J-complaint').click(function () {
        window.location.href="/questions/complaint_new?customer_id=" + customer_id;
    });
};
//create question
var createQuestion = function (message_account, message_password) {
    $("#J-add_question_save").click(function () {
        var category = $("input:radio[name=question_type]:checked").val();
        var repairtype = $("input:radio[name=repair_type]:checked").val();
        var faultplace = $("#J-fault_place").val();
        var carnumber_s = $("select[name=number] option:selected").val();
        var carnumber_n = $("#J-fault_car_number").val();
        var carnumber = carnumber_s + carnumber_n;
        var faultdescription = $("#J-fault_description").val();
        var customer_id = $("#J-customer_id").val();
//        var proce = $("input:radio[name=manager]:checked").val();
        var processor = $("input:radio[name=manager]:checked + label").text();

        var current_user = $("#J-current_user").val();
        var phone = $('input:radio[name=J-repair_manager]:checked').val();
        var customer_info = $("#J-repair_customer_info p").text();

        var model = $("#J-model").val();
        var chassis_number = $("#J-chassis_number").val();
        var driving_range = $("#J-driving_range").val();
        var purchase_on = $("#J-purchase_on").val();

        if ($("input:radio[name=not_send]:checked")) {

        } else {

            var content_pro =  customer_info +
            "维修类型:" + category +
            "故障地点:" + faultplace +
            "车牌号:" + carnumber +
            ",故障描述:" + faultdescription +
            ",客服:" + current_user;
            var content = ec_GBK(content_pro);
            var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        }

        if (category.length === 0) {
            alert('请选择问题类别');
            return false;
        } else if (chassis_number.length === 0) {
            alert('请填写车辆底盘号');
            return false;
        } else if (model.length === 0) {
            alert('请填写车型');
            return false;
        } else if (driving_range.length === 0) {
            alert('请填写行驶里程');
            return false;
        } else if (purchase_on.length === 0) {
            alert('请填写购车日期');
            return false;
        } else if (repairtype.length === 0) {
            alert('请选择维修模式');
            return false;
        } else if ((repairtype === 'rescue') && (faultplace.length === 0)) {
            alert('请填写故障地点');
            return false;
        } else if (faultdescription.length === 0) {
            alert('请填写故障描述');
            return false;
        } else if (processor.length === 0) {
            alert('请选择维修经理');
            return false;
        } else {
            $.ajax({
                type:"POST",
                headers:{
                    'X-Transaction':'POST Example',
                    'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                },
                url:"/questions",
                dateType:"json",
                async: false,
                cache:false,
                beforeSend: function(x) {
                    if(x && x.overrideMimeType) {
                        x.overrideMimeType("application/json;charset=UTF-8");
                    }
                },
                data:{
                    'question':{
                        'category':category,
                        'processor': processor,
                        'creator' :current_user,
                        'status':"未处理"
                    },
                    'faultdesc':{
                        'place': faultplace,
                        'car_number': carnumber,
                        'description': faultdescription,
                        'warranty': repairtype
                    },
                    'history':{
                        'send_man':current_user,
                        'receive_man':processor,
                        'content':content_pro
                    },
                    'vehicle': {
                        'chassis_number': chassis_number,
                        'model': model,
                        'driving_range': driving_range,
                        'purchase_on': purchase_on
                    },
                    'customer_id': customer_id,
                    'manager': processor
                },
                statusCode:{
                    error:function (xhr, status) {
                        alert(xhr.status);
                    },
                    0:function () {
                        window.location.href = "/workflows/workflow_flow";
                    },
                    201:function () {
                        window.location.href = "/workflows/workflow_flow";
                    },
                    403:function () {
                        window.location.href = "/home/forbidden";
                    },
                    422:function () {
                        alert('内部数据错误，无法提交');
                    }
                }
            })
        }
    });
    $("#J-add_question_save").ajaxComplete(function(event,request, settings){
        $(this).attr("disable", true)
    })
};
//car_buying
var car_buying = function(message_account, message_password){
    $('#J-add-buy-car-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var buy_car_desc = $('#J-buyCarQuestion').val();
        var buy_car_referral = $("#J-buy_car_referral").val();
        if (buy_car_referral == null){
            buy_car_referral = "无";
        }
        var current_user = $("#J-current_user").val();
        var phone = $('input:radio[name=buycar_manager]:checked').val();
        var processor = $('input:radio[name=buycar_manager]:checked + label').text();
        var customer_info = $("#J-customer_info p").text();
        var content_pro =  customer_info +
                       "推荐人:" + buy_car_referral +
                       ",购车意向:" + buy_car_desc +
                       ",客服:" + current_user;
        var content = ec_GBK(content_pro);
        var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

        if (category.length === 0){
            alert('请选择问题类别');
            return false;
        }else if (buy_car_desc.length === 0){
            alert('请填写购车信息');
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/questions",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': buy_car_desc,
                        'creator': current_user,
                        'processor': $("input:radio[name=buycar_manager]:checked + label").text(),
                        'status': "未处理"
                    },
                    'history':{
                        'send_man':current_user,
                        'receive_man':processor,
                        'content':content_pro
                    },
                    'customer_id': customer_id,
                    'referral': buy_car_referral
                },
                statusCode: {
                    0: function() {
//                        window.location.href="/questions/buy_car";
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    201: function() {
//                        window.location.href="/questions/buy_car";
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert('内部数据错误，无法提交');
                    }
                }
            })
        }
    })
};
// part_buying
var part_buying = function(message_account, message_password){
    $('#J-add-buy-part-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var buy_part_desc = $('#J-buyPartQuestion').val();
        var current_user = $("#J-current_user").val();
        var phone = $('input:radio[name=buypart_manager]:checked').val();
        var processor = $('input:radio[name=buypart_manager]:checked + label').text();
        var customer_info = $("#J-part_customer_info p").text();
        var content_pro =  customer_info + ",购件意向:" + buy_part_desc +
                       ",客服:" + current_user;
        var content = ec_GBK(content_pro);
        var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

        if (category.length === 0){
            alert('请选择问题类别');
            return false;
        }else if (buy_part_desc.length === 0){
            alert('请填写购件信息');
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/questions",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': buy_part_desc,
                        'creator': current_user,
                        'processor': $("input:radio[name=buypart_manager]:checked + label").text(),
                        'status': "未处理"
                    },
                    'history': {
                        'send_man': current_user,
                        'receive_man': processor,
                        'content': content_pro
                    },
                    'customer_id': customer_id,
                    'description': buy_part_desc
                },
                statusCode: {
                    0: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    201: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert('内部数据错误，无法提交');
                    }
                }
            })
        }
    })
};
// complaint
var complaint = function(message_account, message_password){
    $('#J-add-complaint-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var complaint_desc = $('#J-complaintQuestion').val();
        var current_user = $("#J-current_user").val();
        var phone = $('input:radio[name=complaint_manager]:checked').val();
        var processor = $('input:radio[name=complaint_manager]:checked + label').text();
        var customer_info = $("#J-complaint_customer_info p").text();
        var content_pro =  customer_info + ",投诉问题:" + complaint_desc +
                       "客服:" + current_user;
        var content = ec_GBK(content_pro);
        var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

        if (category.length === 0){
            alert('请选择问题类别');
            return false;
        }else if (complaint_desc.length === 0){
            alert('请填写投诉信息');
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/questions",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': complaint_desc,
                        'creator': current_user,
                        'processor': $("input:radio[name=complaint_manager]:checked + label").text(),
                        'status': "未处理"
                    },
                    'history':{
                        'send_man': current_user,
                        'receive_man': processor,
                        'content': content_pro
                    },
                    'customer_id': customer_id,
                    'description': complaint_desc
                },
                statusCode: {
                    0: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    201: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                        })
                        .complete(function(){window.location.href = "/questions/consulting";});
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert('内部数据错误，无法提交');
                    }
                }
            })
        }
    })
};
//consulting
var consulting = function(message_account, message_password){
    $('#J-add-consulting-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var consulting_desc = $('#J-consultingQuestion').val();
        var current_user = $("#J-current_user").val();
        var phone = $('input:radio[name=consulting_manager]:checked').val();
        var processor = $('input:radio[name=consulting_manager]:checked + label').text();
        var customer_info = $("#J-consulting_customer_info p").text();
        var content_pro =  customer_info + ",咨询问题:" + consulting_desc +
                       "客服:" + current_user;
        var content = ec_GBK(content_pro);
        var href = "http://sms.pica.com/zqhdServer/sendSMS.jsp?regcode=" + message_account +
            "&pwd=" + message_password +
            "&phone=" + phone +
            "&CONTENT=" + content +
            "&extnum=1" +
            "&level=1" +
            "&schtime=null" +
            "&reportflag=0" +
            "&url=" +
            "&smstype=0" +
            "&key=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";

        if (category.length === 0){
            alert('请选择问题类别');
            return false;
        }else if (consulting_desc.length === 0){
            alert('请填写咨询信息');
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/questions",
                dateType: "json",
                async: false,
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': consulting_desc,
                        'creator': current_user,
                        'processor': $("input:radio[name=consulting_manager]:checked + label").text(),
                        'status': "未处理"
                    },
                    'history':{
                        'send_man': current_user,
                        'receive_man': processor,
                        'content': content_pro
                    },
                    'customer_id': customer_id,
                    'description': consulting_desc
                },
                statusCode: {
                    0: function() {
//                        $.get(href, function () {
//                            $('#J-receive_content').append(data);
//                        })
//                        .complete(function(){window.location.href = "/questions/consulting";});
                        window.location.href = "/questions/consulting";
                    },
                    201: function() {
//                        $.get(href, function () {
//                            $('#J-receive_content').append(data);
//                        })
//                        .complete(function(){window.location.href = "/questions/consulting";});
                        window.location.href = "/questions/consulting";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert('内部数据错误，无法提交');
                    }
                }
            })
        }
    })
};
//autocomplete
var autoComp = function(){
    $("#J-vehicle_chassis_number").autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "/questions/search_vehicle?q=" + $("#J-vehicle_chassis_number").val(),
                dataType: "json",
                data: {
                    featureClass: "P",
                    style: "full",
                    maxRows: 12,
                    name_startsWith: request.term
                },
                success: function( data ) {
                    response( $.map( data.vehicles, function( item ) {
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
// add_vehicle
var addVehicle = function(){
    $("#J-add_vehicle").click(function(){
//        $("#J-vehicle").clone().insertAfter($("table"));
        $("table").append($("#J-vehicle_info > tr")).clone();
    })
};

$(document).ready(function (){
    var message_account = "ZXHD-SDK-0108-EBQNKI";
    var message_password = "12345678";
//    var message_account = "ZXHD-SDK-0108-EBQNKI-0000";1
//    var message_password = "931451330000";
    message_password = $.md5(message_password);
    showFaultPlace();
    selectQuestions();
    createQuestion(message_account, message_password);
    car_buying(message_account, message_password);
    part_buying(message_account, message_password);
    complaint(message_account, message_password);
    consulting(message_account, message_password);
    autoComp();
    addVehicle();
});