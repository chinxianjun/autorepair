//添加直接破损旧件
var addPart = function(){
    $("#J-part_save").click(function(){
        var part_name = $('#J-part_name').val();
        var part_category = $("#J-part_category>input:radio[checked]").val();
        var part_manager = $('#J-part_manager').val();
        if(part_name.length === 0){
            alert("请填写配件库名称");
            return false;
        }else if(part_manager.length === 0){
            alert("请填写配件库管理员");
            return false;
        }else if($('input:radio:checked').length === 0){
            alert("请选择配件库类别");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/parts",
                dateType: "json",
                cache: false,
                data: {
                    'part': {
                        'name': part_name,
                        'manager': part_manager,
                        'category': part_category
                    }
                },
                statusCode: {
                    201: function() {
                        window.location.href="/parts";
                    },
                    403: function() {
                        window.location.href = "/home/forbidden";
                    },
                    422: function() {
                        alert("ERROR: 422, 内部数据错误，无法提交.");
                    }
                }
            });

        }
    });
};
//
var editPart = function(){
    $(".editPart").click(function(){
        var id = $("#J-part_id").val();
        window.location.href="/parts/" + id + "/edit"
    })
};
//
var updatePart = function(){
    $(".updatePart").click(function(){
        var part_name = $("#U-part_name").val();
        var part_manager = $("#U-part_manager").val();
        var part_category = $("input:radio[name=part_category]:checked").val();
        var part_id = $("#J-part_id").val();
        if (part_name.length ===0){
            alert("请输入配件库名称");
            return false;
        }else if(part_manager.length ===0){
            alert("请输入配件库管理员");
            return false;
        }else if(part_category.length ===0){
            alert("请选择配件库类别");
            return false;
        }else{
            $.ajax({
                url:"/parts/" + part_id,
                headers:{
                    'X-Transaction':'POST Example',
                    'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                },
                dataType:"json",
                type:"PUT",
                data:{
                    'part':{
                        'name':part_name,
                        'manager':part_manager,
                        'category':part_category
                    }
                },
                statusCode:{
                    200:function () {
                        window.location.reload("/parts");
                    },
                    403:function () {
                        window.location.href = "/home/forbidden";
                    },
                    422:function () {
                        alert("ERROR:422,内部数据错误，无法提交.");
                    }
                }
            })
        }
    })
};
//To use part autocomplete
var partComplete = function() {
    $('input.autocomplete').each(function(){
        var input = $(this);
        input.autocomplete(input.attr('autocomplete_url'));
    });
//  $("#J-part_name").keyup(function() {
//        $.get($("#J-part_name").attr("action"), $("#J-part_name").serialize(), null, "script");
//        return false;
//  });
//  function log( message ) {
//    $( "<div/>" ).text( message ).prependTo( "#log" );
//    $( "#log" ).scrollTop( 0 );
//  }
//
//    $( "#J-part_name" ).autocomplete({
//        source: function( request, response ) {
//            $.ajax({
//                url: "/parts/search_parts?q=" + $("#J-part_name").val(),
//                multiple: false,
//                delay: 100,
//                dataType: "json",
//                scroll: true,
//                scrollHeight: 300,
//                parse: function( data ) {
//                    return( $.map( data, function( row ) {
//                        return {
//                            data: row,
//                            label: row.name,
//                            value: row.name
//                        }
//                    }));
//                }
//            });
//        },
//        minLength: 2,
//        select: function( event, ui ) {
//            log( ui.item ?
//                "Selected: " + ui.item.label :
//                "Nothing selected, input was " + this.value);
//        },
//        open: function() {
//            $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
//        },
//        close: function() {
//            $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
//        }
//    });
};
//search parts
var searchPart = function() {
    $("#parts th a, #parts .pagination a").live("click", function() {
        $.getScript(this.href);
        return false;
    });
    $("#parts_search input").keyup(function() {
        $.get($("#parts_search").attr("action"), $("#parts_search").serialize(), null, "script");
        return false;
    });
};

$(document).ready(function(){
    addPart();
    editPart();
    updatePart();
    partComplete();
    searchPart();
});