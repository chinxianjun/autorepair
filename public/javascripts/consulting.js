var consulting = function(){
    $('#J-add-consulting-save').click(function(){
        var category = $('input:radio[name=question_type]:checked').val();
        var customer_id = $('#J-customer_id').val();
        var consulting_desc = $('#J-consultingQuestion').val();
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
                cache: false,
                data: {
                    'question': {
                        'category': category,
                        'description': consulting_desc,
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
      var answer = $("#J-answer").val();
      var manager = $("#J-answerer").val();
      var creator = $("#J-answerer").val();
      var question_id = $("#J-question_id").val();
      if( answer.length === 0 ) {
          alert("解答内容不能为空");
          return false;
      } else {
          $.ajax({
              type: 'POST',
              headers: {
                  'X-Transaction': 'POST Example',
                  'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
              },
              url:  "/questions/" + question_id +"/consultings/",
              dateType: "json",
              cache: false,
              data: {
                  'consulting': {
                      'creator': creator,
                      'answerer': manager,
                      'question': descrition,
                      'answer': answer
                  }
              },
              statusCode: {
                  201: function() {
                      window.location.href = "/questions/" + question_id +"/consultings/";
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
    consulting();
    addEditInfo();
});