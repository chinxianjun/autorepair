var car_buying = function(){
    $('#J-add-buy-car-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var buy_car_desc = $('#J-buyCarQuestion').val();
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
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': buy_car_desc,
                        'status': "未处理"
                    },
                    'customer_id': customer_id
                },
                statusCode: {
                    0: function() {
                        window.location.href="/questions";
                    },
                    201: function() {
                        window.location.href="/questions";
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
//add salesman
var addSalesman = function (message_account, message_password){
    $("#J-add_salesman").click(function(){
        var salesman = $("input:radio:checked + label").text();
            salesman = $.trim(salesman);
        var question_id = $("#J-question_id").val();
        var car_buying_id = $("#J-car_buying_id").val();
        var description = $("textarea").val();
        var referral = $("#J-referral").val();
        var current_user = $("#J-current_user").val();
        var customer_name = $("#J-customer_name").val();
        var customer_phone = $("#J-customer_phone").val();
        var phone = $("input:radio:checked").val();
        var content_pro = "客户姓名:" + customer_name +
                      ",客户电话:" + customer_phone +
                      ",推荐人:" + referral +
                      ",购车意向:" + description +
                      ",销售经理:" + current_user
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

        if ( salesman.length === 0 ) {
            alert("请选择业务员");
            return false;
        } else {
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/questions/" + question_id +"/car_buyings/" + car_buying_id + "/add_salesman",
                dateType: "json",
                cache: false,
                data: {
                        'history': {
                            'send_man': current_user,
                            'receive_man': salesman,
                            'content': content_pro
                        },
                        'salesman': salesman,
                        'description': description,
                        'referral': referral
                },
                statusCode: {
                    0: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                            return false;
                        })
                        .complete(function(){window.location.href = "/questions/" + question_id +"/car_buyings";});
                    },
                    200: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                            return false;
                        })
                        .complete(function(){window.location.href = "/questions/" + question_id +"/car_buyings";});
                    },
                    201: function() {
                        $.get(href, function () {
                            $('#J-receive_content').append(data);
                            return false;
                        })
                        .complete(function(){window.location.href = "/questions/" + question_id +"/car_buyings";});
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("内部数据错误，无法提交");
                        return false;
                    }
                }
            })
        }
    })
};
// add edit info
var addEditInfo = function(){
  $("#J-add_edit_info").click(function(){
      var descrition = $("#J-description").val();
      var status = $("input:radio[name='status']:checked").val();
      var manager = $("#J-manager").val();
      var creator = $("#J-manager").val();
      var salesman = $("input:radio[name='salesman']:checked").val();

      if (salesman == null) {
          salesman = $("#J-salesman").val();
      }
      var referral = $("#J-referral").val();
      var question_id = $("#J-question_id").val();
      if( descrition.length === 0 ) {
          alert("购车意向不能为空");
          return false;
      }else if( status == null ){
          alert("请选择状态");
          return false;
      } else {
          $.ajax({
              type: 'POST',
              headers: {
                  'X-Transaction': 'POST Example',
                  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
              },
              url:  "/questions/" + question_id +"/car_buyings/",
              dateType: "json",
              cache: false,
              data: {
                  'car_buying': {
                      'salesman': salesman,
                      'creator': creator,
                      'manager': manager,
                      'description': descrition,
                      'referral': referral,
                      'status': status
                  }
              },
              statusCode: {
                  201: function() {
                      window.location.href = "/questions/" + question_id +"/car_buyings/";
                  },
                  403: function() {
                      window.location.href = "/home/forbidden";
                  },
                  422: function() {
                      alert("内部数据错误，无法提交");
                      return false;
                  }
              }
          })
      }
  })
};

$(document).ready(function(){
    var message_account = "ZXHD-SDK-0108-EBQNKI";
    var message_password = "93145133";
    message_password = $.md5(message_password);
    car_buying();
    addSalesman(message_account, message_password);
    addEditInfo();
});