$(function(){
    $("ul li").click(function () {
        var daohang = $(this);
        daohang.attr("class", "active").attr("style","").siblings().attr("class", "");
    });
});