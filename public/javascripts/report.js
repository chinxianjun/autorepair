var reportNew = function(){
    var wid = $('#J-wid').val();
    var infoman = $('J-infoman').val();
    $('#J-report_submit').click(function(){
        $.ajax({
            type: "POST",
            url: "/reports?wid=" + wid,
            headers: {
                'X-Transaction': 'POST Example',
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            dataType: "json",
            data: {
                'report': {
                    'status': 'new',
                    'infoman': infoman
                }
            },
            statusCode: {
                0: function(){
                    window.location.href = "/workflows/workflow_flow"
                },
                201: function(){
                    window.location.href = "/workflows/workflow_flow"
                },
                403: function(){
                    window.locaiong.href = "/home/forbidden"
                },
                422: function(){
                    alert("ERROR: 422, 内部数据错误，无法提交")
                }
            }
        })
    })
};
//
var searchReport = function() {
  $("#reports th a, #reprots .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#reports_search input").keyup(function() {
    $.get($("#reports_search").attr("action"), $("#reports_search").serialize(), null, "script");
    return false;
  });
};

// to getflow
var toGetFlow = function(){
    $("#J-go_getFlow").click(function(){
        var workflow_id = $("input:radio[name=workflow]:checked").val();
        if (workflow_id.length === 0){
            alert("请选择一个流程")
        }else{
            window.location.href = "/reports/getflow?workflow_id=" + workflow_id
        }
    })
};

$(document).ready(function(){
    reportNew();
    searchReport();
    toGetFlow();
});