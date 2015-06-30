//添加配件厂家
var addItem = function(){
    $("#J-item_save").click(function(){
        var item_name = $('#J-item_name').val();
        var item_code = $('#J-item_code').val();
        if(item_name.length === 0){
            alert("请填写配件厂家名称");
            return false;
        }else if(item_code.length === 0){
            alert("请填写配件厂家");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                headers: {
                    'X-Transaction': 'POST Example',
                    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                },
                url:  "/items",
                dateType: "json",
                cache: false,
                data: {
                    'item': {
                        'name': item_name,
                        'code': item_code
                    }
                },
                statusCode: {
                    201: function() {
                        window.location.href="/items";
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
var editItem = function(){
    $(".editItem").click(function(){
        var id = $("#J-item_id").val();
        window.location.href="/items/" + id + "/edit"
    })
};
//更新配件厂家
var updateItem = function(){
    $(".updateItem").click(function(){
        var item_name = $("#U-item_name").val();
        var item_code = $("#U-item_code").val();
        var item_id = $("#J-item_id").val();
        if (item_name.length ===0){
            alert("请输入配件厂家名称");
            return false;
        }else if(item_code.length ===0){
            alert("请输入配件厂家代码");
            return false;
        }else{
            $.ajax({
                url:"/items/" + item_id,
                headers:{
                    'X-Transaction':'POST Example',
                    'X-CSRF-Token':$('meta[name="csrf-token"]').attr('content')
                },
                dataType:"json",
                type:"PUT",
                data:{
                    'item':{
                        'name':item_name,
                        'code':item_code
                    }
                },
                statusCode:{
                    200:function () {
                        window.location.reload("/items");
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
//search items
var searchItem = function() {
    $("#items th a, #items .pagination a").live("click", function() {
        $.getScript(this.href);
        return false;
    });
    $("#items_search input").keyup(function() {
        $.get($("#items_search").attr("action"), $("#items_search").serialize(), null, "script");
        return false;
    });
};

$(document).ready(function(){
    addItem();
    editItem();
    updateItem();
    searchItem();
});