//获取流程的json数据，并更新到菜单
var workflows = function(){
  $('.flow').ready(function(){
       var href = "/workflows/workflow_flow";

       if ( href === "/" )
       {
           return false;
       }
       else
       {
           $.ajax({
                cache: false,
                url: href,
                dataType: "json",
                type: "GET",
                //processData: false,
                contentType: "application/json",
                success: function(data) {
                    $.each(data, function(key, val) {
                        switch(key){
                            case  "dispatch_count":
                                $('#dispatching').html("<span>派工信息(" + val + ")</span>");
                                break;
                            case  "vehicle_count":
                                $('#vehicle').html("<span>登记车辆(" + val + ")</span>");
                                break;
                            case "fault_count":
                                $('#fault').html("<span>登记故障(" + val + ")</span>");
                                break;
                            case "oldpart_count":
                                $('#oldpart').html("<span>旧件信息(" + val + ")</span>");
                                break;
                            case "newpart_count":
                                $('#newpart').html("<span>领取新件(" + val + ")</span>");
                                break;
                            case "report_count":
                                $('#report').html("<span>上报信息(" + val + ")</span>");
                                break;
                            case "expense_count":
                                $('#expense').html("<span>费用管理(" + val + ")</span>");
                                break;
                            default:
                                break;
                        }
                    });
                }
           });
       }
  });
};

$(document).ready(function(){
//   flowTabs();
   workflows();
   var init_workflow_status = {
       "dispatch": "派工", "vehicle": "登记车辆", "fault": "登记故障",
       "newpart": "领取新件"
   };
});
