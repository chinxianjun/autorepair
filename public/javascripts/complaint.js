var complaint = function(){
    $('#J-add-complaint-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var complaint_desc = $('#J-complaintQuestion').val();
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
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': complaint_desc,
                        'status': "0"
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
// add edit info
var addEditInfo = function(){
  $("#J-add_edit_info").click(function(){
      var descrition = $("#J-description").val();
      var measures = $("#J-measures").val();
      var category = $("input:radio[name='category']:checked").val();
      var status = $("input:radio[name='status']:checked").val();
      var manager = $("#J-manager").val();
      var creator = $("#J-manager").val();
      var question_id = $("#J-question_id").val();
      if( measures.length === 0 ) {
          alert("处理措施不能为空");
          return false;
      }else if( category == null ){
          alert("请选择投诉级别");
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
              url:  "/questions/" + question_id +"/complaints/",
              dateType: "json",
              cache: false,
              data: {
                  'complaint': {
                      'creator': creator,
                      'manager': manager,
                      'description': descrition,
                      'measures': measures,
                      'status': status,
                      'category': category
                  }
              },
              statusCode: {
                  201: function() {
                      window.location.href = "/questions/" + question_id +"/complaints/";
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
    complaint();
    addEditInfo();
});