var preview = function () {
    if ($("#J-button_print_view").click()) {
        bdhtml = window.document.body.innerHTML;  //获取当前页的html代码  
        sprnstr = "<!--startprint" + "begin" + "-->";  //设置打印开始区域  
        eprnstr = "<!--endprint" + "end" + "-->";  //设置打印结束区域  
        prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 18);  //从开始代码向后取html  

        prnhtmlprnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));  //从结束代码向前取html  
        window.document.body.innerHTML = prnhtml;
        window.print();
        window.document.body.innerHTML = bdhtml;
    } else if ($("#J-button_print").click()) {
        window.print();
    }

//    if ($("#J-button_print").click()) {
//        window.print();
//    }

};

$(document).ready(function () {
    preview();
});